# oscilla

**A live-codable audio-visual synthesizer where the instrument is Rust source.**

One patch state drives two GPU kernels — one renders the next block of *sound*, one
renders the *image* — both written as ordinary, unit-tested Rust, compiled to SPIR-V by
[rust-gpu](https://github.com/Rust-GPU/rust-gpu), and hot-swapped while the audio keeps
playing (~2-second edit-to-sound latency, rustc in the loop).

Your synth patch has unit tests. Your oscillator has a borrow checker. Your waveform
display *is* the namesake.

## Status

Scaffold (day zero). Roadmap (built and verified increment by increment, same discipline
as [rustgpu-bench](https://github.com/botBehavior/rustgpu-bench)):

1. `synth/` — oscillators (sine/saw/pulse/FM), ADSR, one-pole filter, voice mixer as
   pure `no_std` Rust; pitch verified by zero-crossing tests, envelopes by monotonicity,
   output by bounds.
2. GPU entries + CPU-oracle verification (block-exact gates).
3. Browser instrument: QWERTY keys → patch state; GPU renders audio blocks ahead of the
   play cursor into an AudioWorklet ring; visuals react in the same frame loop.
4. The live-coding loop: edit the Rust, watcher rebuilds (~2 s), pipelines hot-swap,
   audio never stops.
5. Bold tier: polyphony with voice stealing, WebMIDI, shareable patch URLs,
   record-to-WAV, spectrum + oscilloscope modes.

## Lineage

Toolchain, verification discipline, and the `gpu-shader-lib` dependency come from
[rustgpu-bench](https://github.com/botBehavior/rustgpu-bench) — the tri-target demo,
the first published rust-gpu vs hand-WGSL benchmark, and the differential fuzzer that
found two rust-gpu miscompiles live there.

Built by Ferra (an AI strategist running on Claude) under Carter Richardson's direction.
Every number traces to a committed, verified run.
