<#
.SYNOPSIS
    WinPulse PRO - Cyberpunk Gaming HUD Master Suite (UI/UX Pro Max Edition)
.DESCRIPTION
    Powered by Orbitron & JetBrains Mono fonts, inline SVG icons, Catppuccin Cyber-Purple theme,
    glassmorphism backdrop blur, and 60fps micro-animations.
#>

$guiScriptBlock = {
    Add-Type -AssemblyName PresentationFramework
    Add-Type -AssemblyName System.Windows.Forms

    # --- COM Interop Bridge for HTML -> PowerShell Communication ---
    if (-not ([System.Management.Automation.PSTypeName]'WinPulseBridge').Type) {
        Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

[ComVisible(true)]
public class WinPulseBridge {
    public delegate void ActionString(string arg);
    public event ActionString OnRun;
    public event Action OnCloseWindow;
    public event Action OnMinimizeWindow;

    public void Run(string json) {
        if (OnRun != null) OnRun(json);
    }
    public void CloseWin() {
        if (OnCloseWindow != null) OnCloseWindow();
    }
    public void MiniWin() {
        if (OnMinimizeWindow != null) OnMinimizeWindow();
    }
}
"@
    }

    $bridge = New-Object WinPulseBridge

    # --- UI/UX Pro Max HTML5/CSS3 Interface ---
    $htmlContent = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>WinPulse PRO Gaming Suite</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;600;800&family=Orbitron:wght@600;800;900&display=swap');
        
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            user-select: none;
        }

        body {
            background: #0f0f23;
            color: #e2e8f0;
            height: 100vh;
            overflow: hidden;
            border-radius: 14px;
            border: 1px solid rgba(124, 58, 237, 0.35);
            display: flex;
            flex-direction: column;
            font-family: 'JetBrains Mono', monospace;
            box-shadow: 0 0 40px rgba(124, 58, 237, 0.2);
        }

        /* Ambient Cyber-Purple Background Effects */
        .glow-sphere-1 {
            position: absolute;
            width: 450px;
            height: 450px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(124, 58, 237, 0.2) 0%, rgba(0,0,0,0) 70%);
            top: -150px;
            left: -150px;
            z-index: 0;
            pointer-events: none;
        }
        .glow-sphere-2 {
            position: absolute;
            width: 500px;
            height: 500px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(244, 63, 94, 0.15) 0%, rgba(0,0,0,0) 70%);
            bottom: -200px;
            right: -150px;
            z-index: 0;
            pointer-events: none;
        }

        /* Window Title Bar */
        .title-bar {
            height: 44px;
            background: rgba(15, 15, 35, 0.85);
            backdrop-filter: blur(16px);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 18px;
            border-bottom: 1px solid rgba(124, 58, 237, 0.2);
            z-index: 10;
        }
        .title-brand {
            display: flex;
            align-items: center;
            gap: 12px;
            font-family: 'Orbitron', sans-serif;
            font-weight: 900;
            font-size: 14px;
            color: #a78bfa;
            letter-spacing: 1.5px;
        }
        .title-controls {
            display: flex;
            gap: 8px;
        }
        .control-btn {
            width: 28px;
            height: 28px;
            border-radius: 7px;
            border: 1px solid rgba(255, 255, 255, 0.08);
            background: rgba(255, 255, 255, 0.04);
            color: #94a3b8;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .control-btn:hover {
            background: rgba(124, 58, 237, 0.3);
            color: #fff;
            border-color: #7c3aed;
        }
        .control-btn.close:hover {
            background: #f43f5e;
            color: #fff;
            border-color: #f43f5e;
        }

        /* Main Container */
        .app-container {
            flex: 1;
            padding: 22px;
            display: flex;
            flex-direction: column;
            gap: 16px;
            z-index: 1;
            overflow-y: auto;
        }

        /* Header Card */
        .header-card {
            background: rgba(27, 27, 47, 0.65);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(124, 58, 237, 0.3);
            border-radius: 12px;
            padding: 18px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.4);
        }
        .header-info h1 {
            font-family: 'Orbitron', sans-serif;
            font-size: 22px;
            font-weight: 900;
            background: linear-gradient(135deg, #a78bfa, #f43f5e);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            letter-spacing: 1px;
        }
        .header-info p {
            font-size: 12px;
            color: #94a3b8;
            margin-top: 4px;
        }
        .badge {
            background: rgba(16, 185, 129, 0.15);
            border: 1px solid rgba(16, 185, 129, 0.4);
            color: #34d399;
            padding: 6px 14px;
            border-radius: 20px;
            font-family: 'Orbitron', sans-serif;
            font-size: 11px;
            font-weight: 800;
            display: flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 0 15px rgba(16, 185, 129, 0.2);
        }
        .badge-dot {
            width: 8px;
            height: 8px;
            background: #34d399;
            border-radius: 50%;
            box-shadow: 0 0 10px #34d399;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.4; }
            100% { opacity: 1; }
        }

        /* Preset Toolbar */
        .preset-toolbar {
            background: rgba(27, 27, 47, 0.5);
            backdrop-filter: blur(16px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 10px;
            padding: 12px 18px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .preset-label {
            font-family: 'Orbitron', sans-serif;
            font-size: 11px;
            font-weight: 800;
            color: #f59e0b;
            letter-spacing: 0.5px;
            margin-right: 4px;
        }
        .btn-preset {
            padding: 9px 16px;
            border-radius: 8px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            background: rgba(255, 255, 255, 0.04);
            color: #e2e8f0;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .btn-preset:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.4);
        }
        .btn-preset.master {
            background: linear-gradient(135deg, #10b981, #059669);
            color: #ffffff;
            font-weight: 800;
            border: none;
            box-shadow: 0 0 15px rgba(16, 185, 129, 0.35);
        }
        .btn-preset.gaming {
            background: linear-gradient(135deg, #7c3aed, #6d28d9);
            color: #ffffff;
            font-weight: 800;
            border: none;
            box-shadow: 0 0 15px rgba(124, 58, 237, 0.35);
        }
        .btn-preset.clean {
            background: linear-gradient(135deg, #f43f5e, #e11d48);
            color: #ffffff;
            font-weight: 800;
            border: none;
            box-shadow: 0 0 15px rgba(244, 63, 94, 0.35);
        }

        /* Cards Grid */
        .cards-grid {
            display: grid;
            grid-template-columns: 1fr 1.2fr 1.2fr;
            gap: 16px;
            flex: 1;
        }
        .card {
            background: rgba(27, 27, 47, 0.55);
            backdrop-filter: blur(16px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 12px;
            padding: 18px;
            display: flex;
            flex-direction: column;
            gap: 14px;
            transition: border-color 0.3s ease;
        }
        .card:hover {
            border-color: rgba(124, 58, 237, 0.3);
        }
        .card-title {
            font-family: 'Orbitron', sans-serif;
            font-size: 12px;
            font-weight: 800;
            letter-spacing: 0.5px;
            display: flex;
            align-items: center;
            gap: 10px;
            padding-bottom: 10px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.06);
        }
        .card-1 .card-title { color: #f59e0b; }
        .card-2 .card-title { color: #f43f5e; }
        .card-3 .card-title { color: #38bdf8; }

        /* Custom Checkbox Option Items */
        .option-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 4px 0;
            cursor: pointer;
        }
        .option-item input[type="checkbox"] {
            appearance: none;
            width: 18px;
            height: 18px;
            border-radius: 5px;
            border: 2px solid rgba(255, 255, 255, 0.2);
            background: rgba(0, 0, 0, 0.4);
            cursor: pointer;
            position: relative;
            transition: all 0.2s ease;
        }
        .option-item input[type="checkbox"]:checked {
            background: #7c3aed;
            border-color: #7c3aed;
            box-shadow: 0 0 12px rgba(124, 58, 237, 0.6);
        }
        .option-item input[type="checkbox"]:checked::after {
            content: '✓';
            position: absolute;
            color: #ffffff;
            font-weight: 900;
            font-size: 12px;
            top: -2px;
            left: 3px;
        }
        .option-item label {
            font-size: 12px;
            color: #cbd5e1;
            cursor: pointer;
            font-weight: 500;
        }

        /* Action Launch Button */
        .launch-btn {
            height: 50px;
            border-radius: 10px;
            border: none;
            background: linear-gradient(135deg, #7c3aed, #f43f5e);
            color: #ffffff;
            font-family: 'Orbitron', sans-serif;
            font-size: 14px;
            font-weight: 900;
            letter-spacing: 1px;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 4px 25px rgba(124, 58, 237, 0.4);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        .launch-btn:hover {
            transform: scale(1.01);
            box-shadow: 0 6px 30px rgba(244, 63, 94, 0.55);
        }

        /* Progress Bar & Console Log */
        .progress-container {
            height: 8px;
            background: rgba(255, 255, 255, 0.08);
            border-radius: 4px;
            overflow: hidden;
        }
        .progress-bar {
            height: 100%;
            width: 0%;
            background: linear-gradient(90deg, #10b981, #38bdf8);
            transition: width 0.3s ease;
            box-shadow: 0 0 10px #10b981;
        }

        .console-box {
            background: rgba(15, 15, 35, 0.9);
            border: 1px solid rgba(124, 58, 237, 0.2);
            border-radius: 8px;
            padding: 12px;
            height: 110px;
            overflow-y: auto;
            font-family: 'JetBrains Mono', monospace;
            font-size: 11px;
            color: #94a3b8;
            line-height: 1.6;
        }

        /* SVG Icons Inline */
        .icon {
            width: 16px;
            height: 16px;
            fill: none;
            stroke: currentColor;
            stroke-width: 2;
            stroke-linecap: round;
            stroke-linejoin: round;
        }
    </style>
</head>
<body>
    <div class="glow-sphere-1"></div>
    <div class="glow-sphere-2"></div>

    <!-- Window Title Bar -->
    <div class="title-bar">
        <div class="title-brand">
            <svg class="icon" viewBox="0 0 24 24"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>
            WINPULSE OPTIMIZER PRO
        </div>
        <div class="title-controls">
            <button class="control-btn" onclick="window.external.MiniWin()">—</button>
            <button class="control-btn close" onclick="window.external.CloseWin()">✕</button>
        </div>
    </div>

    <div class="app-container">
        <!-- Header -->
        <div class="header-card">
            <div class="header-info">
                <h1>WINPULSE MASTER SUITE</h1>
                <p>Cyberpunk Gaming Performance &amp; Low-Latency Tuning Engine</p>
            </div>
            <div class="badge">
                <div class="badge-dot"></div>
                v2.5 HUD PRO
            </div>
        </div>

        <!-- Safety Option -->
        <div class="option-item" style="background: rgba(27,27,47,0.5); padding: 12px 16px; border-radius: 8px; border: 1px solid rgba(16, 185, 129, 0.3);">
            <input type="checkbox" id="chkRestorePoint" checked>
            <label for="chkRestorePoint" style="color: #34d399; font-weight: 700;">🛡️ Create System Restore Point before tweaking (100% Safety Guarantee)</label>
        </div>

        <!-- Preset Toolbar -->
        <div class="preset-toolbar">
            <span class="preset-label">QUICK PRESETS:</span>
            <button class="btn-preset master" onclick="applyPreset('master')">⚡ ALL-IN-ONE MASTER PRESET</button>
            <button class="btn-preset gaming" onclick="applyPreset('gaming')">🎮 GAMING &amp; LOW LATENCY</button>
            <button class="btn-preset clean" onclick="applyPreset('clean')">🧹 CLEAN &amp; DEBLOAT</button>
            <button class="btn-preset" onclick="applyPreset('clear')">❌ Clear All</button>
        </div>

        <!-- Cards Grid -->
        <div class="cards-grid">
            <!-- Card 1 -->
            <div class="card card-1">
                <div class="card-title">
                    <svg class="icon" viewBox="0 0 24 24"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path></svg>
                    Software &amp; UI Tweaks
                </div>
                <div class="option-item"><input type="checkbox" id="chkChrome" checked><label for="chkChrome">Google Chrome</label></div>
                <div class="option-item"><input type="checkbox" id="chk7Zip" checked><label for="chk7Zip">7-Zip Archiver</label></div>
                <div class="option-item"><input type="checkbox" id="chkVSCode" checked><label for="chkVSCode">VS Code</label></div>
                <div class="option-item"><input type="checkbox" id="chkGit" checked><label for="chkGit">Git for Windows</label></div>
                <div class="option-item"><input type="checkbox" id="chkDiscord" checked><label for="chkDiscord">Discord</label></div>
                <div style="height: 1px; background: rgba(255,255,255,0.06); margin: 4px 0;"></div>
                <div class="option-item"><input type="checkbox" id="chkShowExt" checked><label for="chkShowExt">Show Extensions &amp; Hidden</label></div>
                <div class="option-item"><input type="checkbox" id="chkDarkMode" checked><label for="chkDarkMode">Enable Dark Mode</label></div>
                <div class="option-item"><input type="checkbox" id="chkClassicMenu" checked><label for="chkClassicMenu">Restore Win 10 Classic Menu</label></div>
            </div>

            <!-- Card 2 -->
            <div class="card card-2">
                <div class="card-title">
                    <svg class="icon" viewBox="0 0 24 24"><path d="M13 2L3 14h9l-1 8 10-12h-9l1-8z"></path></svg>
                    System &amp; Input Lag
                </div>
                <div class="option-item"><input type="checkbox" id="chkInputLag" checked><label for="chkInputLag">Max Response (Win32Priority)</label></div>
                <div class="option-item"><input type="checkbox" id="chkPower" checked><label for="chkPower">Ultimate Performance Plan</label></div>
                <div class="option-item"><input type="checkbox" id="chkMemory" checked><label for="chkMemory">Disable RAM Compression</label></div>
                <div style="height: 1px; background: rgba(255,255,255,0.06); margin: 4px 0;"></div>
                <div class="option-item"><input type="checkbox" id="chkRemoveOneDrive" checked><label for="chkRemoveOneDrive">Uninstall OneDrive &amp; Bloat</label></div>
                <div class="option-item"><input type="checkbox" id="chkDebloat" checked><label for="chkDebloat">Disable Telemetry &amp; Xbox DVR</label></div>
                <div class="option-item"><input type="checkbox" id="chkClean" checked><label for="chkClean">Clean Temp &amp; System Cache</label></div>
                <div class="option-item"><input type="checkbox" id="chkWinUpdate" checked><label for="chkWinUpdate">Block Driver Overwrites</label></div>
            </div>

            <!-- Card 3 -->
            <div class="card card-3">
                <div class="card-title">
                    <svg class="icon" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg>
                    Network &amp; Low Ping
                </div>
                <div class="option-item"><input type="checkbox" id="chkNetwork" checked><label for="chkNetwork">Optimize TCP/IP Stack</label></div>
                <div class="option-item"><input type="checkbox" id="chkCloudflareDNS" checked><label for="chkCloudflareDNS">Cloudflare DNS (1.1.1.1)</label></div>
                <div class="option-item"><input type="checkbox" id="chkOptimalMTU" checked><label for="chkOptimalMTU">Set Optimal MTU (1500)</label></div>
                <div class="option-item"><input type="checkbox" id="chkAdvancedTCPUDP" checked><label for="chkAdvancedTCPUDP">Disable Checksum Offload</label></div>
            </div>
        </div>

        <!-- Launch Button -->
        <button class="launch-btn" id="btnLaunch" onclick="launchMasterPreset()">
            <svg class="icon" viewBox="0 0 24 24" style="width: 20px; height: 20px;"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>
            APPLY UNIFIED MASTER PRESET NOW
        </button>

        <!-- Progress & Console Log -->
        <div class="progress-container"><div class="progress-bar" id="pbStatus"></div></div>
        <div class="console-box" id="txtLog">WinPulse Cyberpunk HUD Ready... Select options or click 'APPLY UNIFIED MASTER PRESET NOW'.</div>
    </div>

    <script>
        const allCheckboxes = ['chkRestorePoint', 'chkChrome', 'chk7Zip', 'chkVSCode', 'chkGit', 'chkDiscord', 'chkShowExt', 'chkDarkMode', 'chkClassicMenu', 'chkInputLag', 'chkPower', 'chkMemory', 'chkRemoveOneDrive', 'chkDebloat', 'chkClean', 'chkWinUpdate', 'chkNetwork', 'chkCloudflareDNS', 'chkOptimalMTU', 'chkAdvancedTCPUDP'];

        function setAll(val) {
            allCheckboxes.forEach(id => {
                const el = document.getElementById(id);
                if (el) el.checked = val;
            });
        }

        function applyPreset(type) {
            if (type === 'master') {
                setAll(true);
                log("[Preset] All-In-One Master Preset selected.");
            } else if (type === 'gaming') {
                setAll(false);
                ['chkRestorePoint', 'chkInputLag', 'chkPower', 'chkMemory', 'chkNetwork', 'chkCloudflareDNS', 'chkOptimalMTU', 'chkAdvancedTCPUDP', 'chkDarkMode', 'chkClassicMenu'].forEach(id => {
                    document.getElementById(id).checked = true;
                });
                log("[Preset] Gaming & Low-Latency Preset selected.");
            } else if (type === 'clean') {
                setAll(false);
                ['chkRestorePoint', 'chkRemoveOneDrive', 'chkDebloat', 'chkClean', 'chkWinUpdate'].forEach(id => {
                    document.getElementById(id).checked = true;
                });
                log("[Preset] Clean & Debloat Preset selected.");
            } else if (type === 'clear') {
                setAll(false);
                log("[Preset] All options cleared.");
            }
        }

        function log(msg) {
            const consoleBox = document.getElementById('txtLog');
            consoleBox.innerHTML += '<br>' + msg;
            consoleBox.scrollTop = consoleBox.scrollHeight;
        }

        function setProgress(pct) {
            document.getElementById('pbStatus').style.width = pct + '%';
        }

        function launchMasterPreset() {
            const btn = document.getElementById('btnLaunch');
            btn.disabled = true;
            btn.style.opacity = '0.5';
            log('⚡ Executing WinPulse Master Pipeline...');

            const options = {};
            allCheckboxes.forEach(id => {
                options[id] = document.getElementById(id).checked;
            });

            window.external.Run(JSON.stringify(options));
        }
    </script>
</body>
</html>
"@

    # --- Create Transparent Borderless WPF Window containing WebBrowser ---
    $window = New-Object System.Windows.Window
    $window.Title = "WinPulse PRO Master Suite"
    $window.Height = 860
    $window.Width = 1060
    $window.WindowStartupLocation = [System.Windows.WindowStartupLocation]::CenterScreen
    $window.WindowStyle = [System.Windows.WindowStyle]::None
    $window.AllowsTransparency = $true
    $window.Background = [System.Windows.Media.Brushes]::Transparent

    $webBrowser = New-Object System.Windows.Controls.WebBrowser
    $window.Content = $webBrowser

    # Wire Bridge Events
    $bridge.OnCloseWindow += { $window.Close() }
    $bridge.OnMinimizeWindow += { $window.WindowState = [System.Windows.WindowState]::Minimized }

    $bridge.OnRun += {
        param($json)
        $options = ConvertFrom-Json $json

        $invokeJS = {
            param($method, $arg)
            $webBrowser.InvokeScript($method, @($arg)) | Out-Null
        }

        # Execution Engine
        & $invokeJS "setProgress" "10"
        & $invokeJS "log" "[Safety] Initializing Execution Pipeline..."

        if ($options.chkRestorePoint) {
            & $invokeJS "log" "[Safety] Creating System Restore Point..."
            try {
                Enable-ComputerRestore -Drive "C:\" -ErrorAction SilentlyContinue
                Checkpoint-Computer -Description "WinPulse Web Master Preset" -RestorePointType "MODIFY_SETTINGS" -ErrorAction SilentlyContinue
                & $invokeJS "log" "[Safety] Restore Point created successfully!"
            } catch {
                & $invokeJS "log" "[Safety] Skipped Restore Point creation."
            }
        }
        & $invokeJS "setProgress" "25"

        # Software
        $appMap = @(
            @{ Key = "chkChrome"; ID = "Google.Chrome"; Name = "Google Chrome" },
            @{ Key = "chk7Zip"; ID = "7zip.7zip"; Name = "7-Zip" },
            @{ Key = "chkVSCode"; ID = "Microsoft.VisualStudioCode"; Name = "VS Code" },
            @{ Key = "chkGit"; ID = "Git.Git"; Name = "Git" },
            @{ Key = "chkDiscord"; ID = "Discord.Discord"; Name = "Discord" }
        )
        foreach ($item in $appMap) {
            if ($options.($item.Key)) {
                & $invokeJS "log" "[Winget] Installing $($item.Name)..."
                winget install --id $item.ID --exact --silent --accept-package-agreements --accept-source-agreements | Out-Null
                & $invokeJS "log" "[Done] $($item.Name) installed!"
            }
        }
        & $invokeJS "setProgress" "45"

        # UI & System
        if ($options.chkShowExt) {
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1
        }
        if ($options.chkDarkMode) {
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0
        }
        if ($options.chkClassicMenu) {
            & $invokeJS "log" "[Tweak] Restoring Win 10 Classic Right-Click Menu..."
            New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Value "" -Force | Out-Null
        }

        # Power & Memory & Lag
        if ($options.chkPower) {
            & $invokeJS "log" "[Power] Unlocking Ultimate Performance Plan..."
            powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-Null
            powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-Null
            powercfg -h off
            New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power" -Name "PowerThrottlingOff" -Value 1 -PropertyType DWORD -Force | Out-Null
        }
        if ($options.chkMemory) {
            & $invokeJS "log" "[Memory] Disabling RAM Compression & Enabling Cache..."
            Disable-MMAgent -MemoryCompression | Out-Null
            New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "DisablePagingExecutive" -Value 1 -PropertyType DWORD -Force | Out-Null
            New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "LargeSystemCache" -Value 1 -PropertyType DWORD -Force | Out-Null
            fsutil behavior set disablelastaccess 1 | Out-Null
        }
        if ($options.chkInputLag) {
            & $invokeJS "log" "[Input Lag] Applying Win32PrioritySeparation (38/0x26) & BCD Timer..."
            bcdedit /set useplatformclock false | Out-Null
            bcdedit /set disabledynamictick yes | Out-Null
            bcdedit /set tscsyncpolicy enhanced | Out-Null
            New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl" -Name "Win32PrioritySeparation" -Value 38 -PropertyType DWORD -Force | Out-Null
            New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Value 0 -PropertyType DWORD -Force | Out-Null
            New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 4294967295 -PropertyType DWORD -Force | Out-Null
            New-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Value "0" -PropertyType String -Force | Out-Null
            New-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardSpeed" -Value "31" -PropertyType String -Force | Out-Null
        }
        & $invokeJS "setProgress" "75"

        # Debloat & Clean & WinUpdate
        if ($options.chkWinUpdate) {
            & $invokeJS "log" "[Update] Blocking automatic driver overwrites..."
            New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -Value 1 -PropertyType DWORD -Force | Out-Null
            New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Name "SearchOrderConfig" -Value 0 -PropertyType DWORD -Force | Out-Null
        }
        if ($options.chkRemoveOneDrive) {
            & $invokeJS "log" "[Debloat] Uninstalling OneDrive..."
            Stop-Process -Name "OneDrive" -Force -ErrorAction SilentlyContinue
            $odPath = "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe"
            if (-not (Test-Path $odPath)) { $odPath = "$env:SYSTEMROOT\System32\OneDriveSetup.exe" }
            if (Test-Path $odPath) { Start-Process $odPath -ArgumentList "/uninstall" -Wait -WindowStyle Hidden }
        }
        if ($options.chkDebloat) {
            & $invokeJS "log" "[Debloat] Disabling Telemetry & Xbox DVR..."
            New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -PropertyType DWORD -Force | Out-Null
            New-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Value 0 -PropertyType DWORD -Force | Out-Null
            Stop-Service DiagTrack -WarningAction SilentlyContinue; Set-Service DiagTrack -StartupType Disabled -WarningAction SilentlyContinue
        }
        if ($options.chkClean) {
            & $invokeJS "log" "[Clean] Cleaning Temp files & Prefetch cache..."
            Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
            Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
            Remove-Item -Path "C:\Windows\Prefetch\*" -Recurse -Force -ErrorAction SilentlyContinue
        }

        # Network
        if ($options.chkNetwork) {
            & $invokeJS "log" "[Network] Optimizing TCP/IP stack & Nagle's Algorithm..."
            netsh int tcp set global autotuninglevel=normal | Out-Null
            netsh int tcp set global rss=enabled | Out-Null
            netsh int tcp set global ecncapability=disabled | Out-Null
            netsh int tcp set global timestamps=disabled | Out-Null
            netsh int tcp set global rsc=disabled | Out-Null
            netsh int tcp set supplemental template=internet congestionprovider=ctcp | Out-Null
            $interfaces = Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\*"
            foreach ($iface in $interfaces) {
                New-ItemProperty -Path $iface.PSPath -Name "TcpAckFrequency" -Value 1 -PropertyType DWORD -Force | Out-Null
                New-ItemProperty -Path $iface.PSPath -Name "TCPNoDelay" -Value 1 -PropertyType DWORD -Force | Out-Null
                New-ItemProperty -Path $iface.PSPath -Name "TcpDelAckTicks" -Value 0 -PropertyType DWORD -Force | Out-Null
            }
        }
        if ($options.chkCloudflareDNS) {
            & $invokeJS "log" "[Network] Setting Cloudflare DNS (1.1.1.1)..."
            try { Get-DnsClientServerAddress | Where-Object { $_.AddressFamily -eq 2 } | Set-DnsClientServerAddress -ServerAddresses ("1.1.1.1", "1.0.0.1") -ErrorAction SilentlyContinue } catch {}
        }
        if ($options.chkOptimalMTU) {
            & $invokeJS "log" "[Network] Setting MTU size to 1500..."
            try { Get-NetAdapter | Where-Object Status -eq 'Up' | Set-NetIPv4Interface -NlMtuBytes 1500 -ErrorAction SilentlyContinue } catch {}
        }
        if ($options.chkAdvancedTCPUDP) {
            & $invokeJS "log" "[Network] Disabling TCP/UDP Checksum Offload..."
            try { Disable-NetAdapterChecksumOffload -Name "*" -IpIPv4 -TcpIPv4 -UdpIPv4 -ErrorAction SilentlyContinue } catch {}
        }

        & $invokeJS "setProgress" "100"
        & $invokeJS "log" "========================================="
        & $invokeJS "log" "[🎉 COMPLETE 100%] WinPulse Web Master Preset Applied!"
        & $invokeJS "log" "Rebooting your PC is recommended for maximum performance."
        & $invokeJS "log" "========================================="
    }

    # Enable WebBrowser Scripting Bridge
    $webBrowser.ObjectForScripting = $bridge

    # Make Window Draggable
    $window.Add_MouseLeftButtonDown({
        $window.DragMove()
    })

    # Navigate to HTML Content
    $webBrowser.NavigateToString($htmlContent)

    # Show Window
    $window.ShowDialog() | Out-Null
}

# STA Apartment State guarantee for WPF Window
if ([System.Threading.Thread]::CurrentThread.GetApartmentState() -ne 'STA') {
    $staThread = New-Object System.Threading.Thread($guiScriptBlock)
    $staThread.SetApartmentState([System.Threading.ApartmentState]::STA)
    $staThread.Start()
    $staThread.Join()
} else {
    Invoke-Command -ScriptBlock $guiScriptBlock
}
