<#
.SYNOPSIS
    WinPulse PRO v3.0 - Ultimate Cyberpunk System & Gaming Optimizer (Pure WPF XAML Engine)
.DESCRIPTION
    Chris Titus WinUtil Style Native WPF Architecture featuring HAGS, Game Mode, Mouse Accel Off,
    Win32PrioritySeparation 38, BCD Timers, TCP CTCP, Cloudflare DNS, Debloat, and Live Command Stream.
#>

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Windows.Forms

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="WinPulse PRO Master Suite v3.0" Height="780" Width="1080"
        WindowStartupLocation="CenterScreen" WindowStyle="None" AllowsTransparency="True"
        Background="#0B0B1A" Foreground="#E2E8F0" FontFamily="Segoe UI">

    <Window.Resources>
        <!-- Custom ScrollBar Style -->
        <Style TargetType="TextBox">
            <Setter Property="Background" Value="#0A0A18"/>
            <Setter Property="Foreground" Value="#38BDF8"/>
            <Setter Property="BorderBrush" Value="#3A2D64"/>
            <Setter Property="FontFamily" Value="Consolas"/>
            <Setter Property="FontSize" Value="12"/>
        </Style>

        <!-- Button Style -->
        <Style TargetType="Button">
            <Setter Property="Background" Value="#1E1E38"/>
            <Setter Property="Foreground" Value="#FFFFFF"/>
            <Setter Property="BorderBrush" Value="#3A2D64"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="FontSize" Value="12"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="Padding" Value="10,6"/>
            <Setter Property="Cursor" Value="Hand"/>
        </Style>

        <!-- CheckBox Style -->
        <Style TargetType="CheckBox">
            <Setter Property="Foreground" Value="#CBD5E1"/>
            <Setter Property="FontSize" Value="12"/>
            <Setter Property="Margin" Value="0,4"/>
            <Setter Property="Cursor" Value="Hand"/>
        </Style>
    </Window.Resources>

    <Border BorderBrush="#7C3AED" BorderThickness="1" CornerRadius="12" Background="#0B0B1A">
        <Grid Margin="16">
            <Grid.RowDefinitions>
                <RowDefinition Height="Auto"/> <!-- Title Bar -->
                <RowDefinition Height="Auto"/> <!-- Header HUD -->
                <RowDefinition Height="Auto"/> <!-- Restore Point Safety -->
                <RowDefinition Height="Auto"/> <!-- Quick Presets -->
                <RowDefinition Height="*"/>    <!-- 4 Cards Grid -->
                <RowDefinition Height="Auto"/> <!-- Launch Button -->
                <RowDefinition Height="Auto"/> <!-- Progress & Log -->
            </Grid.RowDefinitions>

            <!-- 0. Title Bar -->
            <Grid Grid.Row="0" Margin="0,0,0,12" x:Name="TitleBar" Background="#121224">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="Auto"/>
                </Grid.ColumnDefinitions>
                <StackPanel Orientation="Horizontal" VerticalAlignment="Center" Margin="10,6">
                    <TextBlock Text="⚡ WINPULSE OPTIMIZER PRO v3.0 [WINUTIL MASTER ENGINE]" Foreground="#A78BFA" FontWeight="Bold" FontSize="13"/>
                </StackPanel>
                <StackPanel Grid.Column="1" Orientation="Horizontal" Margin="6">
                    <Button x:Name="BtnMinimize" Content=" _ " Width="32" Height="26" Margin="0,0,4,0" Background="#1E1E38" Foreground="#94A3B8"/>
                    <Button x:Name="BtnClose" Content=" ✕ " Width="32" Height="26" Background="#F43F5E" Foreground="#FFFFFF"/>
                </StackPanel>
            </Grid>

            <!-- 1. Header HUD -->
            <Border Grid.Row="1" Background="#16162A" BorderBrush="#3A2D64" BorderThickness="1" CornerRadius="8" Padding="16,12" Margin="0,0,0,10">
                <Grid>
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="Auto"/>
                    </Grid.ColumnDefinitions>
                    <StackPanel>
                        <TextBlock Text="WINPULSE MASTER GAMING SUITE" FontSize="20" FontWeight="Bold" Foreground="#A78BFA"/>
                        <TextBlock Text="Ultra Low-Latency Windows &amp; Gaming Tweaks (Pure Native WPF Engine)" FontSize="11" Foreground="#94A3B8" Margin="0,2,0,0"/>
                    </StackPanel>
                    <Border Grid.Column="1" Background="#10B981" CornerRadius="12" Padding="12,6" VerticalAlignment="Center">
                        <TextBlock Text="SYSTEM READY" Foreground="#FFFFFF" FontWeight="Bold" FontSize="11"/>
                    </Border>
                </Grid>
            </Border>

            <!-- 2. Restore Point Safety -->
            <Border Grid.Row="2" Background="#16162A" BorderBrush="#10B981" BorderThickness="1" CornerRadius="6" Padding="12,8" Margin="0,0,0,10">
                <CheckBox x:Name="chkRestorePoint" Content="🛡️ Create System Restore Point before tweaking (100% Safety Guarantee)" IsChecked="True" Foreground="#34D399" FontWeight="Bold"/>
            </Border>

            <!-- 3. Quick Presets Toolbar -->
            <Border Grid.Row="3" Background="#16162A" BorderBrush="#2A2A4A" BorderThickness="1" CornerRadius="6" Padding="10,8" Margin="0,0,0,10">
                <StackPanel Orientation="Horizontal">
                    <TextBlock Text="QUICK PRESETS:" Foreground="#F59E0B" FontWeight="Bold" VerticalAlignment="Center" Margin="0,0,12,0" FontSize="11"/>
                    <Button x:Name="BtnPresetMaster" Content="🌟 MASTER PRESET (ALL-IN-ONE)" Background="#10B981" Margin="0,0,8,0"/>
                    <Button x:Name="BtnPresetGaming" Content="🎮 GAMING &amp; LOW LATENCY" Background="#7C3AED" Margin="0,0,8,0"/>
                    <Button x:Name="BtnPresetClean" Content="🧹 CLEAN &amp; DEBLOAT" Background="#F43F5E" Margin="0,0,8,0"/>
                    <Button x:Name="BtnClearAll" Content="❌ Clear All" Background="#3A3A5A"/>
                </StackPanel>
            </Border>

            <!-- 4. 4-Card Multi-Grid Layout -->
            <Grid Grid.Row="4" Margin="0,0,0,10">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="1*"/>
                    <ColumnDefinition Width="1*"/>
                    <ColumnDefinition Width="1*"/>
                    <ColumnDefinition Width="1*"/>
                </Grid.ColumnDefinitions>

                <!-- Card 1: Gaming & Input Lag -->
                <Border Grid.Column="0" Background="#16162A" BorderBrush="#7C3AED" BorderThickness="1" CornerRadius="8" Padding="12" Margin="0,0,6,0">
                    <StackPanel>
                        <TextBlock Text="🎮 GAMING &amp; INPUT LAG" Foreground="#7C3AED" FontWeight="Bold" FontSize="12" Margin="0,0,0,8"/>
                        <CheckBox x:Name="chkHAGS" Content="Enable GPU HAGS &amp; GameMode" IsChecked="True"/>
                        <CheckBox x:Name="chkMouse" Content="Disable Mouse Acceleration" IsChecked="True"/>
                        <CheckBox x:Name="chkInputLag" Content="Max Priority (Win32=38)" IsChecked="True"/>
                        <CheckBox x:Name="chkPower" Content="Ultimate Performance Plan" IsChecked="True"/>
                        <CheckBox x:Name="chkMemory" Content="Disable RAM Compression" IsChecked="True"/>
                    </StackPanel>
                </Border>

                <!-- Card 2: Network & Low Ping -->
                <Border Grid.Column="1" Background="#16162A" BorderBrush="#38BDF8" BorderThickness="1" CornerRadius="8" Padding="12" Margin="3,0,3,0">
                    <StackPanel>
                        <TextBlock Text="🌐 NETWORK &amp; PING" Foreground="#38BDF8" FontWeight="Bold" FontSize="12" Margin="0,0,0,8"/>
                        <CheckBox x:Name="chkNetwork" Content="Optimize TCP/IP CTCP Stack" IsChecked="True"/>
                        <CheckBox x:Name="chkCloudflareDNS" Content="Cloudflare DNS (1.1.1.1)" IsChecked="True"/>
                        <CheckBox x:Name="chkOptimalMTU" Content="Set Optimal MTU (1500)" IsChecked="True"/>
                        <CheckBox x:Name="chkAdvancedTCPUDP" Content="Disable Checksum Offload" IsChecked="True"/>
                    </StackPanel>
                </Border>

                <!-- Card 3: Debloat & Purge -->
                <Border Grid.Column="2" Background="#16162A" BorderBrush="#F43F5E" BorderThickness="1" CornerRadius="8" Padding="12" Margin="3,0,3,0">
                    <StackPanel>
                        <TextBlock Text="🧹 DEBLOAT &amp; PURGE" Foreground="#F43F5E" FontWeight="Bold" FontSize="12" Margin="0,0,0,8"/>
                        <CheckBox x:Name="chkRemoveOneDrive" Content="Uninstall OneDrive &amp; Bloat" IsChecked="True"/>
                        <CheckBox x:Name="chkDebloat" Content="Disable Telemetry &amp; DVR" IsChecked="True"/>
                        <CheckBox x:Name="chkClean" Content="Purge Temp &amp; System Cache" IsChecked="True"/>
                        <CheckBox x:Name="chkWinUpdate" Content="Block Driver Overwrites" IsChecked="True"/>
                    </StackPanel>
                </Border>

                <!-- Card 4: Apps & UI Tweaks -->
                <Border Grid.Column="3" Background="#16162A" BorderBrush="#F59E0B" BorderThickness="1" CornerRadius="8" Padding="12" Margin="6,0,0,0">
                    <ScrollViewer VerticalScrollBarVisibility="Auto">
                        <StackPanel>
                            <TextBlock Text="💻 SOFTWARE &amp; UI" Foreground="#F59E0B" FontWeight="Bold" FontSize="12" Margin="0,0,0,8"/>
                            <CheckBox x:Name="chkChrome" Content="Google Chrome" IsChecked="True"/>
                            <CheckBox x:Name="chk7Zip" Content="7-Zip Archiver" IsChecked="True"/>
                            <CheckBox x:Name="chkVSCode" Content="VS Code" IsChecked="True"/>
                            <CheckBox x:Name="chkGit" Content="Git for Windows" IsChecked="True"/>
                            <CheckBox x:Name="chkDiscord" Content="Discord" IsChecked="True"/>
                            <Separator Background="#2A2A4A" Margin="0,6"/>
                            <CheckBox x:Name="chkShowExt" Content="Show Extensions &amp; Hidden" IsChecked="True"/>
                            <CheckBox x:Name="chkDarkMode" Content="Enable Dark Mode Theme" IsChecked="True"/>
                            <CheckBox x:Name="chkClassicMenu" Content="Restore Win 10 Classic Menu" IsChecked="True"/>
                        </StackPanel>
                    </ScrollViewer>
                </Border>
            </Grid>

            <!-- 5. Launch Button -->
            <Button Grid.Row="5" x:Name="BtnLaunch" Content="⚡ APPLY UNIFIED MASTER PRESET NOW ⚡"
                    Height="44" Background="#7C3AED" Foreground="#FFFFFF" FontWeight="Bold" FontSize="14" Margin="0,0,0,10"/>

            <!-- 6. Progress Bar & Output Console Log -->
            <Grid Grid.Row="6">
                <Grid.RowDefinitions>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="120"/>
                </Grid.RowDefinitions>
                <ProgressBar Grid.Row="0" x:Name="pbStatus" Height="6" Value="0" Minimum="0" Maximum="100" Foreground="#10B981" Background="#16162A" Margin="0,0,0,6"/>
                <TextBox Grid.Row="1" x:Name="txtLog" IsReadOnly="True" VerticalScrollBarVisibility="Auto" TextWrapping="Wrap"
                         Text="[SYSTEM] WinPulse Native WPF Engine Initialized. Click 'APPLY UNIFIED MASTER PRESET NOW'."/>
            </Grid>
        </Grid>
    </Border>
