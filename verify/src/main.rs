//! GPU-vs-CPU verification for oscilla: render 8 chained audio blocks on the
//! GPU (state fed back between dispatches, exactly as the page will) and
//! compare against the CPU oracle; then a visual-kernel pixel sanity pass.

use oscilla_synth::{render_block, Patch, Voice, BLOCK};

fn main() {
    let (device, queue, module) = pollster::block_on(init());
    let patch = Patch::default_patch();
    let voices = [
        Voice { freq_hz: 220.0, gate_on_sample: 0, gate_off_sample: u32::MAX, active: 1 },
        Voice { freq_hz: 329.63, gate_on_sample: 200, gate_off_sample: 700, active: 1 },
        Voice { freq_hz: 440.0, gate_on_sample: 64, gate_off_sample: u32::MAX, active: 1 },
    ];

    // ---- audio: 8 chained blocks ----
    let audio_pipe = pipeline(&device, &module, "synth_audio_cs", &[false, false, true]);
    let voices_raw: Vec<u8> = voices
        .iter()
        .flat_map(|v| {
            let mut b = v.freq_hz.to_le_bytes().to_vec();
            b.extend(v.gate_on_sample.to_le_bytes());
            b.extend(v.gate_off_sample.to_le_bytes());
            b.extend(v.active.to_le_bytes());
            b
        })
        .collect();
    let voices_buf = storage(&device, &queue, &voices_raw);
    let out_buf = storage(&device, &queue, &vec![0u8; (BLOCK as usize + 1) * 4]);

    let mut gpu_state = 0.0f32;
    let mut cpu_state = 0.0f32;
    let mut worst = 0.0f32;
    let mut boundary_ok = true;
    let mut prev_last_gpu = 0.0f32;
    for blk in 0..8u32 {
        // params: Patch (12 f32) + block_start + n_voices + state_in + pad
        let mut praw = Vec::new();
        for f in [
            patch.osc_mix, patch.fm_ratio, patch.fm_depth, patch.cutoff_hz,
            patch.attack_s, patch.decay_s, patch.sustain, patch.release_s,
            patch.gain, 0.0, 0.0, 0.0,
        ] {
            praw.extend(f.to_le_bytes());
        }
        praw.extend((blk * BLOCK).to_le_bytes());
        praw.extend(3u32.to_le_bytes());
        praw.extend(gpu_state.to_le_bytes());
        praw.extend(0u32.to_le_bytes());
        let params_buf = storage(&device, &queue, &praw);
        let gpu_out = dispatch_read(
            &device, &queue, &audio_pipe,
            &[&params_buf, &voices_buf, &out_buf],
            (1, 1, 1), &out_buf,
        );
        let gpu_samples: &[f32] = bytemuck::cast_slice(&gpu_out);
        gpu_state = gpu_samples[BLOCK as usize];

        let mut cpu_block = [0.0f32; BLOCK as usize];
        cpu_state = render_block(&patch, &voices, 3, blk * BLOCK, cpu_state, &mut cpu_block);
        for i in 0..BLOCK as usize {
            worst = worst.max((gpu_samples[i] - cpu_block[i]).abs());
        }
        if blk > 0 && (gpu_samples[0] - prev_last_gpu).abs() > 0.2 {
            boundary_ok = false;
        }
        prev_last_gpu = gpu_samples[BLOCK as usize - 1];
    }
    let state_diff = (gpu_state - cpu_state).abs();
    println!("audio: 8 chained blocks, worst sample diff {worst:.2e}, final state diff {state_diff:.2e}, boundaries {}", if boundary_ok { "continuous" } else { "DISCONTINUOUS" });
    let audio_ok = worst < 1.0e-4 && state_diff < 1.0e-4 && boundary_ok;
    println!("audio: {}", if audio_ok { "PASS" } else { "FAIL" });

    // ---- visual: pixel sanity vs CPU ----
    let (w, h) = (320u32, 180u32);
    let vis_pipe = pipeline(&device, &module, "synth_visual_cs", &[false, false, false, true]);
    let vparams = storage(&device, &queue, bytemuck::cast_slice(&[w, h, 700u32, 3200u32]));
    let wave: Vec<f32> = (0..BLOCK).map(|i| (i as f32 / 20.0).sin() * 0.8).collect();
    let wave_arr: [f32; BLOCK as usize] = wave.clone().try_into().unwrap();
    let wave_buf = storage(&device, &queue, bytemuck::cast_slice(&wave));
    let prev_buf = storage(&device, &queue, &vec![0u8; (w * h * 3 * 4) as usize]); // zeros => no feedback term
    let vout = storage(&device, &queue, &vec![0u8; (w * h * 3 * 4) as usize]);
    let raw = dispatch_read(
        &device, &queue, &vis_pipe,
        &[&vparams, &wave_buf, &prev_buf, &vout],
        (w.div_ceil(8), h.div_ceil(8), 1), &vout,
    );
    let px: &[f32] = bytemuck::cast_slice(&raw);
    let mut vworst = 0.0f32;
    let aspect = w as f32 / h as f32;
    for (x, y) in [(0u32, 0u32), (160, 90), (319, 179), (80, 40)] {
        let uv = glam::vec2(
            (x as f32 / w as f32 * 2.0 - 1.0) * aspect,
            1.0 - y as f32 / h as f32 * 2.0,
        );
        let expect = oscilla_synth::visual_v3(uv, &wave_arr, glam::Vec3::ZERO, 3.2, 0.7);
        let base = ((y * w + x) * 3) as usize;
        for (k, e) in [expect.x, expect.y, expect.z].into_iter().enumerate() {
            vworst = vworst.max((px[base + k] - e).abs());
        }
    }
    println!("visual: worst sampled-pixel diff {vworst:.2e}: {}", if vworst < 1.0e-4 { "PASS" } else { "FAIL" });
    if !(audio_ok && vworst < 1.0e-4) {
        std::process::exit(1);
    }
}

