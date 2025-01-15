function Show-Menu {
    param (
        [string[]]$Options
    )

    $selectedIndex = 0

    while ($true) {
        Write-Host "Pick an option"

        # Display the menu options
        for ($i = 0; $i -lt $Options.Count; $i++) {
            if ($i -eq $selectedIndex) {
                Write-Host -ForegroundColor Cyan (" > " + $Options[$i])
            } else {
                Write-Host ("   " + $Options[$i])
            }
        }

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
        Clear-Host # Clear the console before redrawing the menu
    }
}

# Define package manager options
$packageManagers = @("npm", "yarn", "pnpm")

# Display the menu and get the user's choice
$selectedPackageManager = Show-Menu -Options $packageManagers

Write-Host "You selected: $selectedPackageManager"

# Check the selected package manager
if ($selectedPackageManager -eq "npm") {
    Write-Host "NPM SELECTED"
} else {
    Write-Host "NPM NOT SELECTED"
}