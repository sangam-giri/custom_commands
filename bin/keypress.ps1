# # Create a .NET object for simulating keystrokes
# $keyboard = New-Object -ComObject WScript.Shell

# # Send the "Enter" key
# $keyboard.SendKeys("{SPACE}")



# Create a .NET object for simulating keystrokes
Add-Type -AssemblyName System.Windows.Forms

# Send the space key by its ASCII code
[System.Windows.Forms.SendKeys]::SendWait([char]0x20)
