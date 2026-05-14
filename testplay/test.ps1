# testplay/test.ps1
# mock/ をコピーして run/ に対して indentier + このプラグインを実行するテストスクリプト
#
# 使い方:
#   .\testplay\test.ps1                          # default モード、全ファイルを表示
#   .\testplay\test.ps1 --mode=ruby              # ruby モード
#   .\testplay\test.ps1 --show sample.rs         # 特定ファイルの結果のみ表示
#
# --show <file> は複数指定可。省略時は全ファイルを表示。
# それ以外の引数はすべて indentier にそのまま渡される。
#
# 前提: このパッケージと indentier/ 両方で pnpm build を実行しておくこと。

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

# --- run/ をリフレッシュ ---
if (Test-Path $RunDir) { Remove-Item $RunDir -Recurse -Force }
Copy-Item $MockDir $RunDir -Recurse
Write-Host "Copied mock/ -> run/" -ForegroundColor Cyan

# --- プラグイン設定を run/ に配置 (indentier/dist/ 起点の相対パス、BOM なし UTF-8) ---
$pluginName = Split-Path $PackageDir -Leaf
$configPath = Join-Path $RunDir ".indentierrc.json"
[System.IO.File]::WriteAllText($configPath, "{`"plugins`":[`"../../$pluginName/dist/index.mjs`"]}", [System.Text.UTF8Encoding]::new($false))

# --- indentier 実行 2回 (idempotency 確認) ---
$cmdArgs = @("$Cli", '--write', '.') + $IndentierArgs
foreach ($n in 1, 2) {
    Write-Host "Running ($n/2): node $($cmdArgs -join ' ')  (cwd: $RunDir)" -ForegroundColor Cyan
    Push-Location $RunDir
    & node @cmdArgs
    Pop-Location
}

# --- 結果表示 ---
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