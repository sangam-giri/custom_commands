function Show-Menu {
    param (
        [string[]]$Options
    )

    $selectedIndex = 0

    while ($true) {
        Clear-Host

        # Display the heading
        Write-Host "==============================" -ForegroundColor Yellow
        Write-Host "   SYSTEM INFORMATION MENU    " -ForegroundColor Green
        Write-Host "==============================" -ForegroundColor Yellow
        Write-Host ""

        # Display the menu options
        for ($i = 0; $i -lt $Options.Count; $i++) {
            if ($i -eq $selectedIndex) {
                Write-Host -ForegroundColor Cyan ("-> " + $Options[$i])
            } else {
                Write-Host ("   " + $Options[$i])
            }
        }

        Write-Host ""
        Write-Host "Use the arrow keys to navigate, and press Enter to select an option." -ForegroundColor DarkGray

        # Wait for key press
        $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").VirtualKeyCode

        # Handle arrow key presses
        switch ($key) {
            38 { # Up arrow key
                $selectedIndex = [Math]::Max(0, $selectedIndex - 1)
            }
            40 { # Down arrow key
                $selectedIndex = [Math]::Min($Options.Count - 1, $selectedIndex + 1)
            }
            13 { # Enter key
                return $Options[$selectedIndex]
            }
        }
    }
}

function Get-BatteryInfo {
    Write-Host "`n--- Battery Information ---`n" -ForegroundColor Green
    $battery = Get-WmiObject -Class Win32_Battery
    if ($battery) {
        $batteryPercentage = $battery.EstimatedChargeRemaining
        Write-Host "Battery Percentage: $batteryPercentage%"
    } else {
        Write-Host "No battery found."
    }
}

function Get-CPUInfo {
    Write-Host "`n--- CPU Information ---`n" -ForegroundColor Green
    $cpu = Get-WmiObject -Class Win32_Processor
    $cpuName = $cpu.Name
    $cpuCores = $cpu.NumberOfCores
    $cpuMaxClockSpeed = $cpu.MaxClockSpeed
    Write-Host "CPU Name: $cpuName"
    Write-Host "Number of Cores: $cpuCores"
    Write-Host "Max Clock Speed: $cpuMaxClockSpeed MHz"
}

function Get-RAMInfo {
    Write-Host "`n--- RAM Information ---`n" -ForegroundColor Green
    $ram = Get-WmiObject -Class Win32_PhysicalMemory
    $totalMemory = ($ram.Capacity | Measure-Object -Sum).Sum / 1GB
    Write-Host "Total RAM: $([math]::Round($totalMemory, 2)) GB"
}

function Get-DiskInfo {
    Write-Host "`n--- Disk Information ---`n" -ForegroundColor Green
    $disks = Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType = 3"
    foreach ($disk in $disks) {
        $diskSize = $disk.Size / 1GB
        $freeSpace = $disk.FreeSpace / 1GB
        Write-Host "Drive: $($disk.DeviceID)"
        Write-Host "Total Size: $([math]::Round($diskSize, 2)) GB"
        Write-Host "Free Space: $([math]::Round($freeSpace, 2)) GB"
        Write-Host "-----------------------------"
    }
}

function Get-OSInfo {
    Write-Host "`n--- Operating System Information ---`n" -ForegroundColor Green
    $os = Get-WmiObject -Class Win32_OperatingSystem
    $osName = $os.Caption
    $osVersion = $os.Version
    $osArchitecture = $os.OSArchitecture
    Write-Host "Operating System: $osName"
    Write-Host "Version: $osVersion"
    Write-Host "Architecture: $osArchitecture"
}

function Get-NetworkInfo {
    Write-Host "`n--- Network Adapter Information ---`n" -ForegroundColor Green
    $adapters = Get-WmiObject -Class Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true }
    foreach ($adapter in $adapters) {
        $adapterName = $adapter.Description
        $ipAddress = $adapter.IPAddress[0]
        $macAddress = $adapter.MACAddress
        Write-Host "Adapter Name: $adapterName"
        Write-Host "IP Address: $ipAddress"
        Write-Host "MAC Address: $macAddress"
        Write-Host "-----------------------------"
    }
}

function Get-GPUInfo {
    Write-Host "`n--- GPU Information ---`n" -ForegroundColor Green
    $gpu = Get-WmiObject -Class Win32_VideoController
    $gpuName = $gpu.Name
    $gpuDriverVersion = $gpu.DriverVersion
    Write-Host "GPU Name: $gpuName"
    Write-Host "Driver Version: $gpuDriverVersion"
}

function Get-BIOSInfo {
    Write-Host "`n--- BIOS Information ---`n" -ForegroundColor Green
    $bios = Get-WmiObject -Class Win32_BIOS
    $biosVersion = $bios.SMBIOSBIOSVersion
    $biosManufacturer = $bios.Manufacturer
    $biosReleaseDate = $bios.ReleaseDate
    Write-Host "BIOS Version: $biosVersion"
    Write-Host "BIOS Manufacturer: $biosManufacturer"
    Write-Host "BIOS Release Date: $biosReleaseDate"
}

function Get-AllInfo {
    Get-BatteryInfo
    Get-CPUInfo
    Get-RAMInfo
    Get-DiskInfo
    Get-OSInfo
    Get-NetworkInfo
    Get-GPUInfo
    Get-BIOSInfo
}

# Define system information options
$systemInfoOptions = @(
    "Battery Information",
    "CPU Information",
    "RAM Information",
    "Disk Information",
    "Operating System Information",
    "Network Adapter Information",
    "GPU Information",
    "BIOS Information",
    "Show All Information",
    "Exit"
)

# Display the menu and get the user's choice
$selectedOption = Show-Menu -Options $systemInfoOptions

# Execute the selected option
switch ($selectedOption) {
    "Battery Information" { Get-BatteryInfo }
    "CPU Information" { Get-CPUInfo }
    "RAM Information" { Get-RAMInfo }
    "Disk Information" { Get-DiskInfo }
    "Operating System Information" { Get-OSInfo }
    "Network Adapter Information" { Get-NetworkInfo }
    "GPU Information" { Get-GPUInfo }
    "BIOS Information" { Get-BIOSInfo }
    "Show All Information" { Get-AllInfo }
    "Exit" { exit }
}

pause
