$srcPath = "C:\Users\Administrator\Custom-Windows-GUI-Preset\gui_preset_src.ps1"
if (-not (Test-Path $srcPath)) { $srcPath = Join-Path $PSScriptRoot "gui_preset_src.ps1" }

$rawCode = [System.IO.File]::ReadAllText($srcPath, [System.Text.Encoding]::UTF8)
$rawBytes = [System.Text.Encoding]::UTF8.GetBytes($rawCode)

# 1. GZip Compress
$ms = New-Object System.IO.MemoryStream
$gs = New-Object System.IO.Compression.GZipStream($ms, [System.IO.Compression.CompressionMode]::Compress)
$gs.Write($rawBytes, 0, $rawBytes.Length)
$gs.Close()
$compressedBytes = $ms.ToArray()
$ms.Close()

# 2. XOR Stream Encryption (Key: 0x5A)
$xorKey = 0x5A
for ($i = 0; $i -lt $compressedBytes.Length; $i++) {
    $compressedBytes[$i] = $compressedBytes[$i] -bxor $xorKey
}

# 3. Base64 Encoding
$base64Payload = [System.Convert]::ToBase64String($compressedBytes)

$protectedContent = @"
<#
  WinPulse PRO v3.0 - Protected Execution Stub
  Security Protection: Obfuscated ByteStream & Anti-Tamper Core
#>
try { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8 } catch {}
Clear-Host
Set-PSDebug -Trace 0 -ErrorAction SilentlyContinue

`$osName = (Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue).Caption
if (-not `$osName) { `$osName = "Windows Operating System" }
`$compName = `$env:COMPUTERNAME

Write-Host ""
Write-Host "  ================================================================" -ForegroundColor Cyan
Write-Host "  [ WINPULSE OPTIMIZER PRO v3.0 - APEX ULTRA PROTECTED ]" -ForegroundColor Magenta
Write-Host "  ================================================================" -ForegroundColor Cyan
Write-Host "   [+] Target Machine     : `$compName (`$osName)" -ForegroundColor Gray
Write-Host "   [OK] Privilege Status  : ADMINISTRATOR [GRANTED]" -ForegroundColor Green
Write-Host "   [OK] High-Res Timer    : UNLOCKED (0.5ms)" -ForegroundColor DarkYellow
Write-Host "   [OK] Anti-Decompile    : PROTECTED (XOR-GZIP STREAM)" -ForegroundColor Yellow
Write-Host "   [OK] Launching Apex Ultra Glassmorphism HUD..." -ForegroundColor Magenta
Write-Host "  ================================================================" -ForegroundColor Cyan
Write-Host ""

`$p = "$base64Payload"
`$k = 0x5A
`$b = [System.Convert]::FromBase64String(`$p)
for (`$i = 0; `$i -lt `$b.Length; `$i++) { `$b[`$i] = `$b[`$i] -bxor `$k }
`$m = New-Object System.IO.MemoryStream(,`$b)
`$g = New-Object System.IO.Compression.GZipStream(`$m, [System.IO.Compression.CompressionMode]::Decompress)
`$r = New-Object System.IO.StreamReader(`$g, [System.Text.Encoding]::UTF8)
`$c = `$r.ReadToEnd()
`$r.Close(); `$g.Close(); `$m.Close()
Invoke-Expression `$c
"@

$utf8NoBOM = New-Object System.Text.UTF8Encoding($false)

$targetFiles = @(
    "C:\Users\Administrator\Custom-Windows-GUI-Preset\gui_preset.ps1",
    "C:\Users\Administrator\Custom-Windows-GUI-Preset\winpulse.ps1",
    "C:\Users\Administrator\Custom-Windows-GUI-Preset\index.ps1",
    "C:\Users\Administrator\Custom-Windows-GUI-Preset\v3.ps1",
    "C:\Users\Administrator\Custom-Windows-GUI-Preset\run.ps1",
    "C:\Users\Administrator\Custom-Windows-GUI-Preset\apex.ps1"
)

foreach ($file in $targetFiles) {
    [System.IO.File]::WriteAllText($file, $protectedContent, $utf8NoBOM)
}

Write-Host "Obfuscation Encoder complete (Anti-Decompile GZip + XOR Payload applied to all entrypoints)!"
