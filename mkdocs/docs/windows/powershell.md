## Download nuget

@powershell  
netstat -atn -p TCP | findstr "ESTA"

@powershell  
Invoke-WebRequest %NURL% -OutFile %NUGET%

```
if not exist .nuget mkdir .nuget

set NURL=https://dist.nuget.org/win-x86-commandline/latest/nuget.exe
set NUGET=.nuget\nuget.exe
if not exist %~dp0%NUGET% @powershell Invoke-WebRequest %NURL% -OutFile %NUGET%

%NUGET% install -outputDirectory packages Newtonsoft.Json -version 9.0.1
```

## Network

```
 [System.Net.Dns]::GetHostbyAddress("192.168.2.106") | Select HostName
 
``` 