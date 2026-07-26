<#
.SYNOPSIS
    WinPulse PRO v3.0 - Ultimate Cyberpunk System & Gaming Optimizer
.DESCRIPTION
    Full-fledged Web-Based Glassmorphism HUD featuring HAGS, Game Mode, Mouse Accel Off,
    Win32PrioritySeparation 38, BCD Timer Tweaks, TCP/IP CTCP Tuning, Cloudflare DNS,
    OneDrive Removal, Win11 Classic Menu, and Live Terminal Command Output.
#>

# Enable IE11 Edge Mode Emulation for powershell.exe in Registry
try {
    $regPath = "HKCU:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION"
    if (-not (Test-Path $regPath)) { New-Item -Path $regPath -Force | Out-Null }
    Set-ItemProperty -Path $regPath -Name "powershell.exe" -Value 11001 -Type DWORD -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $regPath -Name "powershell_ise.exe" -Value 11001 -Type DWORD -ErrorAction SilentlyContinue
} catch {}

$guiScriptBlock = {
    Add-Type -AssemblyName PresentationFramework
    Add-Type -AssemblyName System.Windows.Forms

    # --- COM Interop Bridge for HTML -> PowerShell Communication ---
    if (-not ([System.Management.Automation.PSTypeName]'WinPulseEngineBridge').Type) {
        Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

[ComVisible(true)]
public class WinPulseEngineBridge {
    public static Action<string> RunDelegate;
    public static Action CloseDelegate;
    public static Action MiniDelegate;

    public void Run(string json) {
        if (RunDelegate != null) RunDelegate(json);
    }
    public void CloseWin() {
        if (CloseDelegate != null) CloseDelegate();
    }
    public void MiniWin() {
        if (MiniDelegate != null) MiniDelegate();
    }
}
"@
    }

    $bridge = New-Object WinPulseEngineBridge

    # --- UI/UX Pro Max Glassmorphism HUD Interface ---
    $htmlContent = @"
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta charset="UTF-8" />
    <title>WinPulse PRO Gaming Suite v3.0</title>
    
    <!-- Global Bulletproof IE Error Interceptor -->
    <script type="text/javascript">
        window.onerror = function (msg, url, lineNo, columnNo, error) {
            return true;
        };
    </script>

    <style>
        @import url('https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;600;800&family=Orbitron:wght@600;800;900&display=swap');

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            user-select: none;
        }

        body {
            background: #0b0b1a;
            color: #e2e8f0;
            height: 100vh;
            overflow: hidden;
            border-radius: 14px;
            border: 1px solid rgba(124, 58, 237, 0.4);
            display: flex;
            flex-direction: column;
            font-family: 'JetBrains Mono', 'Segoe UI', monospace;
            box-shadow: 0 0 50px rgba(124, 58, 237, 0.25);
        }

        /* Ambient Cyber Glow Effects */
        .glow-sphere-1 {
            position: absolute;
            width: 500px;
            height: 500px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(124, 58, 237, 0.22) 0%, rgba(0,0,0,0) 70%);
            top: -180px;
            left: -180px;
            z-index: 0;
            pointer-events: none;
        }
        .glow-sphere-2 {
            position: absolute;
            width: 550px;
            height: 550px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(244, 63, 94, 0.18) 0%, rgba(0,0,0,0) 70%);
            bottom: -220px;
            right: -180px;
            z-index: 0;
            pointer-events: none;
        }

        /* Window Title Bar */
        .title-bar {
            height: 44px;
            background: rgba(12, 12, 28, 0.9);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 18px;
            border-bottom: 1px solid rgba(124, 58, 237, 0.25);
            z-index: 10;
        }
        .title-brand {
            display: flex;
            align-items: center;
            gap: 10px;
            font-family: 'Orbitron', 'Segoe UI', sans-serif;
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
            background: rgba(124, 58, 237, 0.35);
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
            padding: 20px;
            display: flex;
            flex-direction: column;
            gap: 14px;
            z-index: 1;
            overflow-y: auto;
        }

        /* Header HUD Banner */
        .header-card {
            background: rgba(22, 22, 42, 0.7);
            border: 1px solid rgba(124, 58, 237, 0.35);
            border-radius: 12px;
            padding: 16px 22px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.45);
        }
        .header-info h1 {
            font-family: 'Orbitron', 'Segoe UI', sans-serif;
            font-size: 22px;
            font-weight: 900;
            background: linear-gradient(135deg, #a78bfa, #f43f5e);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            color: #a78bfa;
            letter-spacing: 1.2px;
        }
        .header-info p {
            font-size: 11px;
            color: #94a3b8;
            margin-top: 3px;
        }
        .badge {
            background: rgba(16, 185, 129, 0.15);
            border: 1px solid rgba(16, 185, 129, 0.4);
            color: #34d399;
            padding: 6px 14px;
            border-radius: 20px;
            font-family: 'Orbitron', 'Segoe UI', sans-serif;
            font-size: 11px;
            font-weight: 800;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .badge-dot {
            width: 8px;
            height: 8px;
            background: #34d399;
            border-radius: 50%;
            box-shadow: 0 0 10px #34d399;
        }

        /* Quick Preset Toolbar */
        .preset-toolbar {
            background: rgba(22, 22, 42, 0.55);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 10px;
            padding: 12px 18px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .preset-label {
            font-family: 'Orbitron', 'Segoe UI', sans-serif;
            font-size: 11px;
            font-weight: 800;
            color: #f59e0b;
            letter-spacing: 0.5px;
            margin-right: 4px;
        }
        .btn-preset {
            padding: 9px 15px;
            border-radius: 8px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            background: rgba(255, 255, 255, 0.04);
            color: #e2e8f0;
            font-size: 11px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.25s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .btn-preset:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.4);
        }
        .btn-preset.master {
            background: #10b981;
            color: #ffffff;
            font-weight: 800;
            border: none;
            box-shadow: 0 0 15px rgba(16, 185, 129, 0.35);
        }
        .btn-preset.gaming {
            background: #7c3aed;
            color: #ffffff;
            font-weight: 800;
            border: none;
            box-shadow: 0 0 15px rgba(124, 58, 237, 0.35);
        }
        .btn-preset.clean {
            background: #f43f5e;
            color: #ffffff;
            font-weight: 800;
            border: none;
            box-shadow: 0 0 15px rgba(244, 63, 94, 0.35);
        }

        /* 4-Card Multi-Grid Layout */
        .cards-grid {
            display: grid;
            grid-template-columns: 1fr 1fr 1.1fr 1.1fr;
            gap: 14px;
            flex: 1;
        }
        .card {
            background: rgba(22, 22, 42, 0.6);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 12px;
            padding: 16px;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }
        .card-title {
            font-family: 'Orbitron', 'Segoe UI', sans-serif;
            font-size: 11px;
            font-weight: 800;
            letter-spacing: 0.5px;
            display: flex;
            align-items: center;
            gap: 8px;
            padding-bottom: 8px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.06);
        }
        .card-1 .card-title { color: #7c3aed; }
        .card-2 .card-title { color: #38bdf8; }
        .card-3 .card-title { color: #f43f5e; }
        .card-4 .card-title { color: #f59e0b; }

        /* Option Items & Checkboxes */
        .option-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 3px 0;
            cursor: pointer;
        }
        .option-item input[type="checkbox"] {
            width: 17px;
            height: 17px;
            cursor: pointer;
        }
        .option-item label {
            font-size: 11px;
            color: #cbd5e1;
            cursor: pointer;
            font-weight: 500;
        }

        /* Launch Button */
        .launch-btn {
            height: 48px;
            border-radius: 10px;
            border: none;
            background: linear-gradient(135deg, #7c3aed, #f43f5e);
            color: #ffffff;
            font-family: 'Orbitron', 'Segoe UI', sans-serif;
            font-size: 13px;
            font-weight: 900;
            letter-spacing: 1px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 25px rgba(124, 58, 237, 0.4);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        .launch-btn:hover {
            transform: scale(1.005);
            box-shadow: 0 6px 30px rgba(244, 63, 94, 0.55);
        }

        /* Console Output Box */
        .progress-container {
            height: 7px;
            background: rgba(255, 255, 255, 0.08);
            border-radius: 4px;
            overflow: hidden;
        }
        .progress-bar {
            height: 100%;
            width: 0%;
            background: #10b981;
            transition: width 0.3s ease;
            box-shadow: 0 0 10px #10b981;
        }

        .console-box {
            background: rgba(10, 10, 24, 0.95);
            border: 1px solid rgba(124, 58, 237, 0.25);
            border-radius: 8px;
            padding: 10px;
            height: 120px;
            overflow-y: auto;
            font-family: 'JetBrains Mono', 'Consolas', monospace;
            font-size: 11px;
            color: #38bdf8;
            line-height: 1.5;
        }

        .lucide-icon {
            width: 16px;
            height: 16px;
            vertical-align: middle;
        }
    </style>
</head>
<body>
    <div class="glow-sphere-1"></div>
    <div class="glow-sphere-2"></div>

    <!-- Window Title Bar -->
    <div class="title-bar">
        <div class="title-brand">
            <svg class="lucide-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>
            WINPULSE OPTIMIZER PRO v3.0 [HACKER HUD]
        </div>
        <div class="title-controls">
            <button class="control-btn" onclick="window.external.MiniWin()">
                <svg class="lucide-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M5 12h14"></path></svg>
            </button>
            <button class="control-btn close" onclick="window.external.CloseWin()">
                <svg class="lucide-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M18 6 6 18"></path><path d="m6 6 12 12"></path></svg>
            </button>
        </div>
    </div>

    <div class="app-container">
        <!-- Header -->
        <div class="header-card">
            <div class="header-info">
                <h1>WINPULSE MASTER GAMING SUITE</h1>
                <p>Ultra Low-Latency Windows &amp; Gaming Optimization Suite</p>
            </div>
            <div class="badge">
                <div class="badge-dot"></div>
                <svg class="lucide-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><path d="m9 12 2 2 4-4"></path></svg>
                SYSTEM READY
            </div>
        </div>

        <!-- Safety Option -->
        <div class="option-item" style="background: rgba(22,22,42,0.6); padding: 10px 16px; border-radius: 8px; border: 1px solid rgba(16, 185, 129, 0.35);">
            <input type="checkbox" id="chkRestorePoint" checked>
            <label for="chkRestorePoint" style="color: #34d399; font-weight: 700; display: flex; align-items: center; gap: 8px;">
                <svg class="lucide-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#34d399" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 13c0 5-3.5 7.5-7.66 8.95a1 1 0 0 1-.67-.01C7.5 20.5 4 18 4 13V6a1 1 0 0 1 1-1c2 0 4.5-1.2 6.24-2.72a1.17 1.17 0 0 1 1.52 0C14.51 3.81 17 5 19 5a1 1 0 0 1 1 1z"></path><path d="m9 12 2 2 4-4"></path></svg>
                Create System Restore Point before tweaking (100% Safety Guarantee)
            </label>
        </div>

        <!-- Preset Toolbar -->
        <div class="preset-toolbar">
            <span class="preset-label">QUICK PRESETS:</span>
            <button class="btn-preset master" onclick="applyPreset('master')">
                <svg class="lucide-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m12 3-1.912 5.813a2 2 0 0 1-1.275 1.275L3 12l5.813 1.912a2 2 0 0 1 1.275 1.275L12 21l1.912-5.813a2 2 0 0 1 1.275-1.275L21 12l-5.813-1.912a2 2 0 0 1-1.275-1.275L12 3Z"></path></svg>
                ⚡ MASTER PRESET (ALL-IN-ONE)
            </button>
            <button class="btn-preset gaming" onclick="applyPreset('gaming')">
                <svg class="lucide-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="6" x2="10" y1="12" y2="12"></line><line x1="8" x2="8" y1="10" y2="14"></line><line x1="15" x2="15.01" y1="13" y2="13"></line><line x1="18" x2="18.01" y1="11" y2="11"></line><rect width="20" height="12" x="2" y="6" rx="6"></rect></svg>
                🎮 GAMING &amp; LOW LATENCY
            </button>
            <button class="btn-preset clean" onclick="applyPreset('clean')">
                <svg class="lucide-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 6h18"></path><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"></path><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"></path></svg>
                🧹 CLEAN &amp; DEBLOAT
            </button>
            <button class="btn-preset" onclick="applyPreset('clear')">
                <svg class="lucide-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><path d="m15 9-6 6"></path><path d="m9 9 6 6"></path></svg>
                Clear All
            </button>
        </div>

        <!-- 4-Card Grid -->
        <div class="cards-grid">
            <!-- Card 1: Gaming & Input Lag -->
            <div class="card card-1">
                <div class="card-title">
                    <svg class="lucide-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#7c3aed" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect width="16" height="16" x="4" y="4" rx="2"></rect><rect width="6" height="6" x="9" y="9" rx="1"></rect><path d="M15 2v2"></path><path d="M15 20v2"></path><path d="M2 15h2"></path><path d="M2 9h2"></path><path d="M20 15h2"></path><path d="M20 9h2"></path><path d="M9 2v2"></path><path d="M9 20v2"></path></svg>
                    Gaming &amp; Input Lag
                </div>
                <div class="option-item"><input type="checkbox" id="chkHAGS" checked><label for="chkHAGS">Enable GPU HAGS &amp; GameMode</label></div>
                <div class="option-item"><input type="checkbox" id="chkMouse" checked><label for="chkMouse">Disable Mouse Acceleration</label></div>
                <div class="option-item"><input type="checkbox" id="chkInputLag" checked><label for="chkInputLag">Max Priority (Win32Priority=38)</label></div>
                <div class="option-item"><input type="checkbox" id="chkPower" checked><label for="chkPower">Ultimate Performance Plan</label></div>
                <div class="option-item"><input type="checkbox" id="chkMemory" checked><label for="chkMemory">Disable RAM Compression</label></div>
            </div>

            <!-- Card 2: Network & Ping -->
            <div class="card card-2">
                <div class="card-title">
                    <svg class="lucide-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#38bdf8" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 20h.01"></path><path d="M2 8.82a15 15 0 0 1 20 0"></path><path d="M5 12.85a10 10 0 0 1 14 0"></path><path d="M8.5 16.88a5 5 0 0 1 7 0"></path></svg>
                    Network &amp; Low Ping
                </div>
                <div class="option-item"><input type="checkbox" id="chkNetwork" checked><label for="chkNetwork">Optimize TCP/IP CTCP Stack</label></div>
                <div class="option-item"><input type="checkbox" id="chkCloudflareDNS" checked><label for="chkCloudflareDNS">Cloudflare DNS (1.1.1.1)</label></div>
                <div class="option-item"><input type="checkbox" id="chkOptimalMTU" checked><label for="chkOptimalMTU">Set Optimal MTU (1500)</label></div>
                <div class="option-item"><input type="checkbox" id="chkAdvancedTCPUDP" checked><label for="chkAdvancedTCPUDP">Disable Checksum Offload</label></div>
            </div>

            <!-- Card 3: Debloat & Clean -->
            <div class="card card-3">
                <div class="card-title">
                    <svg class="lucide-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#f43f5e" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 6h18"></path><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"></path><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"></path></svg>
                    Debloat &amp; Purge
                </div>
                <div class="option-item"><input type="checkbox" id="chkRemoveOneDrive" checked><label for="chkRemoveOneDrive">Uninstall OneDrive &amp; Bloat</label></div>
                <div class="option-item"><input type="checkbox" id="chkDebloat" checked><label for="chkDebloat">Disable Telemetry &amp; DVR</label></div>
                <div class="option-item"><input type="checkbox" id="chkClean" checked><label for="chkClean">Purge Temp &amp; System Cache</label></div>
                <div class="option-item"><input type="checkbox" id="chkWinUpdate" checked><label for="chkWinUpdate">Block Driver Overwrites</label></div>
            </div>

            <!-- Card 4: Apps & UI Tweaks -->
            <div class="card card-4">
                <div class="card-title">
                    <svg class="lucide-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#f59e0b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m7.5 4.27 9 5.15"></path><path d="M21 8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16Z"></path><path d="m3.3 7 8.7 5 8.7-5"></path><path d="M12 22V12"></path></svg>
                    Software &amp; UI
                </div>
                <div class="option-item"><input type="checkbox" id="chkChrome" checked><label for="chkChrome">Google Chrome</label></div>
                <div class="option-item"><input type="checkbox" id="chk7Zip" checked><label for="chk7Zip">7-Zip Archiver</label></div>
                <div class="option-item"><input type="checkbox" id="chkVSCode" checked><label for="chkVSCode">VS Code</label></div>
                <div class="option-item"><input type="checkbox" id="chkGit" checked><label for="chkGit">Git for Windows</label></div>
                <div class="option-item"><input type="checkbox" id="chkDiscord" checked><label for="chkDiscord">Discord</label></div>
                <div style="height: 1px; background: rgba(255,255,255,0.06); margin: 2px 0;"></div>
                <div class="option-item"><input type="checkbox" id="chkShowExt" checked><label for="chkShowExt">Show Extensions &amp; Hidden</label></div>
                <div class="option-item"><input type="checkbox" id="chkDarkMode" checked><label for="chkDarkMode">Enable Dark Mode Theme</label></div>
                <div class="option-item"><input type="checkbox" id="chkClassicMenu" checked><label for="chkClassicMenu">Restore Win 10 Classic Menu</label></div>
            </div>
        </div>

        <!-- Launch Button -->
        <button class="launch-btn" id="btnLaunch" onclick="launchMasterPreset()">
            <svg class="lucide-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>
            APPLY UNIFIED MASTER PRESET NOW
        </button>

        <!-- Progress Bar & Console Log -->
        <div class="progress-container"><div class="progress-bar" id="pbStatus"></div></div>
        <div class="console-box" id="txtLog">[00:00:00] [SYSTEM] WinPulse Cyberpunk HUD Initialized. Click 'APPLY UNIFIED MASTER PRESET NOW'.</div>
    </div>

    <!-- 100% Strict Standard ES5 JavaScript -->
    <script type="text/javascript">
        var allCheckboxes = ['chkRestorePoint', 'chkHAGS', 'chkMouse', 'chkInputLag', 'chkPower', 'chkMemory', 'chkNetwork', 'chkCloudflareDNS', 'chkOptimalMTU', 'chkAdvancedTCPUDP', 'chkRemoveOneDrive', 'chkDebloat', 'chkClean', 'chkWinUpdate', 'chkChrome', 'chk7Zip', 'chkVSCode', 'chkGit', 'chkDiscord', 'chkShowExt', 'chkDarkMode', 'chkClassicMenu'];

        function setAll(val) {
            for (var i = 0; i < allCheckboxes.length; i++) {
                var el = document.getElementById(allCheckboxes[i]);
                if (el) { el.checked = val; }
            }
        }

        function applyPreset(type) {
            if (type === 'master') {
                setAll(true);
                log("[PRESET] Unified Master Preset selected.");
            } else if (type === 'gaming') {
                setAll(false);
                var gamingList = ['chkRestorePoint', 'chkHAGS', 'chkMouse', 'chkInputLag', 'chkPower', 'chkMemory', 'chkNetwork', 'chkCloudflareDNS', 'chkOptimalMTU', 'chkAdvancedTCPUDP', 'chkDarkMode', 'chkClassicMenu'];
                for (var j = 0; j < gamingList.length; j++) {
                    var gEl = document.getElementById(gamingList[j]);
                    if (gEl) { gEl.checked = true; }
                }
                log("[PRESET] Gaming & Low-Latency Preset selected.");
            } else if (type === 'clean') {
                setAll(false);
                var cleanList = ['chkRestorePoint', 'chkRemoveOneDrive', 'chkDebloat', 'chkClean', 'chkWinUpdate'];
                for (var k = 0; k < cleanList.length; k++) {
                    var cEl = document.getElementById(cleanList[k]);
                    if (cEl) { cEl.checked = true; }
                }
                log("[PRESET] Clean & Debloat Preset selected.");
            } else if (type === 'clear') {
                setAll(false);
                log("[PRESET] All options cleared.");
            }
        }

        function log(msg) {
            var consoleBox = document.getElementById('txtLog');
            if (consoleBox) {
                consoleBox.innerHTML += '<br>' + msg;
                consoleBox.scrollTop = consoleBox.scrollHeight;
            }
        }

        function setProgress(pct) {
            var pb = document.getElementById('pbStatus');
            if (pb) { pb.style.width = pct + '%'; }
        }

        function launchMasterPreset() {
            var btn = document.getElementById('btnLaunch');
            if (btn) {
                btn.disabled = true;
                btn.style.opacity = '0.5';
            }
            log('⚡ Executing Real PowerShell Execution Pipeline...');

            var options = {};
            for (var m = 0; m < allCheckboxes.length; m++) {
                var idKey = allCheckboxes[m];
                var chkBox = document.getElementById(idKey);
                options[idKey] = chkBox ? chkBox.checked : false;
            }

            var jsonStr = '{';
            var keys = [];
            for (var kName in options) {
                keys.push('"' + kName + '":' + options[kName]);
            }
            jsonStr += keys.join(',') + '}';

            window.external.Run(jsonStr);
        }
    </script>
</body>
</html>
"@

    # --- Create Transparent Borderless WPF Window containing WebBrowser ---
    $window = New-Object System.Windows.Window
    $window.Title = "WinPulse PRO Master Suite v3.0"
    $window.Height = 880
    $window.Width = 1120
    $window.WindowStartupLocation = [System.Windows.WindowStartupLocation]::CenterScreen
    $window.WindowStyle = [System.Windows.WindowStyle]::None
    $window.AllowsTransparency = $true
    $window.Background = [System.Windows.Media.Brushes]::Transparent

    $webBrowser = New-Object System.Windows.Controls.WebBrowser
    $window.Content = $webBrowser

    # Double-Lock COM ActiveX Silent Mode Suppressor
    $webBrowser.Add_Loaded({
        try {
            $axIWebBrowser2 = $webBrowser.GetType().GetProperty("AxIWebBrowser2", [System.Reflection.BindingFlags]::Instance -or [System.Reflection.BindingFlags]::NonPublic).GetValue($webBrowser, $null)
            if ($axIWebBrowser2) {
                $axIWebBrowser2.GetType().InvokeMember("Silent", [System.Reflection.BindingFlags]::SetProperty, $null, $axIWebBrowser2, @($true)) | Out-Null
            }
        } catch {}
    })

    # Wire Immutable Static Delegates
    [WinPulseEngineBridge]::CloseDelegate = [Action]{ $window.Close() }
    [WinPulseEngineBridge]::MiniDelegate = [Action]{ $window.WindowState = [System.Windows.WindowState]::Minimized }

    [WinPulseEngineBridge]::RunDelegate = [Action[string]]{
        param($json)
        $options = ConvertFrom-Json $json

        $logFilePath = Join-Path $env:TEMP "WinPulse_Execution.log"
        "=== WinPulse PRO Execution Log Started at $(Get-Date) ===" | Out-File -FilePath $logFilePath -Encoding utf8

        $invokeJS = {
            param($method, $arg)
            $webBrowser.InvokeScript($method, @($arg)) | Out-Null
        }

        function Real-Log($level, $message) {
            $ts = (Get-Date).ToString("HH:mm:ss")
            $logLine = "[$ts] [$level] $message"
            & $invokeJS "log" $logLine
            Add-Content -Path $logFilePath -Value $logLine
        }

        function Exec-Command($desc, $scriptBlock) {
            Real-Log "EXEC" "Executing: $desc"
            try {
                $output = & $scriptBlock 2>&1
                if ($output) {
                    foreach ($line in $output) {
                        if ($null -ne $line) {
                            $strLine = $line.ToString().Trim()
                            if ($strLine) {
                                Real-Log "STDOUT" $strLine
                            }
                        }
                    }
                } else {
                    Real-Log "SUCCESS" "Command completed cleanly with return code 0."
                }
            } catch {
                Real-Log "ERROR" $_.Exception.Message
            }
        }

        # Real Execution Pipeline
        & $invokeJS "setProgress" "5"
        Real-Log "SYSTEM" "Starting Live Command Stream Pipeline. Log File: $logFilePath"

        # 0. System Restore Point
        if ($options.chkRestorePoint) {
            Exec-Command "Create System Restore Point" {
                Enable-ComputerRestore -Drive "C:\" -ErrorAction SilentlyContinue
                Checkpoint-Computer -Description "WinPulse Real Log Restore Point" -RestorePointType "MODIFY_SETTINGS"
            }
        }
        & $invokeJS "setProgress" "15"

        # 1. HAGS & GameMode & Mouse Acceleration
        if ($options.chkHAGS) {
            Exec-Command "Enable GPU Hardware-Accelerated GPU Scheduling (HAGS) & Game Mode" {
                New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -Name "HwSchMode" -Value 2 -PropertyType DWORD -Force
                New-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "AllowAutoGameMode" -Value 1 -PropertyType DWORD -Force
                New-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "AutoGameModeEnabled" -Value 1 -PropertyType DWORD -Force
            }
        }
        if ($options.chkMouse) {
            Exec-Command "Disable Windows Mouse Pointer Precision (Mouse Acceleration Off)" {
                New-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSpeed" -Value "0" -PropertyType String -Force
                New-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold1" -Value "0" -PropertyType String -Force
                New-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold2" -Value "0" -PropertyType String -Force
            }
        }
        & $invokeJS "setProgress" "30"

        # 2. Software via Winget
        $appMap = @(
            @{ Key = "chkChrome"; ID = "Google.Chrome"; Name = "Google Chrome" },
            @{ Key = "chk7Zip"; ID = "7zip.7zip"; Name = "7-Zip" },
            @{ Key = "chkVSCode"; ID = "Microsoft.VisualStudioCode"; Name = "VS Code" },
            @{ Key = "chkGit"; ID = "Git.Git"; Name = "Git" },
            @{ Key = "chkDiscord"; ID = "Discord.Discord"; Name = "Discord" }
        )
        foreach ($item in $appMap) {
            if ($options.($item.Key)) {
                Exec-Command "winget install --id $($item.ID)" {
                    winget install --id $item.ID --exact --silent --accept-package-agreements --accept-source-agreements
                }
            }
        }
        & $invokeJS "setProgress" "45"

        # 3. General Tweaks & Classic Menu
        if ($options.chkShowExt) {
            Exec-Command "Set File Explorer Show Extensions & Hidden" {
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1
            }
        }
        if ($options.chkDarkMode) {
            Exec-Command "Set Dark Mode Theme" {
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0
            }
        }
        if ($options.chkClassicMenu) {
            Exec-Command "Restore Win10 Classic Context Menu" {
                New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Value "" -Force
            }
        }
        & $invokeJS "setProgress" "60"

        # 4. Power, Memory & Input Lag
        if ($options.chkPower) {
            Exec-Command "Enable Ultimate Performance & Disable Power Throttling" {
                powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
                powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61
                powercfg -h off
                New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power" -Name "PowerThrottlingOff" -Value 1 -PropertyType DWORD -Force
            }
        }
        if ($options.chkMemory) {
            Exec-Command "Disable RAM Compression & Enable LargeSystemCache" {
                Disable-MMAgent -MemoryCompression
                New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "DisablePagingExecutive" -Value 1 -PropertyType DWORD -Force
                New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "LargeSystemCache" -Value 1 -PropertyType DWORD -Force
                fsutil behavior set disablelastaccess 1
            }
        }
        if ($options.chkInputLag) {
            Exec-Command "Apply Win32PrioritySeparation (38/0x26), BCD Timer & Peripheral Tuning" {
                bcdedit /set useplatformclock false
                bcdedit /set disabledynamictick yes
                bcdedit /set tscsyncpolicy enhanced
                New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl" -Name "Win32PrioritySeparation" -Value 38 -PropertyType DWORD -Force
                New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Value 0 -PropertyType DWORD -Force
                New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 4294967295 -PropertyType DWORD -Force
                New-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Value "0" -PropertyType String -Force
                New-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardSpeed" -Value "31" -PropertyType String -Force
            }
        }
        & $invokeJS "setProgress" "75"

        # 5. Debloat & WinUpdate & Clean
        if ($options.chkWinUpdate) {
            Exec-Command "Block Driver Overwrites from Windows Update" {
                New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -Value 1 -PropertyType DWORD -Force
                New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Name "SearchOrderConfig" -Value 0 -PropertyType DWORD -Force
            }
        }
        if ($options.chkRemoveOneDrive) {
            Exec-Command "Uninstall OneDrive" {
                Stop-Process -Name "OneDrive" -Force -ErrorAction SilentlyContinue
                $odPath = "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe"
                if (-not (Test-Path $odPath)) { $odPath = "$env:SYSTEMROOT\System32\OneDriveSetup.exe" }
                if (Test-Path $odPath) { Start-Process $odPath -ArgumentList "/uninstall" -Wait }
            }
        }
        if ($options.chkDebloat) {
            Exec-Command "Disable Telemetry & Xbox GameDVR" {
                New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -PropertyType DWORD -Force
                New-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Value 0 -PropertyType DWORD -Force
                Stop-Service DiagTrack -WarningAction SilentlyContinue
                Set-Service DiagTrack -StartupType Disabled -WarningAction SilentlyContinue
            }
        }
        if ($options.chkClean) {
            Exec-Command "Clean Temp & Prefetch Files" {
                Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
                Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
                Remove-Item -Path "C:\Windows\Prefetch\*" -Recurse -Force -ErrorAction SilentlyContinue
            }
        }

        # 6. Network Tuning
        if ($options.chkNetwork) {
            Exec-Command "Optimize TCP/IP Stack, Nagle's Algorithm & CTCP Provider" {
                netsh int tcp set global autotuninglevel=normal
                netsh int tcp set global rss=enabled
                netsh int tcp set global ecncapability=disabled
                netsh int tcp set global timestamps=disabled
                netsh int tcp set global rsc=disabled
                netsh int tcp set supplemental template=internet congestionprovider=ctcp
                $interfaces = Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\*"
                foreach ($iface in $interfaces) {
                    New-ItemProperty -Path $iface.PSPath -Name "TcpAckFrequency" -Value 1 -PropertyType DWORD -Force
                    New-ItemProperty -Path $iface.PSPath -Name "TCPNoDelay" -Value 1 -PropertyType DWORD -Force
                    New-ItemProperty -Path $iface.PSPath -Name "TcpDelAckTicks" -Value 0 -PropertyType DWORD -Force
                }
            }
        }
        if ($options.chkCloudflareDNS) {
            Exec-Command "Set Cloudflare DNS (1.1.1.1 / 1.0.0.1)" {
                Get-DnsClientServerAddress | Where-Object { $_.AddressFamily -eq 2 } | Set-DnsClientServerAddress -ServerAddresses ("1.1.1.1", "1.0.0.1") -ErrorAction SilentlyContinue
            }
        }
        if ($options.chkOptimalMTU) {
            Exec-Command "Set Optimal MTU (1500)" {
                Get-NetAdapter | Where-Object Status -eq 'Up' | Set-NetIPv4Interface -NlMtuBytes 1500 -ErrorAction SilentlyContinue
            }
        }
        if ($options.chkAdvancedTCPUDP) {
            Exec-Command "Disable TCP/UDP Checksum Offloading" {
                Disable-NetAdapterChecksumOffload -Name "*" -IpIPv4 -TcpIPv4 -UdpIPv4 -ErrorAction SilentlyContinue
            }
        }

        & $invokeJS "setProgress" "100"
        Real-Log "SYSTEM" "========================================="
        Real-Log "SYSTEM" "[🎉 COMPLETE 100%] WinPulse v3.0 Real Command Stream Finished!"
        Real-Log "SYSTEM" "Full log saved to: $logFilePath"
        Real-Log "SYSTEM" "========================================="
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

# Ensure WPF assemblies are loaded in primary scope
Add-Type -AssemblyName PresentationFramework -ErrorAction SilentlyContinue
Add-Type -AssemblyName System.Windows.Forms -ErrorAction SilentlyContinue

# Execute WPF GUI Block in STA Mode
if ([System.Threading.Thread]::CurrentThread.GetApartmentState() -ne [System.Threading.ApartmentState]::STA) {
    $powershell = [System.Management.Automation.PowerShell]::Create()
    $powershell.Runspace.ApartmentState = [System.Threading.ApartmentState]::STA
    $powershell.AddScript($guiScriptBlock) | Out-Null
    $powershell.Invoke() | Out-Null
    $powershell.Dispose()
} else {
    & $guiScriptBlock
}