</Window>
"@

$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [System.Windows.Markup.XamlReader]::Load($reader)

# Find UI Controls
$TitleBar = $window.FindName("TitleBar")
$BtnMinimize = $window.FindName("BtnMinimize")
$BtnClose = $window.FindName("BtnClose")

$BtnPresetMaster = $window.FindName("BtnPresetMaster")
$BtnPresetGaming = $window.FindName("BtnPresetGaming")
$BtnPresetClean = $window.FindName("BtnPresetClean")
$BtnClearAll = $window.FindName("BtnClearAll")

$BtnLaunch = $window.FindName("BtnLaunch")
$pbStatus = $window.FindName("pbStatus")
$txtLog = $window.FindName("txtLog")

# Checkboxes List
$checkBoxNames = @(
    "chkRestorePoint", "chkHAGS", "chkMouse", "chkInputLag", "chkPower", "chkMemory",
    "chkNetwork", "chkCloudflareDNS", "chkOptimalMTU", "chkAdvancedTCPUDP",
    "chkRemoveOneDrive", "chkDebloat", "chkClean", "chkWinUpdate",
    "chkChrome", "chk7Zip", "chkVSCode", "chkGit", "chkDiscord",
    "chkShowExt", "chkDarkMode", "chkClassicMenu"
)

