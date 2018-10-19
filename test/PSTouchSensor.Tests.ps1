Import-Module "$PSScriptRoot\..\PSTouchSensor.psd1" -Force

$IsRaspberryPi = (uname -a).Contains('raspberry')

Describe 'PSTouchSensor' {
    Context "Get-PSTouchSensor" {
        # This test will only pass if something is touching the sensor
        It 'Can get the value of the TouchSensor' -Skip:$(!$IsRaspberryPi) {
            (Get-PSTouchSensor).Result
            Get-GpioPin -Id 7
            (Get-PSTouchSensor).Result | Should -BeTrue
        }
    }
}
