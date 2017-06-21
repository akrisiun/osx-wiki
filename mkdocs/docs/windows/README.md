# Other links:  

[powershell](powershell.md)
netstat -atn -p TCP | findstr "ESTA"

## profile.win10

Setup tasks for empty Windows 10

1. install/reset windows  
2. download chrome  

### 3. install choco from https://chocolatey.org/install 

run cmd as admin  
```
PowerShell.exe -ExecutionPolicy Unrestricted
@powershell 
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
```

### 4. choco install tasks  

`choco install -y conemu`
finally open real console conemu 
```
choco feature list
choco feature enable -n=allowGlobalConfirmation

choco install git kdiff3
choco install git-credential-manager-for-windows
```
gitextensions install manually, no visual studio plugins please

### 5. setup PATH, TEMP

```
PATH=c:\bin;c:\System;c:\Program Files\Git\bin\;d:\tools;%USERPROFILE%\AppData\Local\Microsoft\WindowsApps;C:\Program Files\kdiff3
TEMP=c:\Temp
```

GIT:
```
git config core.whitespace nowarn
git config core.filemode false
```

### 6. Visual Studio

```
choco install notepadplusplus.install visualstudiocode
choco install netfx-4.5.1-devpack netfx-4.5.2-devpack

# choco install -f -y netfx-4.5.1-devpack netfx-4.5.2-devpack dotnet4.6-targetpack microsoft-build-tools dotnet4.6.1-devpack

choco install visualstudiocommunity2013
choco install vs2013.5
choco install visualstudio2013-sdk
choco install vsredist2013 windows-sdk-8.1 

choco install windows-sdk-10.0
choco install dotnet4.6-targetpack microsoft-build-tools 
choco install dotnet4.6.1-devpack

choco install dotnetcore-sdk -y
```

### 7. SQL Server 

Sqlserver 1.04 GB, SSME 2012 825MB :( 
```
choco install mssqlserver2012express sql-server-management-studio
// only ssme ??? 
choco install sql-server-management-studio
```

### 8. IIS

MVC5 fix:  
C:\Program Files (x86)\Microsoft ASP.NET\ASP.NET MVC 4\Assemblies\
C:\Program Files (x86)\Microsoft ASP.NET\ASP.NET Web Pages\v2.0\Assemblies\

MSBUILD 14.0\  
C:\Program Files (x86)\Microsoft Visual Studio 14.0\
Common7\IDE\CommonExtensions\Microsoft\TestWindow\

### Virtual machines

Docker: <https://github.com/phusion/baseimage-docker#running_startup_scripts>

<https://github.com/tmatilai/vagrant-proxyconf>

Vagrant proxy
vagrant plugin install ./vagrant-proxyconf*.gem --verbose

vagrant plugin install vagrant-proxyconf
vagrant plugin install vagrant-omnibus