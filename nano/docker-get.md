### Machine
$  .\docker-machine.exe --debug create -d hyperv dev2

docker-machine create -d virtualbox dev 
eval "$(docker-machine env dev)" 

docker-machine --github-api-token=token create -d hyperv dev3
https://help.github.com/articles/creating-an-access-token-for-command-line-use/ : 

docker-machine create --url=tcp://50.134.234.20:2376 custombox

curl -L https://github.com/docker/machine/releases/download/v0.5.0/docker-machine_windows-amd64.zip -k > machine.zip
https://msdn.microsoft.com/en-us/virtualization/windowscontainers/quick_start/container_setup

### Powershell

@PS
Get-VMSwitch * 
Get-VMSwitch | where {$_.SwitchType –eq ‥External”}

wget -uri https://aka.ms/tp4/New-ContainerHost -OutFile D:\vm\New-ContainerHost.ps1

./New-ContainerHost.ps1 –VmName Core1 -WindowsImage ServerDatacenterCore -Hyperv

c:\bin\docker\docker run --name iisnanobase -it -v c:\share:c:\iisinstall --isolation=hyperv nanoserver cmd

./docker-machine regenerate-certs dev2
./docker-machine.exe create -d hyper-v dev
./docker-machine.exe --debug create -d hyperv dev2

HyperV Virtual switch : Main : allow sharing connection
vEthernet New Switch : default config, Hyper [x] Allow management, [x] Enable LAN virtual 

C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile Start-VM -Name dev2
 C:\bin\docker-machine.exe env --shell powershell dev2 | Invoke-Expression
 
 Example:

$ docker-machine create \
    --driver digitalocean \
    --digitalocean-access-token 0ab77166d407f479c6701652c???????????2b21621736ab2d4 \
    staging
Creating SSH key...
Creating Digital Ocean droplet...
To see how to connect Docker to this machine, run: docker-machine env staging

https://auth.docker.io/token

  "IPAddress": "192.168.137.16",
        "MachineName": "dev2",
        "SSHUser": "docker",
        "SSHPort": 22,
        "SSHKeyPath": "C:\\Users\\???\\.docker\\machine\\machines\\dev2\\id_rsa",
        "StorePath": "C:\\Users\\???\\.docker\\machine",
        "SwarmMaster": false,
        "SwarmHost": "tcp://0.0.0.0:3376",
		
export DOCKER_HOST="tcp://10.211.55.7:2376"

10.211.55.7

$  .\docker-machine.exe --debug create -d hyperv dev2

Docker Machine Version: 0.5.1 (7e8e38e)
Found binary path at .\docker-machine-driver-hyperv.exe 
Plugin server listening at address 127.0.0.1:53211 
Successfully made call to close driver server
Found binary path at .\docker-machine-driver-hyperv.exe
Launching plugin server for driver hyperv
Plugin server listening at address 127.0.0.1:53215
(dev2) Calling RPCServerDriver.Create

powershell.exe -NoProfile @(Get-Command Get-VM).ModuleName
powershell.exe -NoProfile @(Get-VMSwitch).Name
(dev2) DBG | [stdout =====>] : New Virtual Switch
powershell.exe -NoProfile New-VHD -Path 'C:\Users\???\.docker\machine\machines\dev2\fixed.vhd' -SizeBytes 10MB -Fixed
(dev2) DBG | Path                    : C:\Users\???\.docker\machine\machines\dev2\fixed.v
powershell.exe -NoProfile Convert-VHD -Path 'C:\Users\???\.docker\machine\machines\de
v2\fixed.vhd' -DestinationPath 'C:\Users\???\.docker\machine\machines\dev2\di
sk.vhd' -VHDType Dynamic

powershell.exe -NoProfile Resize-VHD -Path 'C:\Users\???\.docker\machine\machines\dev
2\disk.vhd' -SizeBytes 20000MB

powershell.exe -NoProfile New-VM -Name dev2 -Path 'C:\Users\???\.docker\machine\machines\dev2' -MemoryStartupBytes 1024MB
(dev2) DBG | Name State CPUUsage(%) MemoryAssigned(M) Uptime   StatusVersion
(dev2) DBG | ---- ----- ----------- ----------------- ------   -------------
(dev2) DBG | dev2 Off   0           0                 00:00:00 Operating normally7.0
powershell.exe -NoProfile Set-VMDvdDrive -VMName dev2 -Path 'C:\Users\???\.docker\mac
hine\machines\dev2\boot2docker.iso'

powershell.exe -NoProfile Add-VMHardDiskDrive -VMName dev2 -Path 'C:\Users\???\.docke
r\machine\machines\dev2\disk.vhd'
powershell.exe -NoProfile Connect-VMNetworkAdapter -VMName dev2 -SwitchName 'New Virtual S
witch'

C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile Start-VM -Name dev2
Error creating machine: Error in driver during machine creation: exit status 1

