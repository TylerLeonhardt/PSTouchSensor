#Requires -Modules Microsoft.PowerShell.IoT

<#
.SYNOPSIS
Gets the value of the Touch Sensor

.DESCRIPTION
Gets the value of the Touch Sensor

.PARAMETER Pin
The Gpio pin to read from

.EXAMPLE
Get-PSTouchSensorValue

.NOTES
You must be running PowerShell with Sudo
#>
function Get-PSTouchSensorValue {
    [CmdletBinding()]
    param(
        [int]$Pin
    )

    if ($Pin) {
        $pinId = $Pin
    } elseif ($global:DefaultPSTouchSensorPin) {
        $pinId = $global:DefaultPSTouchSensorPin
    } else {
        $pinId = 7
    }

    # if (!$env:SUDO_UID) {
    #     throw "You must be running PowerShell with 'sudo' to use this module."
    # }

    return @{
        Value = Get-GpioPin -Id $pinId
    }
}
