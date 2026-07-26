$srcPath = Join-Path $PSScriptRoot "gui_preset_src.ps1"
if (-not (Test-Path $srcPath)) { $srcPath = "C:\Users\Administrator\Custom-Windows-GUI-Preset\gui_preset_src.ps1" }
$distPath = Join-Path $PSScriptRoot "gui_preset.ps1"
if (-not (Test-Path $distPath)) { $distPath = "C:\Users\Administrator\Custom-Windows-GUI-Preset\gui_preset.ps1" }

$rawCode = [System.IO.File]::ReadAllText($srcPath, [System.Text.Encoding]::UTF8)
$base64 = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($rawCode))

$protectedContent = @"
Write-Host ""
Write-Host " =============================================================" -ForegroundColor Cyan
Write-Host "   ⚡ WINPULSE OPTIMIZER PRO v2.5 [PROTECTED CORE ENGINE] ⚡" -ForegroundColor Blue
Write-Host " =============================================================" -ForegroundColor Cyan
Write-Host "   [+] Initializing Core Engine..." -ForegroundColor Yellow
Write-Host "   [+] Decrypting Memory Payload..." -ForegroundColor Green
Write-Host "   [+] Verifying System Privileges..." -ForegroundColor DarkYellow
Write-Host "   [+] Launching WinPulse WPF GUI Interface..." -ForegroundColor Magenta
Write-Host " =============================================================" -ForegroundColor Cyan
Write-Host ""

`$b64Payload = "$base64"
`$decodedScript = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String(`$b64Payload))
Invoke-Expression `$decodedScript
"@

# Write clean UTF-8 WITHOUT BOM to prevent ?Write-Host BOM byte issue in IEX
$utf8NoBOM = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($distPath, $protectedContent, $utf8NoBOM)
Write-Host "Encoder complete (Clean UTF-8 No-BOM)!"
