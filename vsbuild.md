README

I have a build machine that has, roughly, .NET 4.6, the VSO Agent, Microsoft Build Tools 2015 and the Agents for Visual Studio 2015 installed.
https://www.microsoft.com/en-us/download/details.aspx?id=48152
https://www.microsoft.com/en-us/download/confirmation.aspx?id=48152

vstest.console.cmd
C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe

C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\CommonExtensions\Microsoft\TestWindow

It seems this is caused by the Microsoft.TeamFoundation.DistributedTask.Task.Internal.PowerShell.InvokeVSTestCmdlet task not being able to properly resolve the location in which VSTest.console.exe is located; the GetVsTestLocation method attempts to resolve locations in which Visual Studio is installed (it is not installed in this scenario).
this machine at 
C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\CommonExtensions\Microsoft\TestWindow


Hi @spacemonkey1985,

What worked for me was to create the following registry key:
HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\14.0

and within that key, create a new value of type string with name ShellFolder and value C:\Program Files (x86)\Microsoft Visual Studio 14.0\.



ed as part of the Agents for Visual Studio 2015 package.

It seems that the path in which VSTest.console.exe is located can be retrieved by looking at the HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\14.0\EnterpriseTools\QualityTools registry key, where the InstallDir entry contains the right value.

As a workaround, faking a ShellFolder value in the HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\14.0 key also works.