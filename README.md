# PSTouchSensor

[![Build Status](https://dev.azure.com/tylerl0706/PSTouchSensor/_apis/build/status/tylerl0706.PSTouchSensor)](https://dev.azure.com/tylerl0706/PSTouchSensor/_build/latest?definitionId=1)

A tiny PowerShell module that streamlines interacting with touch sensors like this:

![](https://i.pinimg.com/736x/df/02/f3/df02f33564dfe9aa990698bbe86e4aed--arduino-jog.jpg)

This project is built on top of [PowerShell IoT](https://github.com/powershell-iot) in order to interact with the sensor.

This was originally made for [PSConf Asia 2018](http://psconf.asia/) as a part of my talk "PowerShell IoT: A new frontier for PowerShell".

## Useful Links

* [Install PowerShell on Raspberry Pi](https://docs.microsoft.com/en-us/powershell/scripting/setup/installing-powershell-core-on-linux?view=powershell-6#raspbian)
* [Enable PowerShell Remoting (PSRP) over SSH](https://docs.microsoft.com/en-us/powershell/scripting/core-powershell/ssh-remoting-in-powershell-core?view=powershell-6#set-up-on-linux-ubuntu-1404-machine)
* [Configuring the Azure Pipelines Agent on Linux](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/v2-linux)

> NOTE: You need at least version v2.141.0 of the Azure Pipelines agent so you may need to download it [from GitHub](https://github.com/Microsoft/azure-pipelines-agent/releases).

## Gotchas

* The Azure Pipelines agent acts as a different user on Linux so you may need to change the permissions of the `pwsh` executable so the agent can execute `pwsh`. Simply run:

```sh
sudo chmod 755 ~/powershell/pwsh
```

* The link above to enable PowerShell remoting over SSH will only run `pwsh` as non-root. This is a problem because we need to be root in order to interact with hardware on Raspberry Pis. To fix this, you can add a new `Subsystem` to your `sshd_config` that looks like this:

```
Subsystem    powershell-sudo    sudo /usr/bin/pwsh -sshs -NoLogo -NoProfile
```

Then to use this subsystem, you can use the `-Subsystem` parameter:

```powershell
Enter-PSSession -HostName pi@192.168.123.123 -Subsystem powershell-sudo
```
