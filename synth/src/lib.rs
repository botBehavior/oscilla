//! oscilla synth kernels — pure functions, sample-index in, sample out.
//! std on CPU (tests), no_std on SPIR-V. No recursion, no checked math,
//! bounded loops, u32/f32 data only: the SPIR-V house rules.
#![cfg_attr(target_arch = "spirv", no_std)]

#[cfg(target_arch = "spirv")]
use spirv_std::num_traits::Float;

pub const SAMPLE_RATE: f32 = 48_000.0;
const TAU: f32 = core::f32::consts::TAU;

/// Naive sine oscillator: phase in samples.
pub fn sine(freq_hz: f32, sample_index: u32) -> f32 {
    (TAU * freq_hz * sample_index as f32 / SAMPLE_RATE).sin()
}

/// Band-unlimited saw in [-1, 1) (aliasing accepted at day zero; polyBLEP later).
pub fn saw(freq_hz: f32, sample_index: u32) -> f32 {
    let t = freq_hz * sample_index as f32 / SAMPLE_RATE;
    2.0 * (t - (t + 0.5).floor()) // wraps to [-1, 1)
}

#[cfg(test)]
mod tests {
    use super::*;

    /// Count rising zero-crossings over one second of samples => frequency.
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
    fn sine_pitch_is_correct() {
        let n = zero_crossings(|i| sine(440.0, i));
        assert!((439..=441).contains(&n), "440 Hz sine crossed {n} times");
    }

    #[test]
    fn saw_pitch_is_correct() {
        let n = zero_crossings(|i| saw(220.0, i));
        assert!((219..=221).contains(&n), "220 Hz saw crossed {n} times");
    }

    #[test]
    fn outputs_bounded() {
        for i in 0..10_000 {
            assert!(sine(883.7, i).abs() <= 1.0);
            assert!(saw(127.3, i).abs() <= 1.0);
        }
    }
}
