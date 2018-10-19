Import-Module "$PSScriptRoot\..\PSTouchSensor.psd1" -Force

$IsRaspberryPi = (uname -a).Contains('raspberry')

Describe 'PSTouchSensor' {
    Context "Get-PSTouchSensor" {
        # This test will only pass if something is touching the sensor
        It 'Can get the value of the TouchSensor' -Skip:$(!$IsRaspberryPi) {
            Write-Host (Get-GpioPin -Id 7)
            Write-Host ((Get-PSTouchSensor).Result)
            (Get-PSTouchSensor).Result | Should -BeTrue
        }
    }

    Context 'Set-PSTouchSensorDefaultPin' {
        It 'Can set the value of the default pin used' {

            $m = Get-Module PSTouchSensor

            # Get internal value of the DEFAULT_PIN
            & $m { $script:DEFAULT_PIN } | Should -Be 7
            Set-PSTouchSensorDefaultPin -Pin 8
            & $m { $script:DEFAULT_PIN } | Should -Be 8
        }
    }
}
