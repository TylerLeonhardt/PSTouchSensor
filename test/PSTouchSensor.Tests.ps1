$ModuleManifestName = 'PSTouchSensor.psd1'
$ModuleManifestPath = "$PSScriptRoot\..\$ModuleManifestName"
Import-Module $ModuleManifestPath

Describe 'Get-PSTouchSensor' {
    # This test will only pass if something is touching the sensor
    It 'Can get the value of the TouchSensor' {
        (Get-PSTouchSensor).Value | Should -BeTrue
    }
}
