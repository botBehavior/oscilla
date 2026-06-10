//! oscilla synth kernels — pure functions, CPU-tested, GPU-compiled.
//! std on CPU (tests), no_std on SPIR-V. House rules: no recursion, no
//! checked math, bounded loops, u32/f32 data, stateless where possible.
//!
//! Architecture: the ADSR is CLOSED-FORM from gate-on/gate-off sample stamps
//! (no envelope state machine), so any sample can be computed independently.
//! Only the one-pole filter is stateful; `render_block` carries its state
//! through a serial loop — on GPU that maps to one thread per voice-block,
//! serial inside, parallel across voices and blocks.
#![cfg_attr(target_arch = "spirv", no_std)]

#[cfg(target_arch = "spirv")]
use spirv_std::num_traits::Float;

pub const SAMPLE_RATE: f32 = 48_000.0;
pub const BLOCK: u32 = 128;
const TAU: f32 = core::f32::consts::TAU;

// ---------- patch & voice state (repr(C), u32/f32 only) ----------

#[repr(C)]
#[derive(Clone, Copy)]
pub struct Patch {
    pub osc_mix: f32,   // 0 = pure FM-sine, 1 = pure saw
    pub fm_ratio: f32,  // modulator:carrier frequency ratio
    pub fm_depth: f32,  // radians of phase deviation
    pub cutoff_hz: f32, // one-pole lowpass cutoff
    pub attack_s: f32,
    pub decay_s: f32,
    pub sustain: f32, // 0..1
    pub release_s: f32,
    pub gain: f32,
    pub _pad0: f32,
    pub _pad1: f32,
    pub _pad2: f32,
}

impl Patch {
    pub fn default_patch() -> Self {
        Patch {
            osc_mix: 0.35,
            fm_ratio: 2.0,
            fm_depth: 1.5,
            cutoff_hz: 4_000.0,
            attack_s: 0.01,
            decay_s: 0.15,
            sustain: 0.6,
            release_s: 0.25,
            gain: 0.5,
            _pad0: 0.0,
            _pad1: 0.0,
            _pad2: 0.0,
        }
    }
}

/// One playing (or releasing) note. `gate_off_sample == u32::MAX` = held.
#[repr(C)]
#[derive(Clone, Copy)]
pub struct Voice {
    pub freq_hz: f32,
    pub gate_on_sample: u32,
    pub gate_off_sample: u32,
    pub active: u32, // 0 = slot free
}

// ---------- oscillators ----------

pub fn sine(freq_hz: f32, sample_index: u32) -> f32 {
    (TAU * freq_hz * sample_index as f32 / SAMPLE_RATE).sin()
}

/// Naive saw in [-1, 1) (polyBLEP is a bold-tier upgrade).
pub fn saw(freq_hz: f32, sample_index: u32) -> f32 {
    let t = freq_hz * sample_index as f32 / SAMPLE_RATE;
    2.0 * (t - (t + 0.5).floor())
}

/// Two-operator FM: carrier phase-modulated by one modulator.
pub fn fm(freq_hz: f32, ratio: f32, depth: f32, sample_index: u32) -> f32 {
    let t = sample_index as f32 / SAMPLE_RATE;
    let modulator = (TAU * freq_hz * ratio * t).sin();
    (TAU * freq_hz * t + depth * modulator).sin()
}

// ---------- envelope (closed-form ADSR) ----------

/// Amplitude at absolute `sample` for a gate opened at `on` and closed at
/// `off` (u32::MAX = still held). Stateless; release decays from the level
/// the envelope had at the moment of release (computed recursively-free).
pub fn adsr(p: &Patch, sample: u32, on: u32, off: u32) -> f32 {
    if sample < on {
        return 0.0;
    }
    let t = (sample - on) as f32 / SAMPLE_RATE;
    let held_level = |t: f32| -> f32 {
        if t < p.attack_s {
            t / p.attack_s.max(1.0e-5)
        } else {
            let td = t - p.attack_s;
            if td < p.decay_s {
                1.0 + (p.sustain - 1.0) * (td / p.decay_s.max(1.0e-5))
            } else {
                p.sustain
            }
        }
    };
    if off == u32::MAX || sample < off {
        held_level(t)
    } else {
        let t_off = (off - on) as f32 / SAMPLE_RATE;
        let level_at_release = held_level(t_off);
        let tr = (sample - off) as f32 / SAMPLE_RATE;
        let k = 1.0 - (tr / p.release_s.max(1.0e-5));
        if k > 0.0 {
            level_at_release * k
        } else {
            0.0
        }
    }
}

