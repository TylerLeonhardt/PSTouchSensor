[CmdletBinding()]
param(
    [switch]
    $Bootstrap,

    [switch]
    $Test
)

# Bootstrap step
if ($Bootstrap.IsPresent) {
    Write-Host "Validate and install missing prerequisits for building ..."

    # Dependency of PSTouchSensor
    if (-not (Get-Module -Name Microsoft.PowerShell.IoT -ListAvailable)) {
        Write-Warning "Module 'PSDepend' is missing. Installing 'PSDepend' ..."
        Install-Module -Name Microsoft.PowerShell.IoT -Scope CurrentUser -Force
    }

    # For testing
    if (-not (Get-Module -Name Pester -ListAvailable)) {
        Write-Warning "Module 'Pester' is missing. Installing 'Pester' ..."
        Install-Module -Name Pester -Scope CurrentUser -Force
    }
}

# Test step
if($Test.IsPresent) {
    if (-not (Get-Module -Name Pester -ListAvailable)) {
        throw "Cannot find the 'Pester' module. Please specify '-Bootstrap' to install build dependencies."
    }

    $res = Invoke-Pester "$PSScriptRoot/test" -OutputFormat NUnitXml -OutputFile "TEST-PSTouchSensor.xml" -PassThru
    if ($res.FailedCount -gt 0) { throw "$($res.FailedCount) tests failed." }
}
