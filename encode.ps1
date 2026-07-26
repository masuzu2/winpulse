$srcPath = Join-Path $PSScriptRoot "gui_preset_src.ps1"
if (-not (Test-Path $srcPath)) { $srcPath = "C:\Users\Administrator\Custom-Windows-GUI-Preset\gui_preset_src.ps1" }
$distPath = Join-Path $PSScriptRoot "gui_preset.ps1"
if (-not (Test-Path $distPath)) { $distPath = "C:\Users\Administrator\Custom-Windows-GUI-Preset\gui_preset.ps1" }

$rawCode = [System.IO.File]::ReadAllText($srcPath, [System.Text.Encoding]::UTF8)
$base64 = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($rawCode))

$protectedContent = @"
Clear-Host
Write-Host ""
Write-Host "   ██╗  ██╗██╗███╗   ██╗██████╗ ██╗   ██╗██╗     ███████╗███████╗" -ForegroundColor Cyan
Write-Host "   ██║  ██║██║████╗  ██║██╔══██╗██║   ██║██║     ██╔════╝██╔════╝" -ForegroundColor Cyan
Write-Host "   ███████║██║██╔██╗ ██║██████╔╝██║   ██║██║     ███████╗█████╗  " -ForegroundColor Magenta
Write-Host "   ██╔══██║██║██║╚██╗██║██╔═══╝ ██║   ██║██║     ╚════██║██╔══╝  " -ForegroundColor Blue
Write-Host "   ██║  ██║██║██║ ╚████║██║     ╚██████╔╝███████╗███████║███████╗" -ForegroundColor Blue
Write-Host "   ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝╚═╝      ╚═════╝ ╚══════╝╚══════╝╚══════╝" -ForegroundColor DarkCyan
Write-Host " ===================================================================" -ForegroundColor DarkGray
Write-Host "   ⚡ WINPULSE PRO v3.0 [HACKER HUD & ULTRA LOW-LATENCY ENGINE] ⚡" -ForegroundColor Yellow
Write-Host " ===================================================================" -ForegroundColor DarkGray
Write-Host "   [✔] System Privilege Level: ADMINISTRATOR [GRANTED]" -ForegroundColor Green
Write-Host "   [✔] High-Precision Timer Resolution: UNLOCKED" -ForegroundColor DarkYellow
Write-Host "   [✔] GPU HAGS & Game Mode Tweak Engine: ONLINE" -ForegroundColor Cyan
Write-Host "   [✔] Decrypting Memory Payload & Launching Glassmorphism HUD..." -ForegroundColor Magenta
Write-Host " ===================================================================" -ForegroundColor DarkGray
Write-Host ""

`$b64Payload = "$base64"
`$decodedScript = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String(`$b64Payload))
Invoke-Expression `$decodedScript
"@

# Write clean UTF-8 WITHOUT BOM to prevent ?Write-Host BOM byte issue in IEX
$utf8NoBOM = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($distPath, $protectedContent, $utf8NoBOM)
Write-Host "Encoder complete (Clean UTF-8 No-BOM v3.0)!"
