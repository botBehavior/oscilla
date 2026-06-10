# Build oscilla web artifacts: WGSL-constrained SPIR-V -> kernels.wgsl
$ErrorActionPreference = "Stop"
$repo = Split-Path $PSScriptRoot -Parent
cargo gpu build --shader-crate "$repo\shaders" --output-dir "$repo\shaders\wgsl" --target spirv-unknown-naga-wgsl --auto-install-rust-toolchain
naga "$repo\shaders\wgsl\oscilla_shaders.spv" "$PSScriptRoot\kernels.wgsl"
Write-Host "oscilla web build done"
