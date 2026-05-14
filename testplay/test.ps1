$PackageDir   = Split-Path $PSScriptRoot -Parent
$IndentierDir = Join-Path (Split-Path $PackageDir -Parent) "indentier"
$MockDir      = Join-Path $PSScriptRoot "mock"
$RunDir       = Join-Path $PSScriptRoot "run"
$Cli          = Join-Path $IndentierDir "dist\cli.mjs"

$Show          = @()
$IndentierArgs = @()

$i = 0
while ($i -lt $args.Count) {
    if ($args[$i] -eq '--show') {
        $i++
        if ($i -lt $args.Count) { $Show += $args[$i] }
    } else {
        $IndentierArgs += $args[$i]
    }
    $i++
}

if (Test-Path $RunDir) { Remove-Item $RunDir -Recurse -Force }
Copy-Item $MockDir $RunDir -Recurse
Write-Host "Copied mock/ -> run/" -ForegroundColor Cyan

$pluginName = Split-Path $PackageDir -Leaf
$configPath = Join-Path $RunDir ".indentierrc.json"
[System.IO.File]::WriteAllText($configPath, "{`"plugins`":[`"../../$pluginName/dist/index.mjs`"]}", [System.Text.UTF8Encoding]::new($false))

$cmdArgs = @("$Cli", '--write', '.') + $IndentierArgs
foreach ($n in 1, 2) {
    Write-Host "Running ($n/2): node $($cmdArgs -join ' ')  (cwd: $RunDir)" -ForegroundColor Cyan
    Push-Location $RunDir
    & node @cmdArgs
    Pop-Location
}

$filesToShow = if ($Show.Count -gt 0) {
    $Show | ForEach-Object { Join-Path $RunDir $_ }
} else {
    Get-ChildItem $RunDir -File | Where-Object { $_.Extension -ne '.json' } | Sort-Object Name | Select-Object -ExpandProperty FullName
}

foreach ($f in $filesToShow) {
    if (Test-Path $f) {
        $rel = $f.Substring($PackageDir.Length).TrimStart('\', '/')
        Write-Host "`n--- $rel ---" -ForegroundColor Yellow
        Get-Content $f
    } else {
        Write-Host "Not found: $f" -ForegroundColor Red
    }
}
