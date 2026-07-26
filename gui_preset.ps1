<#
.SYNOPSIS
    WinPulse - Ultimate Custom Windows Setup & Optimizer Tool with WPF GUI
.DESCRIPTION
    Combines software installation, system tweaks, debloating, and network optimization.
    Version: PRO
#>

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

# --- 1. ออกแบบหน้าต่าง GUI (WPF XAML) ---
[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="WinPulse - Ultimate Windows Setup &amp; Optimizer PRO" Height="780" Width="1000"
        WindowStartupLocation="CenterScreen" Background="#11111B" Foreground="#CDD6F4"
        FontFamily="Segoe UI" FontSize="14">
    <Grid Margin="20">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="120"/>
        </Grid.RowDefinitions>

        <!-- Header -->
        <Border Grid.Row="0" Background="#1E1E2E" CornerRadius="8" Padding="15" Margin="0,0,0,15">
            <StackPanel Orientation="Horizontal" HorizontalAlignment="Center">
                <TextBlock Text="⚡" FontSize="26" Margin="0,0,10,0"/>
                <TextBlock Text="WINPULSE - WINDOWS OPTIMIZER PRO" FontSize="24" FontWeight="Black" Foreground="#89B4FA" VerticalAlignment="Center"/>
            </StackPanel>
        </Border>

        <!-- Safety Option -->
        <Border Grid.Row="1" Background="#313244" CornerRadius="6" Padding="10" Margin="0,0,0,15">
            <CheckBox x:Name="chkRestorePoint" Content="🛡️ สร้าง System Restore Point ก่อนเริ่มทำงาน (แนะนำเพื่อความปลอดภัย)" IsChecked="True" FontWeight="Bold" Foreground="#A6E3A1"/>
        </Border>

        <!-- Main Options Grid -->
        <Grid Grid.Row="2">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="1*"/>
                <ColumnDefinition Width="1.2*"/>
                <ColumnDefinition Width="1.2*"/>
            </Grid.ColumnDefinitions>

            <!-- Column 1: Software & General -->
            <Border Grid.Column="0" Background="#181825" CornerRadius="8" Padding="15" Margin="0,0,10,10">
                <StackPanel>
                    <TextBlock Text="📦 โปรแกรม (Winget)" FontWeight="Bold" Foreground="#F9E2AF" Margin="0,0,0,10"/>
                    <CheckBox x:Name="chkChrome" Content="Google Chrome" Foreground="#CDD6F4" Margin="0,5"/>
                    <CheckBox x:Name="chk7Zip" Content="7-Zip" Foreground="#CDD6F4" Margin="0,5"/>
                    <CheckBox x:Name="chkVSCode" Content="VS Code" Foreground="#CDD6F4" Margin="0,5"/>
                    <CheckBox x:Name="chkGit" Content="Git" Foreground="#CDD6F4" Margin="0,5"/>
                    <CheckBox x:Name="chkDiscord" Content="Discord" Foreground="#CDD6F4" Margin="0,5"/>
                    
                    <Separator Margin="0,15,0,15" Background="#313244"/>
                    
                    <TextBlock Text="🎨 ปรับแต่งทั่วไป" FontWeight="Bold" Foreground="#F9E2AF" Margin="0,0,0,10"/>
                    <CheckBox x:Name="chkShowExt" Content="โชว์นามสกุล &amp; ไฟล์ซ่อน" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                    <CheckBox x:Name="chkDarkMode" Content="เปิดใช้ Dark Mode" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                    <CheckBox x:Name="chkClassicMenu" Content="🖱️ นำคลิกขวา Win 10 กลับมา" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                </StackPanel>
            </Border>

            <!-- Column 2: System Tweaks & Debloat -->
            <Border Grid.Column="1" Background="#181825" CornerRadius="8" Padding="15" Margin="5,0,5,10">
                <StackPanel>
                    <TextBlock Text="🛠️ ปรับแต่งระบบ &amp; พลังงาน" FontWeight="Bold" Foreground="#F38BA8" Margin="0,0,0,10"/>
                    <CheckBox x:Name="chkPower" Content="🔋 Ultimate Performance Plan" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                    <CheckBox x:Name="chkMemory" Content="🧠 ปิดบีบอัดแรม (ลดกระตุก)" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                    <CheckBox x:Name="chkInputLag" Content="⚡ Reduce Input Lag (BCD/Timer)" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                    
                    <Separator Margin="0,15,0,15" Background="#313244"/>

                    <TextBlock Text="🗑️ ลบขยะ &amp; ปิดการอัปเดต" FontWeight="Bold" Foreground="#F38BA8" Margin="0,0,0,10"/>
                    <CheckBox x:Name="chkRemoveOneDrive" Content="ลบ OneDrive &amp; Bloatware" IsChecked="False" Foreground="#CDD6F4" Margin="0,5"/>
                    <CheckBox x:Name="chkDebloat" Content="ปิด Telemetry &amp; Xbox DVR" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                    <CheckBox x:Name="chkClean" Content="ล้างไฟล์ Cache &amp; Temp" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                    <CheckBox x:Name="chkWinUpdate" Content="ห้าม Windows โหลด Driver ทับ" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                </StackPanel>
            </Border>

            <!-- Column 3: Network & Gaming -->
            <Border Grid.Column="2" Background="#181825" CornerRadius="8" Padding="15" Margin="10,0,0,10">
                <StackPanel>
                    <TextBlock Text="🌐 เครือข่าย &amp; อินเทอร์เน็ต" FontWeight="Bold" Foreground="#89DCEB" Margin="0,0,0,10"/>
                    <CheckBox x:Name="chkNetwork" Content="ลดปิง &amp; จัดการ TCP/IP (Low Delay)" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                    <CheckBox x:Name="chkCloudflareDNS" Content="เปลี่ยน DNS เป็น Cloudflare (1.1.1.1)" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                    <CheckBox x:Name="chkOptimalMTU" Content="ตั้งค่า Optimal MTU (1500)" IsChecked="True" Foreground="#CDD6F4" Margin="0,5"/>
                    <CheckBox x:Name="chkAdvancedTCPUDP" Content="ปิด TCP/UDP Offload (เน้นความเสถียร)" IsChecked="False" Foreground="#CDD6F4" Margin="0,5"/>
                </StackPanel>
            </Border>
        </Grid>

        <!-- ปุ่มกดเริ่มทำงาน & Progress Bar -->
        <StackPanel Grid.Row="3" Margin="0,5,0,15">
            <Button x:Name="btnInstall" Content="🚀 เริ่มดำเนินการทั้งหมด" Height="45" Background="#89B4FA" Foreground="#11111B" FontWeight="Bold" FontSize="16" Margin="0,0,0,10">
                <Button.Resources>
                    <Style TargetType="Border">
                        <Setter Property="CornerRadius" Value="6"/>
                    </Style>
                </Button.Resources>
            </Button>
            <ProgressBar x:Name="pbStatus" Height="15" Minimum="0" Maximum="100" Value="0" Background="#313244" Foreground="#A6E3A1">
                <ProgressBar.Resources>
                    <Style TargetType="Border">
                        <Setter Property="CornerRadius" Value="4"/>
                    </Style>
                </ProgressBar.Resources>
            </ProgressBar>
        </StackPanel>

        <!-- กล่อง Log แสดงสถานะ -->
        <Border Grid.Row="4" Background="#1E1E2E" CornerRadius="6" Padding="10">
            <ScrollViewer VerticalScrollBarVisibility="Auto">
                <TextBlock x:Name="txtLog" Text="WinPulse Ready... (กรุณาเลือกหัวข้อที่ต้องการ)" Foreground="#A6ADC8" FontFamily="Consolas" FontSize="13" TextWrapping="Wrap"/>
            </ScrollViewer>
        </Border>
    </Grid>
</Window>
"@

# อ่านโค้ด XAML โหลดขึ้น WPF
$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)

