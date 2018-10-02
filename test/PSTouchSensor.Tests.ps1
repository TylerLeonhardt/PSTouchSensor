$ModuleManifestName = 'PSTouchSensor.psd1'
$ModuleManifestPath = "$PSScriptRoot\..\$ModuleManifestName"
Import-Module $ModuleManifestPath

Describe 'Module Manifest Tests' {
    It 'Passes Test-ModuleManifest' {
        Test-ModuleManifest -Path $ModuleManifestPath | Should Not BeNullOrEmpty
        $? | Should Be $true
    }
}

Describe 'Get-PSTouchSensorValue' {
    It 'Can get the value of the TouchSensor' {
        (Get-PSTouchSensorValue).Value | Should -Be $true
    }
}
