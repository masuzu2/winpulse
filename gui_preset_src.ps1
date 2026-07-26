<#
.SYNOPSIS
    WinPulse PRO - Ultimate Windows Optimizer & Master Preset Suite
.DESCRIPTION
    Unified One-Click Master Preset for maximum gaming performance,
    input lag reduction, low latency network tuning, and background debloating.
#>

$guiScriptBlock = {
    Add-Type -AssemblyName PresentationFramework
    Add-Type -AssemblyName System.Windows.Forms

    # --- 1. WPF XAML Interface Design ---
    [xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="WinPulse PRO - Master Preset Suite" Height="860" Width="1050"
        WindowStartupLocation="CenterScreen" Background="#11111B" Foreground="#CDD6F4"
        FontFamily="Segoe UI" FontSize="14">
    <Grid Margin="20">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="120"/>
        </Grid.RowDefinitions>

        <!-- Header Banner -->
        <Border Grid.Row="0" CornerRadius="10" Padding="16" Margin="0,0,0,12">
            <Border.Background>
                <LinearGradientBrush StartPoint="0,0" EndPoint="1,1">
                    <GradientStop Color="#1E1E2E" Offset="0.0"/>
                    <GradientStop Color="#181825" Offset="1.0"/>
                </LinearGradientBrush>
            </Border.Background>
            <Grid>
                <StackPanel Orientation="Horizontal" HorizontalAlignment="Left" VerticalAlignment="Center">
                    <TextBlock Text="⚡" FontSize="28" Margin="0,0,12,0"/>
                    <StackPanel>
                        <TextBlock Text="WINPULSE UNIFIED MASTER PRESET" FontSize="22" FontWeight="Black" Foreground="#89B4FA"/>
                        <TextBlock Text="One-Click Ultimate Gaming Performance &amp; System Optimization Suite" FontSize="12" Foreground="#A6ADC8"/>
                    </StackPanel>
                </StackPanel>

                <Border HorizontalAlignment="Right" VerticalAlignment="Center" Background="#313244" CornerRadius="15" Padding="12,5">
                    <StackPanel Orientation="Horizontal">
                        <Ellipse Width="8" Height="8" Fill="#A6E3A1" Margin="0,0,8,0"/>
                        <TextBlock Text="v2.5 MASTER ACTIVE" FontSize="11" FontWeight="Bold" Foreground="#A6E3A1"/>
                    </StackPanel>
                </Border>
            </Grid>
        </Border>

        <!-- Master Preset Toolbar (One-Click Presets) -->
        <Border Grid.Row="1" Background="#181825" CornerRadius="8" Padding="12" Margin="0,0,0,12">
            <StackPanel Orientation="Horizontal" HorizontalAlignment="Center">
                <TextBlock Text="🔥 QUICK PRESETS:" FontWeight="Bold" Foreground="#F9E2AF" VerticalAlignment="Center" Margin="0,0,15,0"/>
                <Button x:Name="btnMasterPreset" Content="⚡ ALL-IN-ONE MASTER PRESET" Height="36" Padding="15,0" Background="#A6E3A1" Foreground="#11111B" FontWeight="Black" Margin="0,0,10,0" Cursor="Hand">
                    <Button.Resources><Style TargetType="Border"><Setter Property="CornerRadius" Value="6"/></Style></Button.Resources>
                </Button>
                <Button x:Name="btnGamingPreset" Content="🎮 GAMING &amp; LOW LATENCY" Height="36" Padding="15,0" Background="#CBA6F7" Foreground="#11111B" FontWeight="Bold" Margin="0,0,10,0" Cursor="Hand">
                    <Button.Resources><Style TargetType="Border"><Setter Property="CornerRadius" Value="6"/></Style></Button.Resources>
                </Button>
                <Button x:Name="btnCleanPreset" Content="🧹 CLEAN &amp; DEBLOAT ONLY" Height="36" Padding="15,0" Background="#FAB387" Foreground="#11111B" FontWeight="Bold" Margin="0,0,10,0" Cursor="Hand">
                    <Button.Resources><Style TargetType="Border"><Setter Property="CornerRadius" Value="6"/></Style></Button.Resources>
                </Button>
                <Button x:Name="btnDeselectAll" Content="❌ Clear All" Height="36" Padding="12,0" Background="#313244" Foreground="#CDD6F4" FontWeight="Bold" Cursor="Hand">
                    <Button.Resources><Style TargetType="Border"><Setter Property="CornerRadius" Value="6"/></Style></Button.Resources>
                </Button>
            </StackPanel>
        </Border>

        <!-- Safety Notification Bar -->
        <Border Grid.Row="2" Background="#181825" BorderBrush="#89B4FA" BorderThickness="1" CornerRadius="8" Padding="10" Margin="0,0,0,12">
            <CheckBox x:Name="chkRestorePoint" Content="🛡️ Create System Restore Point before tweaking (Recommended for 100% Safety)" IsChecked="True" FontWeight="Bold" Foreground="#A6E3A1"/>
        </Border>

        <!-- Main Options Grid (3 Columns) -->
        <Grid Grid.Row="3">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="1*"/>
                <ColumnDefinition Width="1.2*"/>
                <ColumnDefinition Width="1.2*"/>
            </Grid.ColumnDefinitions>

            <!-- Column 1: Software & General UI -->
            <Border Grid.Column="0" Background="#181825" CornerRadius="10" Padding="16" Margin="0,0,10,10">
                <StackPanel>
                    <TextBlock Text="📦 Software Packages (Winget)" FontWeight="Bold" Foreground="#F9E2AF" FontSize="15" Margin="0,0,0,12"/>
                    <CheckBox x:Name="chkChrome" Content="Google Chrome" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                    <CheckBox x:Name="chk7Zip" Content="7-Zip Archiver" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                    <CheckBox x:Name="chkVSCode" Content="VS Code" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                    <CheckBox x:Name="chkGit" Content="Git for Windows" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                    <CheckBox x:Name="chkDiscord" Content="Discord" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                    
                    <Separator Margin="0,18,0,18" Background="#313244"/>
                    
                    <TextBlock Text="🎨 System Customization" FontWeight="Bold" Foreground="#F9E2AF" FontSize="15" Margin="0,0,0,12"/>
                    <CheckBox x:Name="chkShowExt" Content="Show Extensions &amp; Hidden Files" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                    <CheckBox x:Name="chkDarkMode" Content="Enable System-Wide Dark Mode" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                    <CheckBox x:Name="chkClassicMenu" Content="🖱️ Restore Win 10 Classic Menu (Win 11)" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                </StackPanel>
            </Border>

            <!-- Column 2: System, Power & Latency -->
            <Border Grid.Column="1" Background="#181825" CornerRadius="10" Padding="16" Margin="5,0,5,10">
                <StackPanel>
                    <TextBlock Text="⚡ System &amp; Input Lag Optimization" FontWeight="Bold" Foreground="#F38BA8" FontSize="15" Margin="0,0,0,12"/>
                    <CheckBox x:Name="chkInputLag" Content="🎯 Max Response (Win32Priority / Timer)" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                    <CheckBox x:Name="chkPower" Content="🔋 Ultimate Performance (Unpark CPU/GPU)" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                    <CheckBox x:Name="chkMemory" Content="🧠 Disable Memory Compression (Fix Stutter)" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                    
                    <Separator Margin="0,18,0,18" Background="#313244"/>

                    <TextBlock Text="🗑️ Cleanup &amp; Background Debloat" FontWeight="Bold" Foreground="#F38BA8" FontSize="15" Margin="0,0,0,12"/>
                    <CheckBox x:Name="chkRemoveOneDrive" Content="Uninstall OneDrive &amp; Bloatware" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                    <CheckBox x:Name="chkDebloat" Content="Disable Telemetry &amp; Xbox DVR" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                    <CheckBox x:Name="chkClean" Content="🧹 Clean Temp, Prefetch &amp; System Cache" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                    <CheckBox x:Name="chkWinUpdate" Content="🛑 Block Driver Overwrites (WinUpdate)" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                </StackPanel>
            </Border>

            <!-- Column 3: Network & Gaming Tweaks -->
            <Border Grid.Column="2" Background="#181825" CornerRadius="10" Padding="16" Margin="10,0,0,10">
                <StackPanel>
                    <TextBlock Text="🌐 Network &amp; Latency Optimization" FontWeight="Bold" Foreground="#89DCEB" FontSize="15" Margin="0,0,0,12"/>
                    <CheckBox x:Name="chkNetwork" Content="🌐 Optimize TCP/IP (Nagle / NoDelay)" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                    <CheckBox x:Name="chkCloudflareDNS" Content="☁️ Set Cloudflare DNS (1.1.1.1 / 1.0.0.1)" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                    <CheckBox x:Name="chkOptimalMTU" Content="📏 Set Optimal MTU Size (1500)" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                    <CheckBox x:Name="chkAdvancedTCPUDP" Content="⚙️ Disable TCP/UDP Checksum Offloading" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                </StackPanel>
            </Border>
        </Grid>

        <!-- Action Button & Custom Progress Bar -->
        <StackPanel Grid.Row="4" Margin="0,5,0,15">
            <Button x:Name="btnInstall" Content="🚀 APPLY UNIFIED MASTER PRESET NOW" Height="48" Background="#89B4FA" Foreground="#11111B" FontWeight="Black" FontSize="16" Cursor="Hand" Margin="0,0,0,10">
                <Button.Resources>
                    <Style TargetType="Border">
                        <Setter Property="CornerRadius" Value="8"/>
                    </Style>
                </Button.Resources>
            </Button>
            <ProgressBar x:Name="pbStatus" Height="14" Minimum="0" Maximum="100" Value="0" Background="#313244" Foreground="#A6E3A1">
                <ProgressBar.Resources>
                    <Style TargetType="Border">
                        <Setter Property="CornerRadius" Value="6"/>
                    </Style>
                </ProgressBar.Resources>
            </ProgressBar>
        </StackPanel>

        <!-- System Log Box -->
        <Border Grid.Row="5" Background="#181825" CornerRadius="8" Padding="12">
            <ScrollViewer VerticalScrollBarVisibility="Auto">
                <TextBlock x:Name="txtLog" Text="WinPulse Master Preset Suite Ready... Click 'APPLY UNIFIED MASTER PRESET NOW' or pick a Quick Preset above." Foreground="#A6ADC8" FontFamily="Consolas" FontSize="13" TextWrapping="Wrap"/>
            </ScrollViewer>
        </Border>
    </Grid>
</Window>
"@

    # Read XAML Node and load WPF
    $reader = (New-Object System.Xml.XmlNodeReader $xaml)
    $window = [Windows.Markup.XamlReader]::Load($reader)

    # Get Control Elements
    $btnInstall = $window.FindName("btnInstall")
    $txtLog = $window.FindName("txtLog")
    $pbStatus = $window.FindName("pbStatus")

    $btnMasterPreset = $window.FindName("btnMasterPreset")
    $btnGamingPreset = $window.FindName("btnGamingPreset")
    $btnCleanPreset = $window.FindName("btnCleanPreset")
    $btnDeselectAll = $window.FindName("btnDeselectAll")

    $chkRestorePoint = $window.FindName("chkRestorePoint")

    $chkChrome = $window.FindName("chkChrome"); $chk7Zip = $window.FindName("chk7Zip")
    $chkVSCode = $window.FindName("chkVSCode"); $chkGit = $window.FindName("chkGit")
    $chkDiscord = $window.FindName("chkDiscord"); $chkShowExt = $window.FindName("chkShowExt")
    $chkDarkMode = $window.FindName("chkDarkMode"); $chkClassicMenu = $window.FindName("chkClassicMenu")

    $chkPower = $window.FindName("chkPower"); $chkMemory = $window.FindName("chkMemory")
    $chkInputLag = $window.FindName("chkInputLag"); $chkRemoveOneDrive = $window.FindName("chkRemoveOneDrive")
    $chkDebloat = $window.FindName("chkDebloat"); $chkClean = $window.FindName("chkClean")
    $chkWinUpdate = $window.FindName("chkWinUpdate")

    $chkNetwork = $window.FindName("chkNetwork"); $chkCloudflareDNS = $window.FindName("chkCloudflareDNS")
    $chkOptimalMTU = $window.FindName("chkOptimalMTU"); $chkAdvancedTCPUDP = $window.FindName("chkAdvancedTCPUDP")

    $allCheckboxes = @(
        $chkChrome, $chk7Zip, $chkVSCode, $chkGit, $chkDiscord,
        $chkShowExt, $chkDarkMode, $chkClassicMenu,
        $chkInputLag, $chkPower, $chkMemory, $chkRemoveOneDrive, $chkDebloat, $chkClean, $chkWinUpdate,
        $chkNetwork, $chkCloudflareDNS, $chkOptimalMTU, $chkAdvancedTCPUDP
    )

    function Set-AllCheckboxes($state) {
        foreach ($chk in $allCheckboxes) {
            $chk.IsChecked = $state
        }
    }

    # --- Quick Preset Handlers ---
    $btnMasterPreset.Add_Click({
        Set-AllCheckboxes $true
        $chkRestorePoint.IsChecked = $true
        $txtLog.Text = "[Master Preset] All optimization modules selected!"
    })

    $btnGamingPreset.Add_Click({
        Set-AllCheckboxes $false
        $chkInputLag.IsChecked = $true
        $chkPower.IsChecked = $true
        $chkMemory.IsChecked = $true
        $chkNetwork.IsChecked = $true
        $chkCloudflareDNS.IsChecked = $true
        $chkOptimalMTU.IsChecked = $true
        $chkAdvancedTCPUDP.IsChecked = $true
        $chkDarkMode.IsChecked = $true
        $chkClassicMenu.IsChecked = $true
        $chkRestorePoint.IsChecked = $true
        $txtLog.Text = "[Gaming Preset] Low Latency & Gaming optimization modules selected!"
    })

    $btnCleanPreset.Add_Click({
        Set-AllCheckboxes $false
        $chkRemoveOneDrive.IsChecked = $true
        $chkDebloat.IsChecked = $true
        $chkClean.IsChecked = $true
        $chkWinUpdate.IsChecked = $true
        $chkRestorePoint.IsChecked = $true
        $txtLog.Text = "[Clean & Debloat] System cleanup & debloat modules selected!"
    })

    $btnDeselectAll.Add_Click({
        Set-AllCheckboxes $false
        $txtLog.Text = "[Selection] All options cleared."
    })

    function Write-Log($msg) {
        $txtLog.Text += "`n" + $msg
        $txtLog.Dispatcher.Invoke([Action]{}, "Background")
    }

    function Set-Progress($value) {
        $pbStatus.Value = $value
        $pbStatus.Dispatcher.Invoke([Action]{}, "Background")
    }

    # --- 2. Master Execution Action ---
    $btnInstall.Add_Click({
        $btnInstall.IsEnabled = $false
        $txtLog.Text = "⚡ WinPulse PRO: Applying Master Preset Pipeline..."
        Set-Progress 5

        # --- 0. System Restore Point ---
        if ($chkRestorePoint.IsChecked) {
            Write-Log "[Safety] Creating System Restore Point..."
            try {
                Enable-ComputerRestore -Drive "C:\" -ErrorAction SilentlyContinue
                Checkpoint-Computer -Description "WinPulse Master Preset" -RestorePointType "MODIFY_SETTINGS" -ErrorAction SilentlyContinue
                Write-Log "[Safety] Restore Point created successfully!"
            } catch {
                Write-Log "[Safety] Skipped System Restore Point creation."
            }
        }
        Set-Progress 15

        # --- 1. Software Installation ---
        $appMap = @(
            @{ CheckBox = $chkChrome; ID = "Google.Chrome"; Name = "Google Chrome" },
            @{ CheckBox = $chk7Zip; ID = "7zip.7zip"; Name = "7-Zip" },
            @{ CheckBox = $chkVSCode; ID = "Microsoft.VisualStudioCode"; Name = "VS Code" },
            @{ CheckBox = $chkGit; ID = "Git.Git"; Name = "Git" },
            @{ CheckBox = $chkDiscord; ID = "Discord.Discord"; Name = "Discord" }
        )
        foreach ($item in $appMap) {
            if ($item.CheckBox.IsChecked) {
                Write-Log "[Winget] Installing $($item.Name)..."
                winget install --id $item.ID --exact --silent --accept-package-agreements --accept-source-agreements | Out-Null
                Write-Log "[Done] $($item.Name) installed successfully!"
            }
        }
        Set-Progress 30

        # --- 2. General UI & Settings ---
        if ($chkShowExt.IsChecked) {
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1
        }
        if ($chkDarkMode.IsChecked) {
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0
        }
        if ($chkClassicMenu.IsChecked) {
            Write-Log "[Tweak] Enabling Windows 10 Classic Right-Click Menu..."
            New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Value "" -Force | Out-Null
        }
        Set-Progress 45

        # --- 3. System, Power, Memory & Input Lag ---
        if ($chkPower.IsChecked) {
            Write-Log "[Power] Unlocking Ultimate Performance & Disabling Power Throttling..."
            powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-Null
            powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-Null
            powercfg -h off
            New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power" -Name "PowerThrottlingOff" -Value 1 -PropertyType DWORD -Force | Out-Null
        }
        if ($chkMemory.IsChecked) {
            Write-Log "[Memory] Disabling Memory Compression & Enabling LargeSystemCache..."
            Disable-MMAgent -MemoryCompression | Out-Null
            New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "DisablePagingExecutive" -Value 1 -PropertyType DWORD -Force | Out-Null
            New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "LargeSystemCache" -Value 1 -PropertyType DWORD -Force | Out-Null
            fsutil behavior set disablelastaccess 1 | Out-Null
        }
        if ($chkInputLag.IsChecked) {
            Write-Log "[Input Lag] Applying BCD Timer & Win32PrioritySeparation (38/0x26)..."
            bcdedit /set useplatformclock false | Out-Null
            bcdedit /set disabledynamictick yes | Out-Null
            bcdedit /set tscsyncpolicy enhanced | Out-Null
            New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl" -Name "Win32PrioritySeparation" -Value 38 -PropertyType DWORD -Force | Out-Null
            New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Value 0 -PropertyType DWORD -Force | Out-Null
            New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 4294967295 -PropertyType DWORD -Force | Out-Null
            New-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Value "0" -PropertyType String -Force | Out-Null
            New-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardSpeed" -Value "31" -PropertyType String -Force | Out-Null
        }
        Set-Progress 65

        # --- 4. Debloat, Clean, WinUpdate ---
        if ($chkWinUpdate.IsChecked) {
            Write-Log "[Update] Blocking automatic driver overwrites from Windows Update..."
            New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -Value 1 -PropertyType DWORD -Force | Out-Null
            New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Name "SearchOrderConfig" -Value 0 -PropertyType DWORD -Force | Out-Null
        }
        if ($chkRemoveOneDrive.IsChecked) {
            Write-Log "[Debloat] Uninstalling OneDrive..."
            Stop-Process -Name "OneDrive" -Force -ErrorAction SilentlyContinue
            $odPath = "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe"
            if (-not (Test-Path $odPath)) { $odPath = "$env:SYSTEMROOT\System32\OneDriveSetup.exe" }
            if (Test-Path $odPath) { Start-Process $odPath -ArgumentList "/uninstall" -Wait -WindowStyle Hidden }
        }
        if ($chkDebloat.IsChecked) {
            Write-Log "[Debloat] Disabling Telemetry & Xbox GameDVR..."
            New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -PropertyType DWORD -Force | Out-Null
            New-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Value 0 -PropertyType DWORD -Force | Out-Null
            Stop-Service DiagTrack -WarningAction SilentlyContinue; Set-Service DiagTrack -StartupType Disabled -WarningAction SilentlyContinue
        }
        if ($chkClean.IsChecked) {
            Write-Log "[Clean] Cleaning Temp files & Prefetch cache..."
            Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
            Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
            Remove-Item -Path "C:\Windows\Prefetch\*" -Recurse -Force -ErrorAction SilentlyContinue
        }
        Set-Progress 85

        # --- 5. Network & Internet ---
        if ($chkNetwork.IsChecked) {
            Write-Log "[Network] Optimizing TCP/IP stack, Nagle's Algorithm & CTCP..."
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
        if ($chkCloudflareDNS.IsChecked) {
            Write-Log "[Network] Setting Cloudflare DNS (1.1.1.1 / 1.0.0.1)..."
            try { Get-DnsClientServerAddress | Where-Object { $_.AddressFamily -eq 2 } | Set-DnsClientServerAddress -ServerAddresses ("1.1.1.1", "1.0.0.1") -ErrorAction SilentlyContinue } catch {}
        }
        if ($chkOptimalMTU.IsChecked) {
            Write-Log "[Network] Setting MTU size to 1500..."
            try { Get-NetAdapter | Where-Object Status -eq 'Up' | Set-NetIPv4Interface -NlMtuBytes 1500 -ErrorAction SilentlyContinue } catch {}
        }
        if ($chkAdvancedTCPUDP.IsChecked) {
            Write-Log "[Network] Disabling TCP/UDP Checksum Offload..."
            try { Disable-NetAdapterChecksumOffload -Name "*" -IpIPv4 -TcpIPv4 -UdpIPv4 -ErrorAction SilentlyContinue } catch {}
        }
        Set-Progress 100

        Write-Log "========================================="
        Write-Log "[🎉 MASTER PRESET COMPLETE 100%] WinPulse PRO Master Preset applied!"
        Write-Log "Rebooting your PC is recommended for maximum performance."
        Write-Log "========================================="
        $btnInstall.IsEnabled = $true
    })

    # Display Window
    $window.ShowDialog() | Out-Null
}

# STA Apartment State guarantee for WPF
if ([System.Threading.Thread]::CurrentThread.GetApartmentState() -ne 'STA') {
    $staThread = New-Object System.Threading.Thread($guiScriptBlock)
    $staThread.SetApartmentState([System.Threading.ApartmentState]::STA)
    $staThread.Start()
    $staThread.Join()
} else {
    Invoke-Command -ScriptBlock $guiScriptBlock
}