# ดึง Element
$btnInstall = $window.FindName("btnInstall")
$txtLog = $window.FindName("txtLog")
$pbStatus = $window.FindName("pbStatus")

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


function Write-Log($msg) {
    $txtLog.Text += "`n" + $msg
    $txtLog.Dispatcher.Invoke([Action]{}, "Background")
}

function Set-Progress($value) {
    $pbStatus.Value = $value
    $pbStatus.Dispatcher.Invoke([Action]{}, "Background")
}

# --- 2. การทำงานของปุ่ม Install ---
$btnInstall.Add_Click({
    $btnInstall.IsEnabled = $false
    $txtLog.Text = "⚡ WinPulse: เริ่มกระบวนการปรับแต่งระบบ..."
    Set-Progress 5

    # --- 0. System Restore Point ---
    if ($chkRestorePoint.IsChecked) {
        Write-Log "[Safety] กำลังสร้าง System Restore Point (อาจใช้เวลาสักครู่)..."
        try {
            Enable-ComputerRestore -Drive "C:\" -ErrorAction SilentlyContinue
            Checkpoint-Computer -Description "WinPulse Restore Point" -RestorePointType "MODIFY_SETTINGS" -ErrorAction SilentlyContinue
            Write-Log "[Safety] สร้าง Restore Point สำเร็จ!"
        } catch {
            Write-Log "[Safety] ไม่สามารถสร้าง Restore Point ได้ (ข้าม)"
        }
    }
    Set-Progress 15

    # --- 1. Software & Apps ---
    $appMap = @(
        @{ CheckBox = $chkChrome; ID = "Google.Chrome"; Name = "Google Chrome" },
        @{ CheckBox = $chk7Zip; ID = "7zip.7zip"; Name = "7-Zip" },
        @{ CheckBox = $chkVSCode; ID = "Microsoft.VisualStudioCode"; Name = "VS Code" },
        @{ CheckBox = $chkGit; ID = "Git.Git"; Name = "Git" },
        @{ CheckBox = $chkDiscord; ID = "Discord.Discord"; Name = "Discord" }
    )
    foreach ($item in $appMap) {
        if ($item.CheckBox.IsChecked) {
            Write-Log "[Winget] กำลังติดตั้ง $($item.Name)..."
            winget install --id $item.ID --exact --silent --accept-package-agreements --accept-source-agreements | Out-Null
            Write-Log "[Done] ติดตั้ง $($item.Name) สำเร็จ!"
        }
    }
    Set-Progress 30

    # --- 2. General Settings ---
    if ($chkShowExt.IsChecked) {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1
    }
    if ($chkDarkMode.IsChecked) {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0
    }
    if ($chkClassicMenu.IsChecked) {
        Write-Log "[Tweak] เปิดใช้งานคลิกขวาแบบ Classic (Win 10) บน Win 11..."
        New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Value "" -Force | Out-Null
    }
    Set-Progress 45

    # --- 3. System, Power, Memory & Input Lag ---
    if ($chkPower.IsChecked) {
        Write-Log "[Power] เปิดโหมด Ultimate Performance..."
        powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-Null
        powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-Null
        New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power" -Name "PowerThrottlingOff" -Value 1 -PropertyType DWORD -Force | Out-Null
    }
    if ($chkMemory.IsChecked) {
        Write-Log "[Memory] ปิด Memory Compression เพื่อความลื่นไหล..."
        Disable-MMAgent -MemoryCompression | Out-Null
        New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "DisablePagingExecutive" -Value 1 -PropertyType DWORD -Force | Out-Null
    }
    if ($chkInputLag.IsChecked) {
        Write-Log "[Lag] ลด Input Lag (Win32Priority / Disable Dynamic Tick)..."
        bcdedit /set useplatformclock false | Out-Null
        bcdedit /set disabledynamictick yes | Out-Null
        New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl" -Name "Win32PrioritySeparation" -Value 38 -PropertyType DWORD -Force | Out-Null
    }
    Set-Progress 60

    # --- 4. Debloat, Clean, WinUpdate ---
    if ($chkWinUpdate.IsChecked) {
        Write-Log "[Update] ห้าม Windows Update โหลดไดร์เวอร์มาทับ..."
        New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -Value 1 -PropertyType DWORD -Force | Out-Null
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Name "SearchOrderConfig" -Value 0 -PropertyType DWORD -Force | Out-Null
    }
    if ($chkRemoveOneDrive.IsChecked) {
        Write-Log "[Debloat] กำลังลบ OneDrive ออกจากระบบ..."
        Stop-Process -Name "OneDrive" -Force -ErrorAction SilentlyContinue
        $odPath = "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe"
        if (-not (Test-Path $odPath)) { $odPath = "$env:SYSTEMROOT\System32\OneDriveSetup.exe" }
        if (Test-Path $odPath) { Start-Process $odPath -ArgumentList "/uninstall" -Wait -WindowStyle Hidden }
    }
    if ($chkDebloat.IsChecked) {
        Write-Log "[Debloat] ปิด Telemetry & Xbox DVR..."
        New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -PropertyType DWORD -Force | Out-Null
        New-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Value 0 -PropertyType DWORD -Force | Out-Null
    }
    if ($chkClean.IsChecked) {
        Write-Log "[Clean] ล้างไฟล์ขยะ Cache & Temp..."
        Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    }
    Set-Progress 75

    # --- 5. Network & Internet ---
    if ($chkNetwork.IsChecked) {
        Write-Log "[Network] ปรับแต่ง TCP/IP สำหรับเล่นเกม..."
        netsh int tcp set global autotuninglevel=normal | Out-Null
        netsh int tcp set global ecncapability=disabled | Out-Null
        netsh int tcp set global timestamps=disabled | Out-Null
        $interfaces = Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\*"
        foreach ($iface in $interfaces) {
            New-ItemProperty -Path $iface.PSPath -Name "TcpAckFrequency" -Value 1 -PropertyType DWORD -Force | Out-Null
            New-ItemProperty -Path $iface.PSPath -Name "TCPNoDelay" -Value 1 -PropertyType DWORD -Force | Out-Null
        }
    }
    if ($chkCloudflareDNS.IsChecked) {
        Write-Log "[Network] เปลี่ยน DNS เป็น Cloudflare..."
        try { Get-DnsClientServerAddress | Where-Object { $_.AddressFamily -eq 2 } | Set-DnsClientServerAddress -ServerAddresses ("1.1.1.1", "1.0.0.1") -ErrorAction SilentlyContinue } catch {}
    }
    if ($chkOptimalMTU.IsChecked) {
        Write-Log "[Network] ปรับ MTU เป็น 1500..."
        try { Get-NetAdapter | Where-Object Status -eq 'Up' | Set-NetIPv4Interface -NlMtuBytes 1500 -ErrorAction SilentlyContinue } catch {}
    }
    if ($chkAdvancedTCPUDP.IsChecked) {
        Write-Log "[Network] ปิด TCP/UDP Checksum Offload..."
        try { Disable-NetAdapterChecksumOffload -Name "*" -IpIPv4 -TcpIPv4 -UdpIPv4 -ErrorAction SilentlyContinue } catch {}
    }
    Set-Progress 100

    Write-Log "========================================="
    Write-Log "[🎉 เสร็จสมบูรณ์ 100%] WinPulse ทำงานเรียบร้อยแล้ว!"
    Write-Log "แนะนำให้ รีสตาร์ทคอมพิวเตอร์ 1 ครั้ง เพื่อให้เห็นผล 100%"
    Write-Log "========================================="
    $btnInstall.IsEnabled = $true
})

# แสดงหน้าต่าง GUI
$window.ShowDialog() | Out-Null
