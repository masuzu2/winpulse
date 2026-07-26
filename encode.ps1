$srcPath = "C:\Users\Administrator\Custom-Windows-GUI-Preset\gui_preset_src.ps1"
$distPath = "C:\Users\Administrator\Custom-Windows-GUI-Preset\gui_preset.ps1"

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

[System.IO.File]::WriteAllText($distPath, $protectedContent, [System.Text.Encoding]::UTF8)
Write-Host "Encoder complete!"
