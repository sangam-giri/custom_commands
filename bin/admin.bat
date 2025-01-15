@echo off
if "%1"=="camera" (
    powershell -ExecutionPolicy Bypass -File "%~dp0open_camera.ps1"
) else if "%1"=="sleep" (
    powershell -ExecutionPolicy Bypass -File "%~dp0sleep.ps1"
) else if "%1"=="shutdown" (
    powershell -ExecutionPolicy Bypass -File "%~dp0shutdown.ps1"
) else if "%1"=="system" (
    powershell -ExecutionPolicy Bypass -File "%~dp0system.ps1"
) else if "%1"=="all_apps" (
    powershell -ExecutionPolicy Bypass -File "%~dp0list_apps.ps1"
) else (
    echo Invalid
)