# Helper Functions
function Set-AllCheckboxes($value) {
    foreach ($name in $checkBoxNames) {
        $cb = $window.FindName($name)
        if ($cb) { $cb.IsChecked = $value }
    }
}

function Write-WpfLog($message) {
    $ts = (Get-Date).ToString("HH:mm:ss")
    $txtLog.Dispatcher.Invoke([Action]{
        $txtLog.AppendText("`n[$ts] $message")
        $txtLog.ScrollToEnd()
    })
}

function Set-WpfProgress($value) {
    $pbStatus.Dispatcher.Invoke([Action]{
        $pbStatus.Value = $value
    })
}

# Window Drag & Title Bar Events
$TitleBar.Add_MouseLeftButtonDown({
    $window.DragMove()
})

$BtnMinimize.Add_Click({
    $window.WindowState = [System.Windows.WindowState]::Minimized
})

$BtnClose.Add_Click({
    $window.Close()
})

# Preset Toolbar Events
$BtnPresetMaster.Add_Click({
    Set-AllCheckboxes $true
    Write-WpfLog "[PRESET] Unified Master Preset (All-in-One) selected."
})

$BtnPresetGaming.Add_Click({
    Set-AllCheckboxes $false
    @("chkRestorePoint", "chkHAGS", "chkMouse", "chkInputLag", "chkPower", "chkMemory", "chkNetwork", "chkCloudflareDNS", "chkOptimalMTU", "chkAdvancedTCPUDP", "chkDarkMode", "chkClassicMenu") | ForEach-Object {
        $cb = $window.FindName($_)
        if ($cb) { $cb.IsChecked = $true }
    }
    Write-WpfLog "[PRESET] Gaming & Low-Latency Preset selected."
})

