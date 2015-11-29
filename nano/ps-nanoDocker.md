### -- docker core Windows
### Image NanoServer.wim

https://github.com/Microsoft/Virtualization-Documentation/blob/master/virtualization/windowscontainers/deployment/docker_windows.md

wget https://aka.ms/ContainerTools -OutFile $env:SystemRoot\system32\msdocker.exe

wget https://nssm.cc/release/nssm-2.24.zip -OutFile $env:ALLUSERSPROFILE\nssm.zip
Expand-Archive -Path $env:ALLUSERSPROFILE\nssm.zip 
Copy-Item $env:ALLUSERSPROFILE\nssm-2.24\win64\nssm.exe $env:SystemRoot\system32

wget https://nssm.cc/release/nssm-2.24.zip -OutFile c:\bin\nssm.zip
Expand-Archive -Path c:\bin\nssm.zip c:\bin\
Copy-Item c:\bin\nssm-2.24\win64\nssm.exe $env:SystemRoot\system32

#######

New-Item -ItemType File -Path C:\ProgramData\Docker\runDockerDaemon.cmd -Force
Copy-Item c:\bin\runDockerDaemon.cmd C:\ProgramData\Docker\runDockerDaemon.cmd

start-process nssm install

Enter the following data into the corresponding fields in the NSSM service installer.

Application Tab:

Path: C:\Windows\System32\cmd.exe

Startup Directory: C:\Windows\System32

Arguments: /s /c C:\ProgramData\docker\runDockerDaemon.cmd

Service Name - Docker2

# removing:
sc.exe delete Docker
[SC] DeleteService SUCESS

# start 
docker daemon -D -b "Virtual Switch"

start-process cmd "/k docker daemon -D -b <Switch Name> -H 0.0.0.0:2375�
cmd "/k docker daemon -D -b "Virtual Switch" -H 0.0.0.0:2375�

Install-WindowsFeature containers
restart: shutdown /r

####
runDockerDaemon.cmd file. This batch file starts the Docker daemon with the command docker daemon �D �b �Virtual Switch�. Note: the name of the virtual switch in this file, will need to match the name of the virtual that containers will be using for network connectivity.

#runDockerDaemon.cmd
@echo off
set certs=%ProgramData%\docker\certs.d

if exist %ProgramData%\docker (goto :run)
mkdir %ProgramData%\docker

:run
if exist %certs%\server-cert.pem (goto :secure)

docker daemon -D -b "Virtual Switch"
goto :eof

:secure
docker daemon -D -b "Virtual Switch" -H 0.0.0.0:2376 --tlsverify --tlscacert=%certs%\ca.pem --tlscert=%certs%\server-cert.pem --tlskey=%certs%\server-key.pem


#######

Get-VM * 
Enable-PSRemoting -Force
Add-PswaAuthorizationRule -UserName <domain\u>

Install-PackageProvider ContainerProvider -Force
Find-ContainerImage

$con = New-Container -Name HYPVCON -ContainerImageName NanoServer -SwitchName "Virtual Switch" -RuntimeType HyperV


https://github.com/Microsoft/Virtualization-Documentation/blob/master/virtualization/windowscontainers/management/manage_images.md

Install-ContainerImage -Name NanoServer -Version 10.0.10586.0

Get-ContainerImage

New-ContainerImage -Container $container -Publisher Demo -Name DemoImage -Version 1.0
 
Get-ContainerImage | select Name, ParentImage


wget https://aka.ms/ContainerTools -OutFile $env:SystemRoot\system32\docker.exe
Create a directory named c:\programdata\docker. In this directory, create a file named runDockerDaemon.cmd.

PS C:\> New-Item -ItemType File -Path C:\ProgramData\Docker\runDockerDaemon.cmd -Force

