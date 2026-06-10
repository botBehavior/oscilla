//! oscilla GPU entry points — thin wrappers over oscilla_synth.
//!
//! Audio: ONE thread renders one 128-sample block serially (the one-pole
//! filter is a serial recurrence; a block is tiny; the page dispatches one
//! block per audio quantum anyway). out[0..BLOCK] = samples, out[BLOCK] =
//! filter state out (fed back in by the host next dispatch).
//! Visuals: fully parallel, reads the freshest audio block as a waveform.
#![no_std]

use oscilla_synth::{audio_features, feedback_uv, render_block, visual_v3, Patch, Voice, BLOCK};
use spirv_std::glam::{vec2, vec3, UVec3};
use spirv_std::spirv;

/// repr(C), u32/f32 only: patch + block meta + filter state in.
#[repr(C)]
#[derive(Clone, Copy)]
pub struct AudioParams {
    pub patch: Patch,      // 12 f32s
    pub block_start: u32,
    pub n_voices: u32,
    pub filter_state_in: f32,
    pub _pad: u32,
}

#[spirv(compute(threads(1)))]
pub fn synth_audio_cs(
    #[spirv(storage_buffer, descriptor_set = 0, binding = 0)] params: &AudioParams,
    #[spirv(storage_buffer, descriptor_set = 0, binding = 1)] voices: &[Voice],
    #[spirv(storage_buffer, descriptor_set = 0, binding = 2)] out: &mut [f32],
) {
    let mut block = [0.0f32; BLOCK as usize];
    let state_out = render_block(
        &params.patch,
        voices,
        params.n_voices,
        params.block_start,
        params.filter_state_in,
        &mut block,
    );
    let mut i = 0usize;
    while i < BLOCK as usize {
        out[i] = block[i];
        i += 1;
    }
    out[BLOCK as usize] = state_out;
}

/// vparams = [width, height, level_milli, time_ms]. `prev` is last frame's
/// output (ping-ponged by the host); sampled through the feedback transform
/// for motion trails.
#[spirv(compute(threads(8, 8)))]
pub fn synth_visual_cs(
    #[spirv(global_invocation_id)] id: UVec3,
    #[spirv(storage_buffer, descriptor_set = 0, binding = 0)] vparams: &[u32; 4],
    #[spirv(storage_buffer, descriptor_set = 0, binding = 1)] wave: &[f32; BLOCK as usize],
    #[spirv(storage_buffer, descriptor_set = 0, binding = 2)] prev: &[f32],
    #[spirv(storage_buffer, descriptor_set = 0, binding = 3)] out: &mut [f32],
) {
    let w = vparams[0];
    let h = vparams[1];
    if id.x >= w || id.y >= h {
        return;
    }
    let aspect = w as f32 / h as f32;
    let uv = vec2(
        (id.x as f32 / w as f32 * 2.0 - 1.0) * aspect,
        1.0 - id.y as f32 / h as f32 * 2.0,
    );
    let level = vparams[2] as f32 * 1.0e-3;
    let t = vparams[3] as f32 * 1.0e-3;

    // fetch previous frame through the zoom-rotate transform
    let (bass, mid, _) = audio_features(wave);
    let src = feedback_uv(uv, bass, mid);
    let sx = ((src.x / aspect + 1.0) * 0.5 * w as f32) as i32;
    let sy = ((1.0 - src.y) * 0.5 * h as f32) as i32;
    let prev_col = if sx >= 0 && sx < w as i32 && sy >= 0 && sy < h as i32 {
        let pbase = ((sy as u32 * w + sx as u32) * 3) as usize;
        vec3(prev[pbase], prev[pbase + 1], prev[pbase + 2])
    } else {
        vec3(0.0, 0.0, 0.0)
    };

    let c = visual_v3(uv, wave, prev_col, t, level);
    let base = ((id.y * w + id.x) * 3) as usize;
    out[base] = c.x;
    out[base + 1] = c.y;
    out[base + 2] = c.z;
}
