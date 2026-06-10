//! oscilla synth kernels - pure functions, CPU-tested, GPU-compiled.
//! std on CPU (tests), no_std on SPIR-V. House rules: no recursion, no
//! checked math, bounded loops, u32/f32 data, stateless where possible.
//!
//! Architecture: the ADSR is CLOSED-FORM from gate-on/gate-off sample stamps
//! (no envelope state machine), so any sample can be computed independently.
//! Only the one-pole filter is stateful; `render_block` carries its state
//! through a serial loop - on GPU that maps to one thread per voice-block,
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

/// Phase-domain voice (the realtime path): both phases are kept wrapped to
/// [0, TAU) by the caller's accumulator, so the sine argument never grows
/// large and never loses precision — the cure for FM "chaotic crackling".
/// `carrier_phase` doubles as the saw ramp.
pub fn osc_at_phase(p: &Patch, carrier_phase: f32, mod_phase: f32, depth: f32) -> f32 {
    let modulator = mod_phase.sin();
    let fm = (carrier_phase + depth * modulator).sin();
    let saw = carrier_phase / core::f32::consts::PI - 1.0; // [0,TAU) -> [-1,1)
    fm * (1.0 - p.osc_mix) + saw * p.osc_mix
}

/// Wrap a positive-advancing phase back into [0, TAU).
pub fn wrap_phase(mut ph: f32) -> f32 {
    while ph >= TAU {
        ph -= TAU;
    }
    ph
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

/// Render BLOCK samples starting at `block_start`, mixing the first
/// `n_voices` of `voices`, carrying the filter state in/out. CPU oracle and
/// GPU kernel share this exact code. (Takes count instead of a subslice:
/// slicing a slice is pointer arithmetic, illegal on logical SPIR-V.)
pub fn render_block(
    p: &Patch,
    voices: &[Voice],
    n_voices: u32,
    block_start: u32,
    filter_state_in: f32,
    out: &mut [f32; BLOCK as usize], // fixed array: unsizing coercion doesn't lower to SPIR-V
) -> f32 {
    let a = onepole_coeff(p.cutoff_hz);
    let mut state = filter_state_in;
    let n = (n_voices as usize).min(voices.len());
    let mut i = 0u32;
    while i < BLOCK {
        let s = block_start + i;
        let mut mix = 0.0f32;
        let mut vi = 0usize;
        while vi < n {
            mix += voice_sample(p, &voices[vi], s);
            vi += 1;
        }
        state = onepole_step(state, soft_clip(mix * p.gain), a);
        out[i as usize] = state;
        i += 1;
    }
    state
}

// ---------- spectrum (Goertzel per bin — no FFT needed at BLOCK=128) ----------

/// Magnitude of frequency bin `bin` of `n_bins` (log-spaced 80 Hz..8 kHz)
/// over one block. Pure + bounded: ideal GPU per-column work.
pub fn spectrum_bin(wave: &[f32; BLOCK as usize], bin: u32, n_bins: u32) -> f32 {
    let f_lo = 80.0f32;
    let f_hi = 8_000.0f32;
    let t = bin as f32 / (n_bins.max(2) - 1) as f32;
    let freq = f_lo * (f_hi / f_lo).powf(t);
    let w = TAU * freq / SAMPLE_RATE;
    let coeff = 2.0 * w.cos();
    let mut s_prev = 0.0f32;
    let mut s_prev2 = 0.0f32;
    let mut i = 0usize;
    while i < BLOCK as usize {
        let s = wave[i] + coeff * s_prev - s_prev2;
        s_prev2 = s_prev;
        s_prev = s;
        i += 1;
    }
    let power = s_prev * s_prev + s_prev2 * s_prev2 - coeff * s_prev * s_prev2;
    (power.max(0.0)).sqrt() * (2.0 / BLOCK as f32)
}

// ---------- visual engine v2: full-bleed audio-reactive composite ----------

use glam::{vec2, vec3, Vec2, Vec3};
use gpu_shader_lib::{color, noise};

/// Where should this pixel's feedback come from? A slow zoom-in + rotation
/// (bass widens the zoom, mids speed the spin) — re-sampling the previous
/// frame through this transform is what turns motion into hypnotic trails.
pub fn feedback_uv(uv: Vec2, bass: f32, mid: f32) -> Vec2 {
    let zoom = 0.982 - bass * 0.015;
    let ang = 0.004 + mid * 0.01;
    let (s, c) = (ang.sin(), ang.cos());
    vec2(uv.x * c - uv.y * s, uv.x * s + uv.y * c) * zoom
}

pub fn audio_features(wave: &[f32; BLOCK as usize]) -> (f32, f32, f32) {
    (
        spectrum_bin(wave, 5, 32),
        spectrum_bin(wave, 16, 32),
        spectrum_bin(wave, 26, 32),
    )
}

/// The face of the instrument, v3: a circular oscilloscope ring whose radius
/// is the waveform, floating in a palette nebula that breathes with the bass,
/// all dissolving into feedback trails (`prev` = last frame sampled through
/// `feedback_uv`). Alive at silence; eruptive when played.
pub fn visual_v3(
    uv: Vec2,
    wave: &[f32; BLOCK as usize],
    prev: Vec3,
    t: f32,
    level: f32,
) -> Vec3 {
    let (bass, mid, high) = audio_features(wave);
    let r = uv.length();
    let theta = uv.y.atan2(uv.x);

    // nebula field, polar-swirled
    let swirl = vec2(
        r * (theta + t * 0.07 + mid * 1.5).cos(),
        r * (theta + t * 0.07 + mid * 1.5).sin(),
    );
    let n = noise::fbm2(swirl * (1.6 + mid * 2.0) + vec2(t * 0.06, -t * 0.045), 5, 7);
    let base = color::palette_rainbow(n * 0.5 + theta * 0.10 + t * 0.025 + high * 1.2);
    let edge_fade = (1.15 - r).clamp(0.0, 1.0);
    let mut col = base * (0.05 + 0.40 * level + bass * 0.9) * edge_fade;

    // circular oscilloscope: waveform bends the ring's radius
    let frac = (theta / TAU + 0.5).clamp(0.0, 0.999);
    let wi = (frac * (BLOCK - 1) as f32) as usize;
    let ring_r = 0.45 + wave[wi] * 0.22 + bass * 0.06;
    let ring = (-55.0 * (r - ring_r).abs()).exp();
    col += vec3(0.95, 1.0, 0.92) * ring * (0.35 + level * 1.2);
    col += base * (-7.0 * (r - ring_r).abs()).exp() * (0.2 + level);

    // treble flare from the core
    col += color::palette_rainbow(t * 0.05 + 0.6) * high * (-4.5 * r).exp() * 1.5;

    // feedback trails: previous frame decays in, bass holds the echo longer
    let fed = col + prev * (0.60 + bass * 0.12).min(0.80);
    color::srgb_encode(color::tonemap_aces(fed))
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
    fn phase_osc_stays_clean_at_any_phase() {
        // the whole point: bounded phase => bounded output, forever
        let p = Patch::default_patch();
        let mut ph = 0.0f32;
        let mut mph = 0.0f32;
        let inc = TAU * 880.0 / SAMPLE_RATE; // a high note
        let minc = inc * 2.0;
        let mut prev = osc_at_phase(&p, ph, mph, 1.5);
        // advance a simulated 10 minutes of samples; output must stay bounded
        // and continuous (no precision blowup because phases wrap)
        for _ in 0..(SAMPLE_RATE as u32 * 600) {
            ph = wrap_phase(ph + inc);
            mph = wrap_phase(mph + minc);
            let s = osc_at_phase(&p, ph, mph, 1.5);
            assert!(s.is_finite() && s.abs() <= 1.0);
            // < 0.9 separates the saw's legit once-per-cycle edge (~0.5 at this
            // mix) from precision blowup (near-random ⇒ jumps approach 2.0)
            assert!((s - prev).abs() < 0.9, "precision blowup: jump {}", (s - prev).abs());
            prev = s;
        }
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
        let s1 = render_block(&p, &voices, 3, 0, 0.0, &mut block_a);
        let _ = render_block(&p, &voices, 3, BLOCK, s1, &mut block_b);
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
    fn visual_v3_finite_reactive_and_trailing() {
        let mut loud = [0.0f32; BLOCK as usize];
        for (i, w) in loud.iter_mut().enumerate() {
            *w = sine(220.0, i as u32) * 0.8;
        }
        let silent = [0.0f32; BLOCK as usize];
        let mut sum_loud = 0.0f32;
        let mut sum_silent = 0.0f32;
        for (x, y) in [(-0.7, -0.4), (0.1, 0.05), (0.5, 0.3), (0.45, -0.1)] {
            let uv = vec2(x, y);
            let cl = visual_v3(uv, &loud, Vec3::ZERO, 3.2, 0.7);
            let cs = visual_v3(uv, &silent, Vec3::ZERO, 3.2, 0.0);
            for c in [cl, cs] {
                for ch in [c.x, c.y, c.z] {
                    assert!(ch.is_finite() && (0.0..=1.0 + 1e-4).contains(&ch), "bad {ch}");
                }
            }
            sum_loud += cl.x + cl.y + cl.z;
            sum_silent += cs.x + cs.y + cs.z;
        }
        assert!(
            sum_loud > sum_silent * 1.3,
            "playing must be visibly brighter: {sum_loud} vs {sum_silent}"
        );
        // feedback: a bright previous pixel must leave a visible echo
        let uv = vec2(0.3, 0.2);
        let with_prev = visual_v3(uv, &silent, vec3(0.8, 0.8, 0.8), 3.2, 0.0);
        let without = visual_v3(uv, &silent, Vec3::ZERO, 3.2, 0.0);
        assert!(
            (with_prev.x + with_prev.y + with_prev.z) > (without.x + without.y + without.z) + 0.3,
            "trails must persist"
        );
        // feedback transform contracts (zoom < 1) so trails spiral inward
        assert!(feedback_uv(vec2(0.5, 0.5), 0.0, 0.0).length() < vec2(0.5, 0.5).length());
    }

    #[test]
    fn spectrum_peaks_at_the_right_bin() {
        // 1 kHz sine: find which log-spaced bin (of 32) holds the peak
        let mut wave = [0.0f32; BLOCK as usize];
        for (i, w) in wave.iter_mut().enumerate() {
            *w = sine(1000.0, i as u32);
        }
        let mags: Vec<f32> = (0..32).map(|b| spectrum_bin(&wave, b, 32)).collect();
        let peak_bin = mags
            .iter()
            .enumerate()
            .max_by(|a, b| a.1.partial_cmp(b.1).unwrap())
            .unwrap()
            .0;
        // expected bin: log position of 1 kHz in 80..8000 over 32 bins ≈ 17
        let expect = ((1000.0f32 / 80.0).ln() / (8000.0f32 / 80.0).ln() * 31.0).round() as usize;
        assert!(
            (peak_bin as i32 - expect as i32).abs() <= 1,
            "peak at bin {peak_bin}, expected ~{expect}"
        );
    }

    #[test]
    fn determinism() {
        let p = patch();
        let v = [Voice { freq_hz: 440.0, gate_on_sample: 0, gate_off_sample: u32::MAX, active: 1 }];
        let mut a = [0.0f32; BLOCK as usize];
        let mut b = [0.0f32; BLOCK as usize];
        render_block(&p, &v, 1, 512, 0.1, &mut a);
        render_block(&p, &v, 1, 512, 0.1, &mut b);
        assert_eq!(a, b);
    }
}