// ---------- filter (one-pole lowpass, stateful) ----------

pub fn onepole_coeff(cutoff_hz: f32) -> f32 {
    // standard one-pole: a = 1 - exp(-tau * fc / fs), clamped for stability
    let a = 1.0 - (-TAU * cutoff_hz / SAMPLE_RATE).exp();
    a.clamp(0.0, 1.0)
}

pub fn onepole_step(state: f32, x: f32, a: f32) -> f32 {
    state + a * (x - state)
}

// ---------- voice + block rendering ----------

/// One voice's raw (pre-filter) sample.
pub fn voice_sample(p: &Patch, v: &Voice, sample: u32) -> f32 {
    if v.active == 0 {
        return 0.0;
    }
    let env = adsr(p, sample, v.gate_on_sample, v.gate_off_sample);
    if env <= 0.0 {
        return 0.0;
    }
    let tone = fm(v.freq_hz, p.fm_ratio, p.fm_depth, sample) * (1.0 - p.osc_mix)
        + saw(v.freq_hz, sample) * p.osc_mix;
    tone * env
}

/// Soft clip keeps the mix bounded whatever the voice count.
pub fn soft_clip(x: f32) -> f32 {
    x / (1.0 + x.abs())
}

/// Render BLOCK samples starting at `block_start`, mixing `voices`, carrying
/// the filter state in/out. CPU oracle and GPU kernel share this exact code.
pub fn render_block(
    p: &Patch,
    voices: &[Voice],
    block_start: u32,
    filter_state_in: f32,
    out: &mut [f32],
) -> f32 {
    let a = onepole_coeff(p.cutoff_hz);
    let mut state = filter_state_in;
    let mut i = 0u32;
    while i < BLOCK {
        let s = block_start + i;
        let mut mix = 0.0f32;
        let mut vi = 0usize;
        while vi < voices.len() {
            mix += voice_sample(p, &voices[vi], s);
            vi += 1;
        }
        state = onepole_step(state, soft_clip(mix * p.gain), a);
        out[i as usize] = state;
        i += 1;
    }
    state
}

// ---------- visual kernel (placeholder: level -> color ramp) ----------

/// Day-zero visual: maps (uv.y vs recent waveform, level) to a color.
/// Replaced by gpu-shader-lib composition in the page milestone.
pub fn visual_pixel(uv_x: f32, uv_y: f32, wave_at_x: f32, level: f32) -> [f32; 3] {
    let d = (uv_y - wave_at_x * 0.8).abs();
    let line = (-60.0 * d).exp();
    let glow = (-6.0 * d).exp() * level;
    [
        (0.9 * line + 0.8 * glow).min(1.0),
        (0.5 * line + 0.3 * glow + 0.05 * uv_x.abs()).min(1.0),
        (0.2 * line + 0.6 * glow).min(1.0),
    ]
}

#[cfg(test)]
mod tests {
    use super::*;

    fn patch() -> Patch {
        Patch::default_patch()
    }

    fn zero_crossings(f: impl Fn(u32) -> f32) -> u32 {
        let mut count = 0;
        let mut prev = f(0);
        for i in 1..SAMPLE_RATE as u32 {
            let v = f(i);
            if prev < 0.0 && v >= 0.0 {
                count += 1;
            }
            prev = v;
        }
        count
    }

