# Import necessary types from Win32 API
Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    
    public class PowrProf {
        [DllImport("PowrProf.dll", SetLastError=true)]
        public static extern bool SetSuspendState(bool hibernate, bool forceCritical, bool disableWakeEvent);
    }
"@

# Call SetSuspendState to put the PC to sleep
[PowrProf]::SetSuspendState($false, $false, $false)
