//! Reproduce the "chaotic crackling": is the block clean at high sample
//! cursors (tens of seconds into a performance)?
use oscilla_synth::{render_block, Patch, Voice, BLOCK};

fn clean_at(cursor: u32) -> (f32, f32) {
    let p = Patch::default_patch();
    let v = [Voice { freq_hz: 261.63, gate_on_sample: 0, gate_off_sample: u32::MAX, active: 1 }];
    let mut out = [0.0f32; BLOCK as usize];
    render_block(&p, &v, 1, cursor, 0.0, &mut out);
    let max_step = out.windows(2).map(|w| (w[1] - w[0]).abs()).fold(0.0, f32::max);
    let peak = out.iter().map(|s| s.abs()).fold(0.0, f32::max);
    (peak, max_step)
}

#[test]
fn audio_stays_clean_over_time() {
    // a 261 Hz tone steps ~0.034 between adjacent samples at most; crackle =
    // huge sample-to-sample jumps from f32 sin precision collapse
    for secs in [0u32, 1, 5, 10, 30, 60] {
        let (peak, step) = clean_at(secs * 48_000);
        println!("t={secs}s peak={peak:.3} max_step={step:.3}");
        assert!(peak <= 1.0, "t={secs}s peak {peak}");
        assert!(step < 0.15, "t={secs}s CRACKLE: max_step {step} (clean tone < 0.15)");
    }
}
