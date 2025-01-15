# Get installed traditional desktop applications
$desktopApps = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*, HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* |
    Select-Object @{Name="Name"; Expression={$_.DisplayName}}, 
                  @{Name="Version"; Expression={$_.DisplayVersion}}, 
                  @{Name="Publisher"; Expression={$_.Publisher}}, 
                  @{Name="InstallPath"; Expression={$_.InstallLocation}}, 
                  @{Name="InstallDate"; Expression={$_.InstallDate}} |
    Sort-Object Name

# Get Microsoft Store apps
$storeApps = Get-AppxPackage -AllUsers |
    Select-Object @{Name="Name"; Expression={$_.Name}}, 
                  @{Name="PackageFullName"; Expression={$_.PackageFullName}}, 
                  @{Name="InstallPath"; Expression={$_.InstallLocation}} |
    Sort-Object Name

# Print results to the console
Write-Host "Traditional Applications:" -ForegroundColor Green
$desktopApps | Format-Table -AutoSize

Write-Host "`nMicrosoft Store Applications:" -ForegroundColor Cyan
$storeApps | Format-Table -AutoSize

# Optional: Export results to a file
$exportPath = "$PSScriptRoot\InstalledAppsWithPaths.txt"
$desktopApps | Out-File -FilePath $exportPath
$storeApps | Out-File -FilePath $exportPath -Append

Write-Host "`nResults have been saved to $exportPath" -ForegroundColor Yellow
