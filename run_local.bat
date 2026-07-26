@echo off
:: Script to run the PowerShell GUI locally as Administrator
echo Requesting Administrator privileges (if needed)...
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Running with Administrator privileges...
    goto :RunScript
) else (
    echo Elevating privileges...
    powershell -Command "Start-Process '%~dpnx0' -Verb RunAs"
    exit /b
)

:RunScript
cd /d "%~dp0"
echo Launching Custom Windows Setup GUI...
powershell -NoProfile -ExecutionPolicy Bypass -File "gui_preset.ps1"
