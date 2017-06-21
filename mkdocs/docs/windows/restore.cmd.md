@REM nuget config -set HTTP_PROXY=http://192.168.2.106:5865 -set HTTP_PROXY.USER= 

if not exist .nuget mkdir .nuget

set NURL=https://dist.nuget.org/win-x86-commandline/latest/nuget.exe
set NUGET=.nuget\nuget.exe
if not exist %~dp0%NUGET% @powershell Invoke-WebRequest %NURL% -OutFile %NUGET%

%NUGET% install -outputDirectory packages Newtonsoft.Json -version 9.0.1

@REM nuget install -outputDirectory Packages NuGet.Server -version 2.11.2
@REM console:  Update-Package -Reinstall
@REM console:  Update-Package -Reinstall -ProjectName <> -IgnoreDependencies

%NUGET% install -outputDirectory Packages   XUnit
%NUGET% install -outputDirectory Packages   Moq

%NUGET% install -outputDirectory Packages   NUnit            -version 3.2.1
%NUGET% install -outputDirectory Packages   NUnit.Mocks      -version 2.6.3
%NUGET% install -outputDirectory Packages   NUnitTestAdapter -version 2.0.0

%NUGET% install -outputDirectory Packages   FluentAssertions -version 4.9.0
%NUGET% install -outputDirectory Packages   NSubstitute -version 1.10.0.0
  
@PAUSE