async fn init() -> (wgpu::Device, wgpu::Queue, wgpu::ShaderModule) {
    let instance = wgpu::Instance::default();
    let adapter = instance
        .request_adapter(&wgpu::RequestAdapterOptions {
            power_preference: wgpu::PowerPreference::HighPerformance,
            ..Default::default()
        })
        .await
        .expect("no adapter");
    let pt = adapter.features().contains(wgpu::Features::PASSTHROUGH_SHADERS);
    let (device, queue) = adapter
        .request_device(&wgpu::DeviceDescriptor {
            label: None,
            required_features: if pt { wgpu::Features::PASSTHROUGH_SHADERS } else { wgpu::Features::empty() },
            ..Default::default()
        })
        .await
        .expect("device");
    let spv = std::fs::read(
        std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("../shaders/spv/oscilla_shaders.spv"),
    )
    .expect("run: cargo gpu build --shader-crate shaders --output-dir shaders/spv");
    let module = if pt {
        unsafe {
            device.create_shader_module_passthrough(wgpu::ShaderModuleDescriptorPassthrough {
                label: None,
                spirv: Some(wgpu::util::make_spirv_raw(&spv)),
                ..Default::default()
            })
        }
    } else {
        device.create_shader_module(wgpu::ShaderModuleDescriptor {
            label: None,
            source: wgpu::util::make_spirv(&spv),
        })
    };
    (device, queue, module)
}

fn pipeline(
    device: &wgpu::Device,
    module: &wgpu::ShaderModule,
    entry: &str,
    writable: &[bool],
) -> (wgpu::ComputePipeline, wgpu::BindGroupLayout) {
    let entries: Vec<wgpu::BindGroupLayoutEntry> = writable
        .iter()
        .enumerate()
        .map(|(i, w)| wgpu::BindGroupLayoutEntry {
            binding: i as u32,
            visibility: wgpu::ShaderStages::COMPUTE,
            ty: wgpu::BindingType::Buffer {
                ty: wgpu::BufferBindingType::Storage { read_only: !w },
                has_dynamic_offset: false,
                min_binding_size: None,
            },
            count: None,
        })
        .collect();
    let bgl = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
        label: None,
        entries: &entries,
    });
    let layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
        label: None,
        bind_group_layouts: &[Some(&bgl)],
        immediate_size: 0,
    });
    let p = device.create_compute_pipeline(&wgpu::ComputePipelineDescriptor {
        label: Some(entry),
        layout: Some(&layout),
        module,
        entry_point: Some(entry),
        compilation_options: Default::default(),
        cache: None,
    });
    (p, bgl)
}

fn storage(device: &wgpu::Device, queue: &wgpu::Queue, data: &[u8]) -> wgpu::Buffer {
    let buf = device.create_buffer(&wgpu::BufferDescriptor {
        label: None,
        size: data.len() as u64,
        usage: wgpu::BufferUsages::STORAGE | wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::COPY_SRC,
        mapped_at_creation: false,
    });
    queue.write_buffer(&buf, 0, data);
    buf
}

fn dispatch_read(
    device: &wgpu::Device,
    queue: &wgpu::Queue,
    (pipe, bgl): &(wgpu::ComputePipeline, wgpu::BindGroupLayout),
    bufs: &[&wgpu::Buffer],
    wg: (u32, u32, u32),
    read: &wgpu::Buffer,
) -> Vec<u8> {
    let entries: Vec<wgpu::BindGroupEntry> = bufs
        .iter()
        .enumerate()
        .map(|(i, b)| wgpu::BindGroupEntry {
            binding: i as u32,
            resource: b.as_entire_binding(),
        })
        .collect();
    let bind = device.create_bind_group(&wgpu::BindGroupDescriptor {
        label: None,
        layout: bgl,
        entries: &entries,
    });
    let staging = device.create_buffer(&wgpu::BufferDescriptor {
        label: None,
        size: read.size(),
        usage: wgpu::BufferUsages::MAP_READ | wgpu::BufferUsages::COPY_DST,
        mapped_at_creation: false,
    });
    let mut enc = device.create_command_encoder(&Default::default());
    {
        let mut pass = enc.begin_compute_pass(&Default::default());
        pass.set_pipeline(pipe);
        pass.set_bind_group(0, &bind, &[]);
        pass.dispatch_workgroups(wg.0, wg.1, wg.2);
    }
    enc.copy_buffer_to_buffer(read, 0, &staging, 0, read.size());
    queue.submit([enc.finish()]);
    let slice = staging.slice(..);
    slice.map_async(wgpu::MapMode::Read, |r| r.expect("map"));
    device.poll(wgpu::PollType::wait_indefinitely()).expect("poll");
    let v = slice.get_mapped_range().to_vec();
    staging.unmap();
    v
}
