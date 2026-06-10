//! oscilla GPU entry points — thin wrappers over oscilla_synth.
//!
//! Audio: ONE thread renders one 128-sample block serially (the one-pole
//! filter is a serial recurrence; a block is tiny; the page dispatches one
//! block per audio quantum anyway). out[0..BLOCK] = samples, out[BLOCK] =
//! filter state out (fed back in by the host next dispatch).
//! Visuals: fully parallel, reads the freshest audio block as a waveform.
#![no_std]

use oscilla_synth::{render_block, visual_pixel, Patch, Voice, BLOCK};
use spirv_std::glam::UVec3;
use spirv_std::num_traits::Float;
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

/// vparams = [width, height, level_milli, mode (0 = scope, 1 = spectrum)].
#[spirv(compute(threads(8, 8)))]
pub fn synth_visual_cs(
    #[spirv(global_invocation_id)] id: UVec3,
    #[spirv(storage_buffer, descriptor_set = 0, binding = 0)] vparams: &[u32; 4],
    #[spirv(storage_buffer, descriptor_set = 0, binding = 1)] wave: &[f32; BLOCK as usize],
    #[spirv(storage_buffer, descriptor_set = 0, binding = 2)] out: &mut [f32],
) {
    let w = vparams[0];
    let h = vparams[1];
    if id.x >= w || id.y >= h {
        return;
    }
    let uv_x = id.x as f32 / w as f32 * 2.0 - 1.0;
    let uv_y = 1.0 - id.y as f32 / h as f32 * 2.0;
    let level = vparams[2] as f32 * 1.0e-3;
    let c = if vparams[3] == 1 {
        // spectrum: 32 log-spaced bars, bar height = Goertzel magnitude
        let n_bins = 32u32;
        let bin = ((id.x as f32 / w as f32) * n_bins as f32) as u32;
        let mag = oscilla_synth::spectrum_bin(wave, bin.min(n_bins - 1), n_bins);
        let bar_h = (mag * 4.0).min(1.0) * 1.8 - 0.9; // map to uv space
        let lit = if uv_y < bar_h { 1.0 } else { (-14.0 * (uv_y - bar_h)).exp() * 0.6 };
        let hue = bin as f32 / n_bins as f32;
        [lit * (0.3 + 0.7 * hue), lit * 0.9 * (1.0 - hue * 0.5), lit * (0.9 - 0.6 * hue)]
    } else {
        let wi = ((id.x as f32 / w as f32) * (BLOCK - 1) as f32) as usize;
        visual_pixel(uv_x, uv_y, wave[wi], level)
    };
    let base = ((id.y * w + id.x) * 3) as usize;
    out[base] = c[0];
    out[base + 1] = c[1];
    out[base + 2] = c[2];
}