    #[test]
    fn oscillator_pitch() {
        assert!((439..=441).contains(&zero_crossings(|i| sine(440.0, i))));
        assert!((219..=221).contains(&zero_crossings(|i| saw(220.0, i))));
        // FM with zero depth degenerates to a pure carrier
        assert!((329..=331).contains(&zero_crossings(|i| fm(330.0, 2.0, 0.0, i))));
    }

    #[test]
    fn adsr_shape() {
        let p = patch();
        let on = 1000u32;
        let atk_end = on + (p.attack_s * SAMPLE_RATE) as u32;
        // monotone non-decreasing through attack
        let mut prev = -1.0f32;
        for s in (on..atk_end).step_by(7) {
            let e = adsr(&p, s, on, u32::MAX);
            assert!(e >= prev - 1e-6, "attack must rise");
            prev = e;
        }
        // settles at sustain after decay
        let settled = atk_end + (p.decay_s * SAMPLE_RATE) as u32 + 100;
        assert!((adsr(&p, settled, on, u32::MAX) - p.sustain).abs() < 1e-3);
        // zero before gate, zero after full release
        assert_eq!(adsr(&p, on - 1, on, u32::MAX), 0.0);
        let off = settled + 500;
        let dead = off + (p.release_s * SAMPLE_RATE) as u32 + 10;
        assert_eq!(adsr(&p, dead, on, off), 0.0);
        // release decays from the sustained level
        let mid_release = off + (p.release_s * SAMPLE_RATE * 0.5) as u32;
        let e = adsr(&p, mid_release, on, off);
        assert!(e > 0.0 && e < p.sustain);
    }

    #[test]
    fn filter_attenuates_highs() {
        let mut p = patch();
        p.cutoff_hz = 500.0;
        let a = onepole_coeff(p.cutoff_hz);
        let rms = |freq: f32| {
            let mut state = 0.0f32;
            let mut acc = 0.0f64;
            for i in 0..48_000u32 {
                state = onepole_step(state, sine(freq, i), a);
                if i > 4_800 {
                    acc += (state * state) as f64;
                }
            }
            (acc / 43_200.0).sqrt()
        };
        let low = rms(100.0);
        let high = rms(8_000.0);
        assert!(low > high * 4.0, "lowpass: low {low:.3} vs high {high:.3}");
    }

    #[test]
    fn block_render_bounded_and_continuous() {
        let p = patch();
        let voices = [
            Voice { freq_hz: 220.0, gate_on_sample: 0, gate_off_sample: u32::MAX, active: 1 },
            Voice { freq_hz: 277.18, gate_on_sample: 64, gate_off_sample: u32::MAX, active: 1 },
            Voice { freq_hz: 0.0, gate_on_sample: 0, gate_off_sample: 0, active: 0 },
        ];
        let mut block_a = [0.0f32; BLOCK as usize];
        let mut block_b = [0.0f32; BLOCK as usize];
        let s1 = render_block(&p, &voices, 0, 0.0, &mut block_a);
        let _ = render_block(&p, &voices, BLOCK, s1, &mut block_b);
        for v in block_a.iter().chain(block_b.iter()) {
            assert!(v.abs() <= 1.0, "soft-clipped mix must stay in [-1,1]");
        }
        // continuity across the block boundary: no jump larger than within-block max step
        let max_step = block_a
            .windows(2)
            .map(|w| (w[1] - w[0]).abs())
            .fold(0.0f32, f32::max);
        let boundary_step = (block_b[0] - block_a[BLOCK as usize - 1]).abs();
        assert!(
            boundary_step <= max_step * 2.0 + 1e-4,
            "block boundary discontinuity: {boundary_step} vs max in-block {max_step}"
        );
    }

    #[test]
    fn determinism() {
        let p = patch();
        let v = [Voice { freq_hz: 440.0, gate_on_sample: 0, gate_off_sample: u32::MAX, active: 1 }];
        let mut a = [0.0f32; BLOCK as usize];
        let mut b = [0.0f32; BLOCK as usize];
        render_block(&p, &v, 512, 0.1, &mut a);
        render_block(&p, &v, 512, 0.1, &mut b);
        assert_eq!(a, b);
    }
}
