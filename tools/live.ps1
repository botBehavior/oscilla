# oscilla live-coding watcher: edit synth/ or shaders/ Rust, hear it ~2s later.
# Rebuilds kernels.wgsl on change and bumps web/kernels.version; the page polls
# the version stamp and hot-swaps pipelines without stopping the audio ring.
# A failed build leaves the old shader live (the instrument never goes silent).
$repo = Split-Path $PSScriptRoot -Parent
$counter = 0
$last = @{}
Write-Host "oscilla live: watching synth/src and shaders/src (ctrl-c to stop)"
while ($true) {
    $changed = $false
    foreach ($d in @("$repo\synth\src", "$repo\shaders\src")) {
        foreach ($f in Get-ChildItem $d -Filter *.rs) {
            $t = $f.LastWriteTimeUtc.Ticks
            if (-not $last.ContainsKey($f.FullName)) { $last[$f.FullName] = $t }
            elseif ($last[$f.FullName] -ne $t) { $last[$f.FullName] = $t; $changed = $true }
        }
    }
    if ($changed) {
        $t0 = Get-Date
        & "$repo\web\build.ps1"
        if ($?) {
            $counter++
            $epoch = [DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()
            "$counter $epoch" | Set-Content "$repo\web\kernels.version" -Encoding ascii
            Write-Host ("rebuilt in {0:n1}s -> version {1}" -f ((Get-Date) - $t0).TotalSeconds, $counter)
        } else {
            Write-Host "BUILD FAILED - previous shader stays live"
        }
    }
    Start-Sleep -Milliseconds 700
}
