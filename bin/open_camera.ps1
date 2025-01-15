# Open camera using PowerShell
Start-Process "microsoft.windows.camera:" -WindowStyle Hidden

# Check if the camera app is running
$cameraProcess = Get-Process -Name "WindowsCamera" -ErrorAction SilentlyContinue

if ($cameraProcess) {
    Write-Host "Camera app is running."

    # Create a .NET object for simulating keystrokes
    Add-Type -AssemblyName System.Windows.Forms

    # Send the space key by its ASCII code
    [System.Windows.Forms.SendKeys]::SendWait([char]0x20)

    Write-Host "Photo taken."
} else {
    Write-Host "Camera app is not running."
}
