[CmdletBinding()]
param(
    [switch]
    $Clean,

    [switch]
    $Bootstrap,

    [switch]
    $Test
)

# Bootstrap step
if ($Bootstrap.IsPresent) {
    Write-Log "Validate and install missing prerequisits for building ..."

    # Dependency of PSTouchSensor
    if (-not (Get-Module -Name Microsoft.PowerShell.IoT -ListAvailable)) {
        Write-Log -Warning "Module 'PSDepend' is missing. Installing 'PSDepend' ..."
        Install-Module -Name Microsoft.PowerShell.IoT -Scope CurrentUser -Force
    }

    # For testing
    if (-not (Get-Module -Name Pester -ListAvailable)) {
        Write-Log -Warning "Module 'Pester' is missing. Installing 'Pester' ..."
        Install-Module -Name Pester -Scope CurrentUser -Force
    }
}

# Clean step
if($Clean.IsPresent) {
    Push-Location $PSScriptRoot
    git clean -fdx
    Pop-Location
}

# Test step
if($Test.IsPresent) {
    if (-not (Get-Module -Name Pester -ListAvailable)) {
        throw "Cannot find the 'Pester' module. Please specify '-Bootstrap' to install build dependencies."
    }

    if($env:APPVEYOR) {
        $res = Invoke-Pester "$PSScriptRoot/test/Modules" -OutputFormat NUnitXml -OutputFile TestsResults.xml -PassThru
        (New-Object 'System.Net.WebClient').UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)", (Resolve-Path .\TestsResults.xml))
        if ($res.FailedCount -gt 0) { throw "$($res.FailedCount) tests failed." }
    } else {
        Invoke-Pester "$PSScriptRoot/test"
    }
}
