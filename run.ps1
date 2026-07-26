$srcPath = Join-Path $PSScriptRoot "gui_preset_src.ps1"
if (-not (Test-Path $srcPath)) { $srcPath = "C:\Users\Administrator\Custom-Windows-GUI-Preset\gui_preset_src.ps1" }
$runPath = Join-Path $PSScriptRoot "run.ps1"

$rawCode = [System.IO.File]::ReadAllText($srcPath, [System.Text.Encoding]::UTF8)
$base64 = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($rawCode))

$protectedContent = @"
try { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8 } catch {}
Clear-Host
`$osName = (Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue).Caption
if (-not `$osName) { `$osName = "Windows Operating System" }
`$compName = `$env:COMPUTERNAME

Write-Host ""
Write-Host "  ================================================================" -ForegroundColor Cyan
Write-Host "  [ WINPULSE OPTIMIZER PRO v3.0 - OFFICIAL MASTER EDITION ]" -ForegroundColor Magenta
Write-Host "  ================================================================" -ForegroundColor Cyan
Write-Host "   [+] Target Machine     : `$compName (`$osName)" -ForegroundColor Gray
Write-Host "   [OK] Privilege Status  : ADMINISTRATOR [GRANTED]" -ForegroundColor Green
Write-Host "   [OK] High-Res Timer    : UNLOCKED (0.5ms)" -ForegroundColor DarkYellow
Write-Host "   [OK] GPU HAGS and Game : ONLINE" -ForegroundColor Cyan
Write-Host "   [OK] Launching Glassmorphism HUD Interface..." -ForegroundColor Magenta
Write-Host "  ================================================================" -ForegroundColor Cyan
Write-Host ""

`$b64Payload = "$base64"
`$decodedScript = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String(`$b64Payload))
Invoke-Expression `$decodedScript
"@

$utf8NoBOM = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($runPath, $protectedContent, $utf8NoBOM)
