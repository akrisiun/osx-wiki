 New-NanoServerImage -MediaPath f:\ -BasePath .\Base -TargetPath .\Nano2.vhd -GuestDrivers -Packages Microsoft-NanoServer-IIS-Package -Storage -Compute -Clustering  -ReverseForwarders -Containers -EnableRemoteManagementPort -ComputerName "Nano2"
	 
New-NanoServerImage -MediaPath f:\ -BasePath .\Base -TargetPath .\Nano1\Nano.vhd -ComputerName Nano1 –GuestDrivers	 

GuestDrivers=HyperV

### Firewall:
Set-Item WSMan:\localhost\Client\TrustedHosts "
	

Set-Item WSMan:\localhost\Client\TrustedHosts "192.168.137.181"

Enter-PSSession -ComputerName 192.168.137.181 -Credential 192.168.137.181\Administrator

$ip = """
	

Custom image size

You can configure the Nano Server image to be a dynamically expanding VHD or VHDX with the -MaxSize extension, as in this example:
New-NanoServerImage -MediaPath \\Path\To\Media\en_us -BasePath .\Base -TargetPath .\BigBoss.vhd -MaxSize 100GB
Embedding custom data

To embed your own script or binaries in the Nano Server image, use the -MergePath extension:
New-NanoServerImage -MediaPath \\Path\To\Media\en_us -BasePath .\Base -TargetPath .\BigBoss.vhd -MergePath .\tools


== ====

un Server Core on a physical computer, using the pre-installed device drivers. If 
OEMDrivers=VirtualBox

 New-NanoServerImage -MediaPath f:\ -BasePath .\Base -TargetPath .\Nano2.vhd -OEMDrivers -Packages Microsoft-NanoServer-IIS-Package -Storage -Compute -Clustering  
 
To convert the WIM image to a VHD
Copy NanoServerImageGenerator.psm1 and Convert-WindowsImage.ps1 from the \NanoServer folder in the Windows Server Technical Preview ISO to your hard drive.
Start an elevated Windows PowerShell console, change directory to the folder where you placed these scripts, and then import the NanoServerImageGenerator script with 
Import-Module NanoServerImageGenerator.psm1 -Verbose.
 
 