# Build oscilla web artifacts: WGSL-constrained SPIR-V -> kernels.wgsl
$ErrorActionPreference = "Stop"
$repo = Split-Path $PSScriptRoot -Parent
cargo gpu build --shader-crate "$repo\shaders" --output-dir "$repo\shaders\wgsl" --target spirv-unknown-naga-wgsl --auto-install-rust-toolchain
naga "$repo\shaders\wgsl\oscilla_shaders.spv" "$PSScriptRoot\kernels.wgsl"
cargo build -p oscilla-wasm-audio --target wasm32-unknown-unknown --release --manifest-path "$repo\Cargo.toml"
Copy-Item "$repo\target\wasm32-unknown-unknown\release\oscilla_wasm_audio.wasm" "$PSScriptRoot\audio.wasm" -Force
Write-Host "oscilla web build done (kernels.wgsl + audio.wasm)"
