cmder
d:
cd d:\VM\nano-Work\nano3\

./Convert-WindowsImage.ps1 
./New-NanoServerImage.ps1
./New-NanoServerVHD.ps1 -DestVHD d:\Work\nano3\Nano3.vhd -ComputerName Nano3 -AdministratorPassword 123 -Packages 'Storage','OEM-Drivers', 'Guest', 'Containers', 'IIS'


DISM does not support servicing a Windows Vista RTM or earlier operating system.
If the operating system is supported check that SSShim.DLL is present.

To service this Windows image requires the latest version of the DISM. See 
http://go.microsoft.com/fwlink/?LinkId=293395 
to find the latest version of DISM, and 
http://go.microsoft.com/fwlink/?LinkId=293394 
to learn how to install the latest version of DISM from the ADK on your computer.

-Sourcepath d:\Work\NanoServer.wim
Edition 1 
-- 'Microsoft-NanoServer-IIS-Package'

https://dscottraynsford.wordpress.com/2015/08/27/docker-and-containers-on-nano-server-continued/

-VHDformat VHD -
-DestVHD

-ComputerName Nano3 -AdministratorPassword 123 -Packages 'Storage','OEM-Drivers', 'Guest', 'Microsoft-NanoServer-IIS-Package'
-ComputerName NANOTEST01 `
			-AdministratorPassword 'P@ssword!1' `
			-Packages 'Storage','OEM-Drivers', 'Guest'
			

New-NanoServerImage -MediaPath f:\ -BasePath .\Base -TargetPath .\Nano1.vhd -GuestDrivers 
	-Packages Microsoft-NanoServer-IIS-Package
If you have an existing VHD file, you can install IIS offline with DISM.exe by navigating to the directory where the Nano Server VHD is, mount the VHD, and use the Add-Package option. The specific commands are:
md mountdir
dism\dism /Mount-Image /ImageFile:.\NanoServer.vhd /Index:1 /MountDir:.\mountdir
dism\dism /Add-Package /PackagePath:.\packages\Microsoft-NanoServer-IIS-Package.cab /Image:.\mountdir
dism\dism /Add-Package /PackagePath:.\packages\en-us\Microsoft-NanoServer-IIS-Package.cab /Image:.\mountdir
dism\dism /Unmount-Image /MountDir:.\MountDir /Commit