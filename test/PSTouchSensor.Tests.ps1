$ModuleManifestName = 'PSTouchSensor.psd1'
$ModuleManifestPath = "$PSScriptRoot\..\$ModuleManifestName"
Import-Module $ModuleManifestPath

Describe 'Get-PSTouchSensorValue' {
    # This test will only pass if something is touching the sensor
    It 'Can get the value of the TouchSensor' {
        (Get-PSTouchSensorValue).Value | Should -BeTrue
    }
}
