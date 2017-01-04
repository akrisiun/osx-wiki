reate a 60GB VHDX, using all default settings, from D:\Windows8RPx64.iso.
PowerShell
.\Convert-WindowsImage.ps1 -SourcePath D:\Windows8RPx64.iso -VHDFormat VHDX -SizeBytes 60GB
Create a 48TB VHDX from D:\WindowsRPx64.iso with a custom file name.
PowerShell
.\Convert-WindowsImage.ps1 -SourcePath D:\Windows8RPx64.iso -VHDFormat VHDX -SizeBytes 48TB -VHDPath .\MyCustomName.vhdx


For detailed information on deploying and managing Nano Server, please go to this link: http://www.aka.ms/nanoserver