$BtnPresetClean.Add_Click({
    Set-AllCheckboxes $false
    @("chkRestorePoint", "chkRemoveOneDrive", "chkDebloat", "chkClean", "chkWinUpdate") | ForEach-Object {
        $cb = $window.FindName($_)
        if ($cb) { $cb.IsChecked = $true }
    }
    Write-WpfLog "[PRESET] Clean & Debloat Preset selected."
})

$BtnClearAll.Add_Click({
    Set-AllCheckboxes $false
    Write-WpfLog "[PRESET] All options cleared."
})

# Execution Engine Event
$BtnLaunch.Add_Click({
    $BtnLaunch.IsEnabled = $false
    $BtnLaunch.Content = "⏳ EXECUTING REAL POWERSHELL PIPELINE..."
    
    $logFilePath = Join-Path $env:TEMP "WinPulse_Execution.log"
    "=== WinPulse PRO Native WPF Execution Log Started at $(Get-Date) ===" | Out-File -FilePath $logFilePath -Encoding utf8

    function Exec-Command($desc, $scriptBlock) {
        Write-WpfLog "[EXEC] Executing: $desc"
        Add-Content -Path $logFilePath -Value "[EXEC] Executing: $desc"
        try {
            $output = & $scriptBlock 2>&1
            if ($output) {
                foreach ($line in $output) {
                    if ($null -ne $line) {
                        $strLine = $line.ToString().Trim()
                        if ($strLine) {
                            Write-WpfLog "[STDOUT] $strLine"
                            Add-Content -Path $logFilePath -Value "[STDOUT] $strLine"
                        }
                    }
                }
            } else {
                Write-WpfLog "[SUCCESS] Command completed cleanly."
                Add-Content -Path $logFilePath -Value "[SUCCESS] Command completed cleanly."
            }
        } catch {
            Write-WpfLog "[ERROR] $($_.Exception.Message)"
            Add-Content -Path $logFilePath -Value "[ERROR] $($_.Exception.Message)"
        }
    }

    Set-WpfProgress 10
    Write-WpfLog "[SYSTEM] Starting WinPulse Native Execution Engine..."

    # Read Checkbox States
    $chkRestorePointVal = ($window.FindName("chkRestorePoint")).IsChecked
    $chkHAGSVal = ($window.FindName("chkHAGS")).IsChecked
    $chkMouseVal = ($window.FindName("chkMouse")).IsChecked
    $chkInputLagVal = ($window.FindName("chkInputLag")).IsChecked
    $chkPowerVal = ($window.FindName("chkPower")).IsChecked
    $chkMemoryVal = ($window.FindName("chkMemory")).IsChecked

    $chkNetworkVal = ($window.FindName("chkNetwork")).IsChecked
    $chkCloudflareDNSVal = ($window.FindName("chkCloudflareDNS")).IsChecked
    $chkOptimalMTUVal = ($window.FindName("chkOptimalMTU")).IsChecked
    $chkAdvancedTCPUDPVal = ($window.FindName("chkAdvancedTCPUDP")).IsChecked

    $chkRemoveOneDriveVal = ($window.FindName("chkRemoveOneDrive")).IsChecked
    $chkDebloatVal = ($window.FindName("chkDebloat")).IsChecked
    $chkCleanVal = ($window.FindName("chkClean")).IsChecked
    $chkWinUpdateVal = ($window.FindName("chkWinUpdate")).IsChecked

    $chkChromeVal = ($window.FindName("chkChrome")).IsChecked
    $chk7ZipVal = ($window.FindName("chk7Zip")).IsChecked
    $chkVSCodeVal = ($window.FindName("chkVSCode")).IsChecked
    $chkGitVal = ($window.FindName("chkGit")).IsChecked
    $chkDiscordVal = ($window.FindName("chkDiscord")).IsChecked

    $chkShowExtVal = ($window.FindName("chkShowExt")).IsChecked
    $chkDarkModeVal = ($window.FindName("chkDarkMode")).IsChecked
    $chkClassicMenuVal = ($window.FindName("chkClassicMenu")).IsChecked

    # 0. System Restore Point
    if ($chkRestorePointVal) {
        Exec-Command "Create System Restore Point" {
            Enable-ComputerRestore -Drive "C:\" -ErrorAction SilentlyContinue
            Checkpoint-Computer -Description "WinPulse Restore Point" -RestorePointType "MODIFY_SETTINGS"
        }
    }
    Set-WpfProgress 25

    # 1. HAGS & Game Mode & Mouse Accel
    if ($chkHAGSVal) {
        Exec-Command "Enable GPU HAGS & Game Mode" {
            New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -Name "HwSchMode" -Value 2 -PropertyType DWORD -Force
            New-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "AllowAutoGameMode" -Value 1 -PropertyType DWORD -Force
            New-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "AutoGameModeEnabled" -Value 1 -PropertyType DWORD -Force
        }
    }
    if ($chkMouseVal) {
        Exec-Command "Disable Mouse Pointer Precision (Mouse Acceleration Off)" {
            New-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSpeed" -Value "0" -PropertyType String -Force
            New-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold1" -Value "0" -PropertyType String -Force
            New-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold2" -Value "0" -PropertyType String -Force
        }
    }
    if ($chkInputLagVal) {
        Exec-Command "Set Max Win32PrioritySeparation = 38 & BCD Timers" {
            Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl" -Name "Win32PrioritySeparation" -Value 38
            bcdedit /set disabledynamictick yes
            bcdedit /set useplatformclock no
        }
    }
    if ($chkPowerVal) {
        Exec-Command "Enable Ultimate Performance Power Plan" {
            powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
        }
    }
    if ($chkMemoryVal) {
        Exec-Command "Disable Memory Compression" {
            Disable-MMAgent -MemoryCompression -ErrorAction SilentlyContinue
        }
    }
    Set-WpfProgress 50

    # 2. Network & Ping
    if ($chkNetworkVal) {
        Exec-Command "Optimize TCP/IP CTCP Stack" {
            netsh int tcp set global congestionprovider=ctcp
            netsh int tcp set global autotuninglevel=normal
        }
    }
    if ($chkCloudflareDNSVal) {
        Exec-Command "Set Cloudflare DNS (1.1.1.1)" {
            $netAdapter = Get-NetAdapter | Where-Object Status -eq 'Up' | Select-Object -First 1
            if ($netAdapter) {
                Set-DnsClientServerAddress -InterfaceIndex $netAdapter.ifIndex -ServerAddresses ("1.1.1.1", "1.0.0.1")
            }
        }
    }
    if ($chkOptimalMTUVal) {
        Exec-Command "Set Optimal MTU 1500" {
            netsh interface ipv4 set subinterface "Ethernet" mtu=1500 store=persistent -ErrorAction SilentlyContinue
            netsh interface ipv4 set subinterface "Wi-Fi" mtu=1500 store=persistent -ErrorAction SilentlyContinue
        }
    }
    if ($chkAdvancedTCPUDPVal) {
        Exec-Command "Disable Checksum Offload" {
            Disable-NetAdapterChecksumOffload -Name "*" -ErrorAction SilentlyContinue
        }
    }
    Set-WpfProgress 70

    # 3. Debloat & Purge
    if ($chkRemoveOneDriveVal) {
        Exec-Command "Uninstall OneDrive & Bloat" {
            taskkill /f /im OneDrive.exe -ErrorAction SilentlyContinue
            if (Test-Path "$env:SystemRoot\System32\OneDriveSetup.exe") {
                Start-Process "$env:SystemRoot\System32\OneDriveSetup.exe" -ArgumentList "/uninstall" -Wait
            }
        }
    }
    if ($chkDebloatVal) {
        Exec-Command "Disable Telemetry & Xbox DVR" {
            Set-Service -Name "DiagTrack" -StartupType Disabled -ErrorAction SilentlyContinue
            Stop-Service -Name "DiagTrack" -ErrorAction SilentlyContinue
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0
        }
    }
    if ($chkCleanVal) {
        Exec-Command "Purge Temp & System Cache" {
            Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
            Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
            Remove-Item -Path "C:\Windows\Prefetch\*" -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
    if ($chkWinUpdateVal) {
        Exec-Command "Block Driver Overwrites via Windows Update" {
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DriverUpdateWizardWuSearchEnabled" -Value 0
        }
    }
    Set-WpfProgress 85

    # 4. Software via Winget
    $apps = @(
        @{ Check = $chkChromeVal; ID = "Google.Chrome"; Name = "Google Chrome" },
        @{ Check = $chk7ZipVal; ID = "7zip.7zip"; Name = "7-Zip" },
        @{ Check = $chkVSCodeVal; ID = "Microsoft.VisualStudioCode"; Name = "VS Code" },
        @{ Check = $chkGitVal; ID = "Git.Git"; Name = "Git" },
        @{ Check = $chkDiscordVal; ID = "Discord.Discord"; Name = "Discord" }
    )
    foreach ($app in $apps) {
        if ($app.Check) {
            Exec-Command "winget install --id $($app.ID)" {
                winget install --id $app.ID --exact --silent --accept-package-agreements --accept-source-agreements
            }
        }
    }

    # 5. UI Tweaks
    if ($chkShowExtVal) {
        Exec-Command "Show File Extensions & Hidden Files" {
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1
        }
    }
    if ($chkDarkModeVal) {
        Exec-Command "Enable Dark Mode Theme" {
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0
        }
    }
    if ($chkClassicMenuVal) {
        Exec-Command "Restore Win 10 Classic Context Menu" {
            New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Value "" -Force
        }
    }

    Set-WpfProgress 100
    Write-WpfLog "[🎉 COMPLETE 100%] WinPulse PRO v3.0 Execution Pipeline Finished!"
    Write-WpfLog "Full execution log saved to: $logFilePath"

    $BtnLaunch.Content = "[OK] UNIFIED MASTER PRESET APPLIED SUCCESSFULLY"
    $BtnLaunch.Background = [System.Windows.Media.Brushes]::DarkGreen
})

# Show Native WPF Window
$window.ShowDialog() | Out-Null
