//! The audio engine, compiled to wasm32 and instantiated INSIDE the
//! AudioWorklet thread. Samples are rendered directly into worklet memory —
//! no GPU readback, no transport, no ring buffer to lap. Distortion by
//! plumbing is structurally impossible; if it sounds wrong now, it's the
//! synthesis math, which has unit tests.
//!
//! Raw C ABI (no bindgen): the worklet drives it with a handful of exports.

use oscilla_synth::{
    adsr, onepole_coeff, onepole_step, osc_at_phase, soft_clip, spectrum_bin, wrap_phase, Patch,
    Voice, BLOCK, SAMPLE_RATE,
};

const NVOICES: usize = 8;
const TAU: f32 = core::f32::consts::TAU;

struct Engine {
    patch: Patch,
    voices: [Voice; NVOICES],
    // per-voice accumulating phase (carrier, modulator) — kept wrapped so the
    // sine argument never grows: the fix for FM chaotic-crackling at speed
    carrier_phase: [f32; NVOICES],
    mod_phase: [f32; NVOICES],
    filter_state: f32,
    out: [f32; BLOCK as usize],
    feats: [f32; 4], // bass, mid, high, level
}

static mut ENGINE: Option<Engine> = None;

fn engine() -> &'static mut Engine {
    unsafe {
        #[allow(static_mut_refs)]
        ENGINE.get_or_insert_with(|| Engine {
            patch: Patch::default_patch(),
            voices: [Voice {
                freq_hz: 0.0,
                gate_on_sample: 0,
                gate_off_sample: 0,
                active: 0,
            }; NVOICES],
            carrier_phase: [0.0; NVOICES],
            mod_phase: [0.0; NVOICES],
            filter_state: 0.0,
            out: [0.0; BLOCK as usize],
            feats: [0.0; 4],
        })
    }
}

/// Param order matches the page's PARAMS list.
#[no_mangle]
pub extern "C" fn set_param(idx: u32, v: f32) {
    let p = &mut engine().patch;
    match idx {
        0 => p.osc_mix = v,
        1 => p.fm_ratio = v,
        2 => p.fm_depth = v,
        3 => p.cutoff_hz = v,
        4 => p.attack_s = v,
        5 => p.decay_s = v,
        6 => p.sustain = v,
        7 => p.release_s = v,
        _ => p.gain = v,
    }
}

#[no_mangle]
pub extern "C" fn note_on(slot: u32, freq_hz: f32, cursor: u32) {
    let e = engine();
    let s = (slot as usize).min(NVOICES - 1);
    e.voices[s] = Voice {
        freq_hz,
        gate_on_sample: cursor,
        gate_off_sample: u32::MAX,
        active: 1,
    };
    // reset phase so the note starts at zero crossing (no click on retrigger)
    e.carrier_phase[s] = 0.0;
    e.mod_phase[s] = 0.0;
}

#[no_mangle]
pub extern "C" fn note_off(slot: u32, cursor: u32) {
    let e = engine();
    let s = (slot as usize).min(NVOICES - 1);
    if e.voices[s].active == 1 {
        e.voices[s].gate_off_sample = cursor;
    }
}

/// Render BLOCK samples at `cursor` into the internal buffer; returns its ptr.
/// Realtime path: per-voice phase accumulation, wrapped every cycle.
#[no_mangle]
pub extern "C" fn render(cursor: u32) -> *const f32 {
    let e = engine();
    let p = e.patch;
    let a = onepole_coeff(p.cutoff_hz);
    let mut state = e.filter_state;
    let mut i = 0u32;
    while i < BLOCK {
        let s = cursor + i;
        let mut mix = 0.0f32;
        let mut v = 0usize;
        while v < NVOICES {
            let voice = e.voices[v];
            if voice.active != 0 {
                let env = adsr(&p, s, voice.gate_on_sample, voice.gate_off_sample);
                if env > 0.0 {
                    mix += osc_at_phase(&p, e.carrier_phase[v], e.mod_phase[v], p.fm_depth) * env;
                }
                // advance phase regardless so a held note stays coherent
                let inc = TAU * voice.freq_hz / SAMPLE_RATE;
                e.carrier_phase[v] = wrap_phase(e.carrier_phase[v] + inc);
                e.mod_phase[v] = wrap_phase(e.mod_phase[v] + inc * p.fm_ratio);
            }
            v += 1;
        }
        state = onepole_step(state, soft_clip(mix * p.gain), a);
        e.out[i as usize] = state;
        i += 1;
    }
    e.filter_state = state;
    e.out.as_ptr()
}

/// Audio features of the most recent block: [bass, mid, high, level].
#[no_mangle]
pub extern "C" fn features() -> *const f32 {
    let e = engine();
    e.feats[0] = spectrum_bin(&e.out, 5, 32);
    e.feats[1] = spectrum_bin(&e.out, 16, 32);
    e.feats[2] = spectrum_bin(&e.out, 26, 32);
    let mut acc = 0.0f32;
    for v in e.out.iter() {
        acc += v * v;
    }
    e.feats[3] = (acc / BLOCK as f32).sqrt();
    e.feats.as_ptr()
}
