Set-StrictMode -version 3
$ErrorActionPreference = "Stop"

$Script:LogFile = Join-Path -Path $env:TEMP -ChildPath "NanoServerImageGenerator.log"
$Script:DismLogFile = Join-Path -Path $env:TEMP -ChildPath "NanoServerImageGenerator (DISM).log"

### -----------------------------------
### Constants
### -----------------------------------

$IMAGE_NAME = "NanoServer.wim"
$IMAGE_CONVERTER = "Convert-WindowsImage.ps1"

$KERNEL_DEBUG_KEY_FILE = "KernelDebugKey.txt"

$LEVEL_WARNING = "WARNING"
$LEVEL_VERBOSE = "VERBOSE"
$LEVEL_OUTPUT = "OUTPUT"
$LEVEL_NONE = "NONE"

$PACK_STORAGE = "Microsoft-NanoServer-Storage-Package"
$PACK_COMPUTE = "Microsoft-NanoServer-Compute-Package"
$PACK_DEFENDER = "Microsoft-NanoServer-Defender-Package"
$PACK_CLUSTERING = "Microsoft-NanoServer-FailoverCluster-Package"
$PACK_OEM_DRIVERS = "Microsoft-NanoServer-OEM-Drivers-Package"
$PACK_GUEST_DRIVERS = "Microsoft-NanoServer-Guest-Package"
$PACK_REVERSE_FORWARDERS = "Microsoft-OneCore-ReverseForwarders-Package"
$PACK_CONTAINERS = "Microsoft-NanoServer-Containers-Package"

### -----------------------------------
### Strings
### -----------------------------------

Data Strings
{
# culture="en-US"
ConvertFrom-StringData @'
    # "Administrator" refers to the Windows user account.
    ERR_USER_MUST_BE_ADMINISTRATOR = This script must be run as Administrator.
    
    # The strings after the dashes are not translatable.
    ERR_INCLUDE_DOMAIN_NAME_OR_DOMAIN_BLOB_PATH = Include either -DomainName or -DomainBlobPath, not both.
    ERR_INCLUDE_COMPUTER_NAME_OR_DOMAIN_BLOB_PATH = Include either -ComputerName or -DomainBlobPath, not both.
    ERR_DOMAIN_NAME_NO_COMPUTER_NAME = -DomainName was included, but not -ComputerName.
    ERR_EMS_PORT_WITH_NO_EMS = -EMSPort was included, but not -EnableEMS.
    ERR_DEBUG_AND_EMS_PORTS_EQUAL = Both the kernel debugging port and the EMS port cannot be the same.
    ERR_REUSE_NODE_WITHOUT_JOIN = -ReuseDomainJoin was specified without -DomainName nor -DomainBlobPath.
    ERR_INCLUDE_OEM_OR_GUEST_DRIVERS = Include either -OEMDrivers or -GuestDrivers, not both (if you included -ForAzure, then that, in turn, included -GuestDrivers).

    # {0} is a number.
    ERR_EXTERNAL_CMD = Failed with {0}.

    # For the next block of messages, the strings between single quotes are not translatable.
    ERR_DIRECTORY_DOES_NOT_EXIST_IN_MEDIA_DIRECTORY = The '{0}' directory does not exist in the specified media path.
    # {2} is a path.
    ERR_DIRECTORY_DOES_NOT_EXIST_IN_DIRECTORY = The '{0}' directory does not exist in the '{1}' directory ('{2}').
    ERR_BASE_DIRECTORY_DOES_NOT_EXIST = The specified base directory does not exist.
    ERR_DIRECTORY_DOES_NOT_EXIST_IN_BASE_DIRECTORY = The '{0}' directory does not exist in the specified base directory.
    ERR_IMAGE_DOES_NOT_EXIST = The '{0}' image does not exist in the 'NanoServer' directory.
    ERR_IMAGE_DOES_NOT_EXIST_IN_BASE_DIRECTORY = The '{0}' image does not exist in the specified base directory.
    ERR_IMAGE_CONVERTER_SCRIPT_DOES_NOT_EXIST = The image converter script does not exist in the directory where this script is located.
    ERR_PACKAGE_DOES_NOT_EXIST = Package '{0}' does not exist.
    ERR_LANGUAGE_PACKAGE_DOES_NOT_EXIST = Language package '{0}' does not exist.
    ERR_ONE_OR_MORE_PACKAGES_DO_NOT_EXIST = One or more packages do not exist.
    ERR_DOMAIN_BLOB_DOES_NOT_EXIST = The specified domain blob does not exist.
    ERR_DRIVERS_DIRECTORY_DOES_NOT_EXIST = The specified drivers directory does not exist ('{0}').
    ERR_SPECIFIED_IMAGE_DOES_NOT_EXIST = The specified VHD(X) image does not exist.
    ERR_INVALID_IMAGE_TYPE_SPECIFIED = The specified image extension is not valid ('{0}').
    ERR_ONLY_ONE_PATH_PERMITTED = MediaPath and BasePath specified, but only one path expected.
    ERR_MERGE_PATH_DOES_NOT_EXIST = MergePath specified but does not exist.
    
    # New-NanoImage cannot be translated.
    LOG_HEADER = {0} Cmdlet Started

    # {0} is a file path.
    MSG_DONE = Done. The log is at: {0}
    # {0} is a file path.
    MSG_TERMINATING_DUE_TO_ERROR = Terminating due to an error. See log file at: {0}

    MSG_COMPUTING_PATHS = Computing paths...
    MSG_CHECKING_PATHS = Checking paths...
    MSG_CREATING_PATHS = Creating paths...

    MSG_COPYING_FILES = Copying files...
    MSG_SKIPPING_FILE_COPY = Skipping file copy.
    
    MSG_CONVERTING_IMAGE = Converting image...
    MSG_SKIPPING_IMAGE_CONVERSION = Skipping image conversion.

    MSG_COPYING_IMAGE = Copying image...
    MSG_MOUNTING_IMAGE = Mounting image...

    MSG_MERGING_DIRECTORY = Merging directory...
    MSG_SKIPPING_DIRECTORY_MERGING = Skipping directory merging.
    
    MSG_ADDING_PACKAGES = Adding packages...
    # {0} is a file name.
    MSG_ADDING_PACKAGE = Adding package '{0}'...
    # {0} is a file name.
    MSG_ADDING_LANGUAGE_PACKAGE = Adding language package for '{0}'...
    MSG_SKIPPING_PACKAGE_ADDITION = Skipping package addition.

    MSG_ADDING_DRIVERS = Adding drivers...
    MSG_SKIPPING_DRIVER_ADDITION = Skipping driver addition.

    # The file name is not translatable.
    MSG_ADDING_UNATTEND = Adding Unattend.xml...
    MSG_COLLECTING_DOMAIN_BLOB = Collecting domain provisioning blob...
    MSG_JOINING_DOMAIN = Joining domain...

    MSG_ENABLING_DEBUG = Enabling Debug and BootDebug...
    # {0} is a file path.
    MSG_KERNEL_DEBUG_KEY_FILE = Find the kernel debugging key at: {0}

    MSG_ENABLING_EMS = Enabling EMS and BootEMS...

    MSG_DISMOUNTING_IMAGE = Dismounting image...

    MSG_TARGET_IMAGE = Target image: '{0}'
'@
}

# Import localized strings
Import-LocalizedData Strings -FileName NanoServerImageGenerator.Strings.psd1 -ErrorAction SilentlyContinue

### -----------------------------------
### Get-NanoServerPackages Cmdlet
### -----------------------------------

<#
    .NOTES
        Copyright (C) Microsoft Corporation.  All rights reserved.

    .SYNOPSIS
        Retrieves the list of available packages from the media.

    .DESCRIPTION
        This cmdlet scans the given media and returns a list of packages available
        to be embedded into the Nano Server image.

    .PARAMETER MediaPath
        The location of the source media. If a local copy of the source media
        already exists, and it is specified as the base path, then no copying
        is performed.

    .PARAMETER BasePath
        The location for the copy of the source media.
        
    .PARAMETER Language
        The language locale of the packages (i.e. en-us, fr-ca).

    .EXAMPLE
        Get-NanoServerPackages -MediaPath D:\

        This example will retrieve list of available packages present on the media.
#>
Function Get-NanoServerPackages
{
    [CmdletBinding()]
    Param
    (
        # Location of the source media.
        [String]$MediaPath,
        # Where to place the copy of the source media.
        [String]$BasePath,
        
        # Language of the packages to include (i.e. en-us, fr-ca, etc.).
        [ValidateNotNullOrEmpty()]
        [String]$Language = [System.Globalization.CultureInfo]::CurrentCulture.Name.ToLower()
    )

    Process
    {
        $Script:NewImage = $True

        # Write out a header to make it easier to find distinct runs.
        Write-Log $LEVEL_NONE "========================================"
        Write-Log $LEVEL_NONE ($Strings.LOG_HEADER -f "Get-NanoServerPackages")
        Write-Log $LEVEL_NONE "========================================"

        # Tracking (used to handle Ctrl-C gracefully)
        $HasWorkFinished = $False

        # Phase 0
        try
        {
            if ($MediaPath -and $BasePath)
            {
                Throw $Strings.ERR_ONLY_ONE_PATH_PERMITTED
            }
            
            Initialize-PathValues `
                -BasePath $BasePath `
                -Language $Language `
                -MediaPath $MediaPath
            Test-Paths

            $Dirs = @()
            if ($Script:HasMediaPath)
            {
                $Dirs += $Script:PackagesPath
                $Dirs += $Script:LanguagePackagesPath
            }
            else
            {
                $Dirs += $Script:BasePackagesPath
                $Dirs += $Script:BaseLanguagePackagesPath
            }
            
            $Packages = $Dirs | ForEach-Object {
                (Get-ChildItem -Path $_ -Filter "*.cab").BaseName
            } | Sort-Object | Get-Unique
            
            Write-Log $LEVEL_OUTPUT ($Strings.MSG_DONE -f $LogFile) $True

            $HasWorkFinished = $True
            
            return $Packages
        }
        catch
        {
            Write-Log $LEVEL_WARNING ("{0}`n{1}" -f $_, $_.ScriptStackTrace) -NoOutput
            Write-Log $LEVEL_WARNING ($Strings.MSG_TERMINATING_DUE_TO_ERROR -f $Script:LogFile) $True
            
            Throw
        }
    }
}

### -----------------------------------
### New-NanoServerImage Cmdlet
### -----------------------------------

<#
    .NOTES
        Copyright (C) Microsoft Corporation.  All rights reserved.

    .SYNOPSIS
        Creates a base Nano Server installation image.

    .DESCRIPTION
        This cmdlet makes a local copy of the necessary files from the
        installation media and converts the included WIM Nano Server image into
        a VHD(X) image. It then makes a copy of the converted VHD(X) image into a
        user-supplied path. After that, the following operations can be applied:
        - Add packages
        - Add drivers 
        - Set computer name
        - Set administrator password
        - Join a domain
        - Enable debug
        - Enable EMS
        - Set static IP address

    .PARAMETER MediaPath
        The location of the source media. If a local copy of the source media
        already exists, and it is specified as the base path, then no copying
        is performed.

    .PARAMETER BasePath
        The location for the copy of the source media.

    .PARAMETER TargetPath
        The location of the final, modified image. The image format
        is determined based on the file extension. Possible extension values
        are .vhd and .vhdx. 
        
    .PARAMETER Language
        The language locale of the packages (i.e. en-us, fr-ca).

    .PARAMETER MaxSize
        Size in bytes of the dynamic image to be created. Default is 4 GB.
        
    .PARAMETER Storage
        Add the Storage package.

    .PARAMETER Compute
        Add the Compute (Hyper-V) package.

    .PARAMETER Defender
        Add the Windows Defender package.

    .PARAMETER Clustering
        Add the Clustering package.

    .PARAMETER OEMDrivers
        Add the OEM Drivers package.

    .PARAMETER GuestDrivers
        Add the Guest Drivers package (enables integration of Nano Server
        with Hyper-V when running as a guest).

    .PARAMETER ReverseForwarders
        Add the Reverse Forwarders package.
        
    .PARAMETER Containers
        Add the Containers package.

    .PARAMETER ForAzure
        Automatically include the options necessary to run Nano Server on
        Azure.

    .PARAMETER ComputerName
        Sets the computer name of the image.
    
    .PARAMETER AdministratorPassword
        Sets the administrator password of the image. If you do not specify on 
        command line, you will be prompted interactively.

    .PARAMETER DomainName
        Joins the image to the specified domain performing an offline join. A
        domain blob is harvested from the local computer; if the local computer
        is not a member of the given domain, the command will fail.

    .PARAMETER DomainBlobPath
        Joins the image to the domain as specified in the given domain blob.

    .PARAMETER ReuseDomainNode
        When joining a domain, reuse a node with the same name if it exists.

    .PARAMETER DriversPath
        Path containing the drivers (.inf and binaries) to add to the image.
        If the drivers are not signed, the command will fail.
        
    .PARAMETER InterfaceNameOrIndex
        Interface name or index to modify. You can retrieve these using 
        Get-NetAdapter, netsh or EMC.
        
    .PARAMETER Ipv6Address
        Sets the given IPv6 static address on the interface specified by InterfaceNameOrIndex.
        
    .PARAMETER Ipv4Address
        Sets the given IPv4 static address on the interface specified by InterfaceNameOrIndex.
        
    .PARAMETER Ipv4SubnetMask
        Sets the given IPv4 subnet mask on the interface specified by InterfaceNameOrIndex.
    
    .PARAMETER Ipv4Gateway
        Sets the given IPv4 gateway on the interface specified by InterfaceNameOrIndex.

    .PARAMETER DebugMethod
        Enables kernel debugging on the target image with the specified method.
        Possible values are:
        1. Serial
        2. Net (KDNET)
        3. 1394 (FireWire)
        4. USB

        Depending on the value of this parameter, other parameters become
        available.
     
    .PARAMETER DebugCOMPort
        Specifies the serial port that kernel debugging is enabled on (only if
        DebugMethod is Serial). Default is 2.

    .PARAMETER DebugBaudRate
        The baud rate to use for kernel debugging. Default is 115200bps.

    .PARAMETER DebugRemoteIP
        Specifies the IP address of the computer running the debugger (only if
        DebugMethod is Net).

    .PARAMETER DebugPort
        Specifies the port that the computer running the debugger can use to
        connect to the host (only if DebugMethod is Net).

    .PARAMETER DebugChannel
        Specifies the channel that the computer running the debugger can use to
        connect to the host (only if DebugMethod is 1394).

    .PARAMETER DebugTargetName
        Specifies the target name that the computer running the debugger can
        use to connect to the host (only if DebugMethod is USB).

    .PARAMETER EnableEMS
        Enables EMS (Emergency Management Services) and BootEMS on the image.

    .PARAMETER EMSPort
        The port to enable EMS on. Default is 1.

    .PARAMETER EMSBaudRate
        The baud rate to use for EMS. Default is 115200bps.

    .PARAMETER EnableRemoteManagementPort
        Open port 5985 for inbound TCP connections for WinRM.
        
    .PARAMETER MergePath
        Specifies additional directory path to be added to the root of the VHD(X).

    .EXAMPLE
        New-NanoServerImage -MediaPath D:\ -BasePath .\Base -TargetPath '.\Target 1\NanoServer.vhd' -GuestDrivers

        This example will copy the necessary files from D:\ into .\Base. It
        will convert the Nano Server WIM image into a VHD file .\Base\Base.vhd.
        It will then copy that image into .\Target 1\Target 1.vhd and embed Guest Drivers into it.
#>
Function New-NanoServerImage
{
    [CmdletBinding()]
    Param
    (
        # Location of the source media.
        [Parameter()]
        [String]$MediaPath,
        # Where to place the copy of the source media.
        [Parameter()]
        [String]$BasePath,
        # Path to the produced image.
        [Parameter(Mandatory = $True)]
        [ValidatePattern('\.vhdx?$')]
        [String]$TargetPath,
        
        # Language of the packages to include (i.e. en-us, fr-ca, etc.).
        [ValidateNotNullOrEmpty()]
        [String]$Language = [System.Globalization.CultureInfo]::CurrentCulture.Name.ToLower(),
        
        # Output image maximum size.
        [ValidateRange(512MB, 64TB)]
        [UInt64]$MaxSize = 4GB,
        
        # Include the Storage package.
        [Switch]$Storage,
        # Include the Compute (Hyper-V) package.
        [Switch]$Compute,
        # Include the Windows Defender package.
        [Switch]$Defender,
        # Include the Failover Clustering package.
        [Switch]$Clustering,
        # Include the OEM Drivers package.
        [Switch]$OEMDrivers,
        # Include the Guest Drivers package.
        [Switch]$GuestDrivers,
        # Include the Reverse Forwarders package.
        [Switch]$ReverseForwarders,
        # Include the Containers package.
        [Switch]$Containers,

        # Include the following packages.
        [String[]]$Packages,

        # Automatically include the necessary features to run Nano Server on
        # Azure.
        [Switch]$ForAzure,

        # Name to give to the target computer.
        [ValidateLength(1, 15)]
        [String]$ComputerName,
        # Password for the administrator account of the target computer.
        [Parameter(Mandatory = $True)]
        [SecureString]$AdministratorPassword,

        # Name of the domain.
        [ValidateNotNullOrEmpty()]
        [String]$DomainName,
        # Location of the domain blob.
        [ValidateNotNullOrEmpty()]
        [String]$DomainBlobPath,
        # Force reusing a node when joining a domain.
        [Switch]$ReuseDomainNode,

        # Location of additional drivers to include.
        [ValidateNotNullOrEmpty()]
        [String]$DriversPath,
        
        # Configure this interface statically.
        [String]$InterfaceNameOrIndex,
        
        # Set statically IPv6 address.
        [ValidateNotNullOrEmpty()]
        [String]$Ipv6Address,
        
        # Set statically IPv4 address.
        [ValidatePattern('^((25[0-5]|2[0-4]\d|1?\d?\d)\.){3}(25[0-5]|2[0-4]\d|1?\d?\d)$')]
        [String]$Ipv4Address,
        
        # Set statically IPv4 subnet mask.
        [ValidatePattern('^((25[0-5]|2[0-4]\d|1?\d?\d)\.){3}(25[0-5]|2[0-4]\d|1?\d?\d)$')]
        [String]$Ipv4SubnetMask,
        
        # Set statically IPv4 gateway.
        [ValidatePattern('^((25[0-5]|2[0-4]\d|1?\d?\d)\.){3}(25[0-5]|2[0-4]\d|1?\d?\d)$')]
        [String]$Ipv4Gateway,

        # Enable Debug and BootDebug in the target BCD.
        [ValidateSet("Serial", "Net", "1394", "USB")]
        [String]$DebugMethod,

        # Enable EMD and BootEMS in the target BCD.
        [Switch]$EnableEMS,
        # Port to use for EMS.
        [Parameter()]
        [Byte]$EMSPort = 1,
        # Baud rate to use for EMS.
        [Parameter()]
        [UInt32]$EMSBaudRate = 115200,

        # Open port 5985 for inbound TCP connections for WinRM from any location,
        # not just the domain network and the local subnet.
        [Switch]$EnableRemoteManagementPort,
        
        # Will be merged into the root of the image.
        [String]$MergePath
    )
    
    DynamicParam {
        $DynamicParameters = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameterDictionary
        
        if (-not (Test-Path Variable:\DebugMethod))
        {
            $DebugMethod = $null
        }
        
        switch ($DebugMethod)
        {
            "Serial" {
                # Debug Port
                $DebugCOMPort = New-DynamicParameter "DebugCOMPort" Byte 2
                $DynamicParameters.Add($DebugCOMPort.Name, $DebugCOMPort)

                # Debug Baud Rate
                $DebugBaudRate = New-DynamicParameter "DebugBaudRate" UInt32 115200
                $DynamicParameters.Add($DebugBaudRate.Name, $DebugBaudRate)
            }

            "Net" {
                # Remote IP
                $DebugRemoteIP = New-DynamicParameter "DebugRemoteIP" String -Mandatory -NotNull
                $DynamicParameters.Add($DebugRemoteIP.Name, $DebugRemoteIP)

                # Remote Port
                $DebugPort = New-DynamicParameter "DebugPort" UInt16 -Mandatory
                $DynamicParameters.Add($DebugPort.Name, $DebugPort)

                # Key
                $DebugKey = New-DynamicParameter "DebugKey" String -NotNull
                $DynamicParameters.Add($DebugKey.Name, $DebugKey)
            }

            "1394" {
                # Channel
                $DebugChannel = New-DynamicParameter "DebugChannel" UInt16 -Mandatory
                $DynamicParameters.Add($DebugChannel.Name, $DebugChannel)
            }

            "USB" {
                # Target Name
                $DebugTargetName = New-DynamicParameter "DebugTargetName" String -Mandatory -NotNull
                $DynamicParameters.Add($DebugTargetName.Name, $DebugTargetName)
            }
        }

        return $DynamicParameters
    }

    Process
    {
        $Script:NewImage = $True
    
        # The ForAzure switch turns on switches whose validity must then be
        # checked against the other parameters that may have also been
        # specified. So, we must set these at the very beginning.
        if ($ForAzure)
        {
            $GuestDrivers = $True
            $EnableRemoteManagementPort = $True
        }

        # Checks
        Verify-UserIsAdministrator
        
        if ($DomainName -and $DomainBlobPath)
        {
            Throw $Strings.ERR_INCLUDE_DOMAIN_NAME_OR_DOMAIN_BLOB_PATH
        }
        if ($DomainBlobPath -and $ComputerName)
        {
            Throw $Strings.ERR_INCLUDE_COMPUTER_NAME_OR_DOMAIN_BLOB_PATH
        }
        if ($DomainName -and !$ComputerName)
        {
            Throw $Strings.ERR_DOMAIN_NAME_NO_COMPUTER_NAME
        }
        if (!$EnableEMS -and $PSBoundParameters.ContainsKey("EMSPort"))
        {
            Throw $Strings.ERR_EMS_PORT_WITH_NO_EMS
        }
        if ($OEMDrivers -and $GuestDrivers)
        {
            Throw $Strings.ERR_INCLUDE_OEM_OR_GUEST_DRIVERS
        }
        if (($DebugMethod -eq "Serial") -and $EnableEMS -and ($DebugCOMPort.Value -eq $EMSPort))
        {
            Throw $Strings.ERR_DEBUG_AND_EMS_PORTS_EQUAL
        }
        if ($ReuseDomainNode -and (!$DomainName -and !$DomainBlobPath))
        {
            Throw $Strings.ERR_REUSE_NODE_WITHOUT_JOIN
        }
        
        # Write out a header to make it easier to find distinct runs.
        Write-Log $LEVEL_NONE "========================================"
        Write-Log $LEVEL_NONE ($Strings.LOG_HEADER -f "New-NanoServerImage")
        Write-Log $LEVEL_NONE "========================================"

        # Tracking (used to handle Ctrl-C gracefully)
        $HasWorkFinished = $False
        $HasMountedImage = $False
        $HasMountedVhd = $False
        $SystemPartitionGuid = $Null

        # Phase 0
        if ($Storage) { $Packages += $PACK_STORAGE }
        if ($Compute) { $Packages += $PACK_COMPUTE }
        if ($Defender) { $Packages += $PACK_DEFENDER }
        if ($Clustering) { $Packages += $PACK_CLUSTERING }
        if ($OEMDrivers) { $Packages += $PACK_OEM_DRIVERS }
        if ($GuestDrivers) { $Packages += $PACK_GUEST_DRIVERS }
        if ($ReverseForwarders) { $Packages += $PACK_REVERSE_FORWARDERS }
        if ($Containers) { $Packages += $PACK_CONTAINERS }
        
        try
        {
            Initialize-PathValues `
                $BasePath `
                $TargetPath `
                $Language `
                $DriversPath `
                $DomainBlobPath `
                $Packages `
                -MediaPath $MediaPath `
                -MaxSize $MaxSize `
                -MergePath $MergePath
            Initialize-Paths
            Test-Paths $Packages

            # Phase 1
            Copy-Files
            
            Convert-Image
            Copy-Image
            
            # Phase 2
            Mount-Image
            $HasMountedImage = $True
            
            Add-Directory
            Add-Packages $Packages
            Add-Drivers

            # Phase 3
            Add-ServicingDescriptor $ComputerName $AdministratorPassword
            Join-Domain $DomainName $ReuseDomainNode

            # Phase 4
            if ($EnableRemoteManagementPort -or $Ipv4Address -or $Ipv6Address)
            {
                Write-SetupComplete `
                    $EnableRemoteManagementPort `
                    $InterfaceNameOrIndex `
                    $Ipv6Address `
                    $Ipv4Address `
                    $Ipv4SubnetMask `
                    $Ipv4Gateway
            }
            
            if ($DebugMethod -or $EnableEMS)
            {
                if ($Script:ImageFormat -eq "vhdx")
                {
                    Dismount-Image
                    $HasMountedImage = $False
                    
                    $SystemPartitionGuid = Mount-AsBasicData
                    $HasMountedVhd = $True
                    $BCDPath = "$Script:TargetMountPath\efi\microsoft\boot\bcd"
                }
                else
                {
                    $BCDPath = "$Script:TargetMountPath\boot\bcd"
                }
                
                if ($DebugMethod)
                {
                    Enable-Debug $BCDPath

                    switch ($DebugMethod)
                    {
                        "Serial" { Enable-DebugSerial $BCDPath $DebugCOMPort.Value $DebugBaudRate.Value }
                        "Net" { Enable-DebugNet $BCDPath $DebugRemoteIP.Value $DebugPort.Value $DebugKey.Value }
                        "1394" { Enable-DebugFirewire $BCDPath $DebugChannel.Value }
                        "USB" { Enable-DebugUSB $BCDPath $DebugTargetName.Value }
                    }
                }
                if ($EnableEMS)
                {
                    Enable-EMS $BCDPath $EMSPort $EMSBaudRate
                }
                
                if ($Script:ImageFormat -eq "vhdx")
                {
                    Dismount-AsSystemPartition $SystemPartitionGuid
                }
            }

            Write-Log $LEVEL_OUTPUT ($Strings.MSG_DONE -f $LogFile) $True

            $HasWorkFinished = $True
        }
        catch
        {
            Write-Log $LEVEL_WARNING ("{0}`n{1}" -f $_, $_.ScriptStackTrace) -NoOutput
            Write-Log $LEVEL_WARNING ($Strings.MSG_TERMINATING_DUE_TO_ERROR -f $Script:LogFile) $True
            
            Throw
        }
        finally
        {
            if ($HasMountedImage)
            {
                Dismount-Image
                $HasMountedImage = $False
            }
            
            if ($HasMountedVhd)
            {
                Dismount-VHD -Path $Script:TargetImageFilePath
                $HasMountedVhd = $False
            }
        
            if ($HasWorkFinished)
            {
                # All good.
                Remove-Item -Recurse -Path $Script:TargetTempPath
            }
        }
    }
}

### -----------------------------------
### Edit-NanoServerImage Cmdlet
### -----------------------------------

<#
    .NOTES
        Copyright (C) Microsoft Corporation.  All rights reserved.

    .SYNOPSIS
        Modifies a base Nano Server installation image adding packages, drivers
        and configuring operating system options.

    .DESCRIPTION
        This cmdlet expects that you ran New-NanoServerImage in advance. 
        It operates on the image produced by New-NanoServerImage as requested.

        Possible operations are: Add packages, add drivers, set computer name,
        set administrator password, join a domain, enable debug, enable EMS and
        set static IP address.

    .PARAMETER BasePath
        The location for the copy of the source media.

    .PARAMETER TargetPath
        The location of the final, modified image.

    .PARAMETER Language
        The language locale of the packages (i.e. en-us, fr-ca).

    .PARAMETER Storage
        Add the Storage package.

    .PARAMETER Compute
        Add the Compute (Hyper-V) package.

    .PARAMETER Defender
        Add the Windows Defender package.

    .PARAMETER Clustering
        Add the Clustering package.

    .PARAMETER OEMDrivers
        Add the OEM Drivers package.

    .PARAMETER GuestDrivers
        Add the Guest Drivers package (enables integration of Nano Server
        with Hyper-V when running as a guest).

    .PARAMETER ReverseForwarders
        Add the Reverse Forwarders package.
        
    .PARAMETER Containers
        Add the Containers package.

    .PARAMETER ForAzure
        Automatically include the options necessary to run Nano Server on
        Azure.

    .PARAMETER ComputerName
        Sets the computer name of the image.
    
    .PARAMETER AdministratorPassword
        Sets the administrator password of the image. If you do not specify on 
        command line, you will be prompted interactively.

    .PARAMETER DomainName
        Joins the image to the specified domain performing an offline join. A
        domain blob is harvested from the local computer; if the local computer
        is not a member of the given domain, the command will fail.

    .PARAMETER DomainBlobPath
        Joins the image to the domain as specified in the given domain blob.

    .PARAMETER ReuseDomainNode
        When joining a domain, reuse a node with the same name if it exists.

    .PARAMETER DriversPath
        Path containing the drivers (.inf and binaries) to add to the image.
        If the drivers are not signed, the command will fail.
        
    .PARAMETER InterfaceNameOrIndex
        Interface name or index to modify. You can retrieve these using 
        Get-NetAdapter, netsh or EMC.
        
    .PARAMETER Ipv6Address
        Sets the given IPv6 static address on the interface specified by InterfaceNameOrIndex.
        
    .PARAMETER Ipv4Address
        Sets the given IPv4 static address on the interface specified by InterfaceNameOrIndex.
        
    .PARAMETER Ipv4SubnetMask
        Sets the given IPv4 subnet mask on the interface specified by InterfaceNameOrIndex.
    
    .PARAMETER Ipv4Gateway
        Sets the given IPv4 gateway on the interface specified by InterfaceNameOrIndex.

    .PARAMETER DebugMethod
        Enables kernel debugging on the target image with the specified method.
        Possible values are:
        1. Serial
        2. Net (KDNET)
        3. 1394 (FireWire)
        4. USB

        Depending on the value of this parameter, other parameters become
        available.
     
    .PARAMETER DebugCOMPort
        Specifies the serial port that kernel debugging is enabled on (only if
        DebugMethod is Serial). Default is 2.

    .PARAMETER DebugBaudRate
        The baud rate to use for kernel debugging. Default is 115200bps.

    .PARAMETER DebugRemoteIP
        Specifies the IP address of the computer running the debugger (only if
        DebugMethod is Net).

    .PARAMETER DebugPort
        Specifies the port that the computer running the debugger can use to
        connect to the host (only if DebugMethod is Net).

    .PARAMETER DebugChannel
        Specifies the channel that the computer running the debugger can use to
        connect to the host (only if DebugMethod is 1394).

    .PARAMETER DebugTargetName
        Specifies the target name that the computer running the debugger can
        use to connect to the host (only if DebugMethod is USB).

    .PARAMETER EnableEMS
        Enables EMS (Emergency Management Services) and BootEMS on the image.

    .PARAMETER EMSPort
        The port to enable EMS on. Default is 1.

    .PARAMETER EMSBaudRate
        The baud rate to use for EMS. Default is 115200bps.

    .PARAMETER EnableRemoteManagementPort
        Open port 5985 for inbound TCP connections for WinRM.
        
    .PARAMETER MergePath
        Specifies additional directory path to be added to the root of the VHD(X).
        
    .PARAMETER LangPackages
        Reserved, do not use.
    
    .PARAMETER NeutralPackages
        Reserved, do not use.

    .EXAMPLE
        Edit-NanoServerImage -BasePath .\Base -TargetPath '.\Target 1\NanoServer.vhdx' -Compute -ComputerName "NANO" -DomainName "ContosoDomain" -AdministratorPassword (ConvertTo-SecureString -String 'Passw0rd' -AsPlainText -Force)

        This example will copy the necessary files from D:\ into .\Base. It
        will convert the Nano Server WIM image into a VHD file .\Base\Base.vhd.
        It will operate on .\Target 1\NanoServer.vhdx and will use packages
        which has been cached from media to .\Base. You need to run 
        New-NanoServerImage with the same -BasePath before. In this example,
        the following will happen:

        1. Add the Compute (Hyper-V) package;
        2. Set the computer name to 'NANO';
        3. Set the administrator password to 'Passw0rd';
        4. Perform an offline domain join of the machine to 'ContosoDomain';
#>
Function Edit-NanoServerImage
{
    [CmdletBinding()]
    Param
    (
        # Where to place the copy of the source media.
        [String]$BasePath,
        # Location of the image to use.
        [Parameter(Mandatory = $True)]
        [ValidatePattern('\.vhdx?$')]
        [String]$TargetPath,

        # Language of the packages to include (i.e. en-us, fr-ca, etc.).
        [ValidateNotNullOrEmpty()]
        [String]$Language = [System.Globalization.CultureInfo]::CurrentCulture.Name.ToLower(),

        # Include the Storage package.
        [Switch]$Storage,
        # Include the Compute (Hyper-V) package.
        [Switch]$Compute,
        # Include the Windows Defender package.
        [Switch]$Defender,
        # Include the Failover Clustering package.
        [Switch]$Clustering,
        # Include the OEM Drivers package.
        [Switch]$OEMDrivers,
        # Include the Guest Drivers package.
        [Switch]$GuestDrivers,
        # Include the Reverse Forwarders package.
        [Switch]$ReverseForwarders,
        # Include the Containers package.
        [Switch]$Containers,

        # Include the following packages.
        [String[]]$Packages,

        # Automatically include the necessary features to run Nano Server on
        # Azure.
        [Switch]$ForAzure,

        # Name to give to the target computer.
        [ValidateLength(1, 15)]
        [String]$ComputerName,
        # Password for the administrator account of the target computer.
        [SecureString]$AdministratorPassword,

        # Name of the domain.
        [ValidateNotNullOrEmpty()]
        [String]$DomainName,
        # Location of the domain blob.
        [ValidateNotNullOrEmpty()]
        [String]$DomainBlobPath,
        # Force reusing a node when joining a domain.
        [Switch]$ReuseDomainNode,

        # Location of additional drivers to include.
        [ValidateNotNullOrEmpty()]
        [String]$DriversPath,
        
        # Configure this interface statically.
        [String]$InterfaceNameOrIndex,
        
        # Set statically IPv6 address.
        [ValidateNotNullOrEmpty()]
        [String]$Ipv6Address,
        
        # Set statically IPv4 address.
        [ValidatePattern('^((25[0-5]|2[0-4]\d|1?\d?\d)\.){3}(25[0-5]|2[0-4]\d|1?\d?\d)$')]
        [String]$Ipv4Address,
        
        # Set statically IPv4 subnet mask.
        [ValidatePattern('^((25[0-5]|2[0-4]\d|1?\d?\d)\.){3}(25[0-5]|2[0-4]\d|1?\d?\d)$')]
        [String]$Ipv4SubnetMask,
        
        # Set statically IPv4 gateway.
        [ValidatePattern('^((25[0-5]|2[0-4]\d|1?\d?\d)\.){3}(25[0-5]|2[0-4]\d|1?\d?\d)$')]
        [String]$Ipv4Gateway,

        # Enable Debug and BootDebug in the target BCD.
        [ValidateSet("Serial", "Net", "1394", "USB")]
        [String]$DebugMethod,

        # Enable EMD and BootEMS in the target BCD.
        [Switch]$EnableEMS,
        # Port to use for EMS.
        [Parameter()]
        [Byte]$EMSPort = 1,
        # Baud rate to use for EMS.
        [Parameter()]
        [UInt32]$EMSBaudRate = 115200,

        # Open port 5985 for inbound TCP connections for WinRM.
        [Switch]$EnableRemoteManagementPort,
        
        # Will be merged into the root of the image.
        [String]$MergePath,

        # Override location of language packages.
        [String]$LangPackages,

        # Override location of neutral packages.
        [String]$NeutralPackages
    )

    DynamicParam {
        $DynamicParameters = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameterDictionary
        
        if (-not (Test-Path Variable:\DebugMethod))
        {
            $DebugMethod = $null
        }

        switch ($DebugMethod)
        {
            "Serial" {
                # Debug Port
                $DebugCOMPort = New-DynamicParameter "DebugCOMPort" Byte 2
                $DynamicParameters.Add($DebugCOMPort.Name, $DebugCOMPort)

                # Debug Baud Rate
                $DebugBaudRate = New-DynamicParameter "DebugBaudRate" UInt32 115200
                $DynamicParameters.Add($DebugBaudRate.Name, $DebugBaudRate)
            }

            "Net" {
                # Remote IP
                $DebugRemoteIP = New-DynamicParameter "DebugRemoteIP" String -Mandatory -NotNull
                $DynamicParameters.Add($DebugRemoteIP.Name, $DebugRemoteIP)

                # Remote Port
                $DebugPort = New-DynamicParameter "DebugPort" UInt16 -Mandatory
                $DynamicParameters.Add($DebugPort.Name, $DebugPort)

                # Key
                $DebugKey = New-DynamicParameter "DebugKey" String -NotNull
                $DynamicParameters.Add($DebugKey.Name, $DebugKey)
            }

            "1394" {
                # Channel
                $DebugChannel = New-DynamicParameter "DebugChannel" UInt16 -Mandatory
                $DynamicParameters.Add($DebugChannel.Name, $DebugChannel)
            }

            "USB" {
                # Target Name
                $DebugTargetName = New-DynamicParameter "DebugTargetName" String -Mandatory -NotNull
                $DynamicParameters.Add($DebugTargetName.Name, $DebugTargetName)
            }
        }

        return $DynamicParameters
    }

    Process
    {
        $Script:NewImage = $False

        # The ForAzure switch turns on switches whose validity must then be
        # checked against the other parameters that may have also been
        # specified. So, we must set these at the very beginning.
        if ($ForAzure)
        {
            $GuestDrivers = $True
            $EnableRemoteManagementPort = $True
        }

        # Checks
        Verify-UserIsAdministrator
        
        if ($DomainName -and $DomainBlobPath)
        {
            Throw $Strings.ERR_INCLUDE_DOMAIN_NAME_OR_DOMAIN_BLOB_PATH
        }
        if ($DomainBlobPath -and $ComputerName)
        {
            Throw $Strings.ERR_INCLUDE_COMPUTER_NAME_OR_DOMAIN_BLOB_PATH
        }
        if ($DomainName -and !$ComputerName)
        {
            Throw $Strings.ERR_DOMAIN_NAME_NO_COMPUTER_NAME
        }
        if (!$EnableEMS -and $PSBoundParameters.ContainsKey("EMSPort"))
        {
            Throw $Strings.ERR_EMS_PORT_WITH_NO_EMS
        }
        if ($OEMDrivers -and $GuestDrivers)
        {
            Throw $Strings.ERR_INCLUDE_OEM_OR_GUEST_DRIVERS
        }
        if (($DebugMethod -eq "Serial") -and $EnableEMS -and ($DebugCOMPort.Value -eq $EMSPort))
        {
            Throw $Strings.ERR_DEBUG_AND_EMS_PORTS_EQUAL
        }
        if ($ReuseDomainNode -and (!$DomainName -and !$DomainBlobPath))
        {
            Throw $Strings.ERR_REUSE_NODE_WITHOUT_JOIN
        }
        
        # Write out a header to make it easier to find distinct runs.
        Write-Log $LEVEL_NONE "========================================"
        Write-Log $LEVEL_NONE ($Strings.LOG_HEADER -f "Edit-NanoServerImage")
        Write-Log $LEVEL_NONE "========================================"

        # Tracking (used to handle Ctrl-C gracefully)
        $HasWorkFinished = $False
        $HasMountedImage = $False
        $HasMountedVhd = $False
        $SystemPartitionGuid = $null

        # Phase 0
        if ($Storage) { $Packages += $PACK_STORAGE }
        if ($Compute) { $Packages += $PACK_COMPUTE }
        if ($Defender) { $Packages += $PACK_DEFENDER }
        if ($Clustering) { $Packages += $PACK_CLUSTERING }
        if ($OEMDrivers) { $Packages += $PACK_OEM_DRIVERS }
        if ($GuestDrivers) { $Packages += $PACK_GUEST_DRIVERS }
        if ($ReverseForwarders) { $Packages += $PACK_REVERSE_FORWARDERS }
        if ($Containers) { $Packages += $PACK_CONTAINERS }
        
        try
        {
            Initialize-PathValues `
                $BasePath `
                $TargetPath `
                $Language `
                $DriversPath `
                $DomainBlobPath `
                $Packages `
                $LangPackages `
                $NeutralPackages `
                -MergePath $MergePath

            Initialize-Paths
            Test-Paths $Packages

            # Phase 2
            Mount-Image
            $HasMountedImage = $True

            Add-Directory
            Add-Packages $Packages
            Add-Drivers

            # Phase 3
            Add-ServicingDescriptor $ComputerName $AdministratorPassword
            Join-Domain $DomainName $ReuseDomainNode

            # Phase 4
            if ($EnableRemoteManagementPort -or $Ipv4Address -or $Ipv6Address)
            {
                Write-SetupComplete `
                    $EnableRemoteManagementPort `
                    $InterfaceNameOrIndex `
                    $Ipv6Address `
                    $Ipv4Address `
                    $Ipv4SubnetMask `
                    $Ipv4Gateway
            }
            
            if ($DebugMethod -or $EnableEMS)
            {
                if ($Script:ImageFormat -eq "vhdx")
                {
                    Dismount-Image
                    $HasMountedImage = $False
                    
                    $SystemPartitionGuid = Mount-AsBasicData
                    $HasMountedVhd = $True
                    $BCDPath = "$Script:TargetMountPath\efi\microsoft\boot\bcd"
                }
                else
                {
                    $BCDPath = "$Script:TargetMountPath\boot\bcd"
                }
                
                if ($DebugMethod)
                {
                    Enable-Debug $BCDPath

                    switch ($DebugMethod)
                    {
                        "Serial" { Enable-DebugSerial $BCDPath $DebugCOMPort.Value $DebugBaudRate.Value }
                        "Net" { Enable-DebugNet $BCDPath $DebugRemoteIP.Value $DebugPort.Value $DebugKey.Value }
                        "1394" { Enable-DebugFirewire $BCDPath $DebugChannel.Value }
                        "USB" { Enable-DebugUSB $BCDPath $DebugTargetName.Value }
                    }
                }
                if ($EnableEMS)
                {
                    Enable-EMS $BCDPath $EMSPort $EMSBaudRate
                }
                
                if ($Script:ImageFormat -eq "vhdx")
                {
                    Dismount-AsSystemPartition $SystemPartitionGuid
                }
            }
            
            Write-Log $LEVEL_OUTPUT ($Strings.MSG_DONE -f $LogFile) $True

            $HasWorkFinished = $True
        }
        catch
        {
            Write-Log $LEVEL_WARNING ("{0}`n{1}" -f $_, $_.ScriptStackTrace) -NoOutput
            Write-Log $LEVEL_WARNING ($Strings.MSG_TERMINATING_DUE_TO_ERROR -f $Script:LogFile) $True

            Throw
        }
        finally
        {
            if ($HasMountedImage)
            {
                Dismount-Image
                $HasMountedImage = $False
            }
            
            if ($HasMountedVhd)
            {
                Dismount-VHD -Path $Script:TargetImageFilePath
                $HasMountedVhd = $False
            }
        
            if ($HasWorkFinished)
            {
                # All good.
                Remove-Item -Recurse -Path $Script:TargetTempPath
            }
        }
    }
}

### -----------------------------------
### Phase 0
### -----------------------------------

Function Initialize-PathValues(
    [String]$BasePath, 
    [String]$TargetPath, 
    [String]$Language,
    [String]$DriversPath, 
    [String]$DomainBlobPath, 
    [String[]]$Packages,
    [String]$LangPackages,
    [String]$NeutralPackages, 
    [String]$MediaPath, 
    [UInt64]$MaxSize,
    [String]$MergePath)
{
    Write-Verbose -Message $Strings.MSG_COMPUTING_PATHS

    # Compute the directory structure.
    # --------------------------------

    if ($env:RazzleToolPath)
    {
        $Script:Internal = $True
    }
    else
    {
        $Script:Internal = $False
    }

    # Source
    $Script:HasMediaPath = [bool]$MediaPath
    if ($Script:HasMediaPath)
    {
        $Script:NanoPath = Join-Path -Path $MediaPath -ChildPath "NanoServer"
        $Script:PackagesPath = Join-Path -Path $NanoPath -ChildPath "Packages"
        $Script:LanguagePackagesPath = Join-Path -Path $PackagesPath -ChildPath $Language

        $Script:SourcesPath = Join-Path -Path $MediaPath -ChildPath "sources"
    }

    # Base
    if (-not $BasePath)
    {
        $BasePath = Join-Path -Path $env:TEMP -ChildPath "NanoServerImageGenerator"
    }
    $Script:BasePath = $BasePath

    if ($Script:Internal)
    {
        $Script:BaseToolsPath = Join-Path -Path $env:RazzleToolPath -ChildPath "amd64"
    }
    else
    {
        $Script:BaseToolsPath = Join-Path -Path $BasePath -ChildPath "Tools"
    }
    
    if ($NeutralPackages)
    {
        $Script:BasePackagesPath = $NeutralPackages
    }
    else
    {
        $Script:BasePackagesPath = Join-Path -Path $BasePath -ChildPath "Packages"
    }
    
    if ($LangPackages)
    {
        $Script:BaseLanguagePackagesPath = $LangPackages
    }
    else
    {
        $Script:BaseLanguagePackagesPath = Join-Path -Path $Script:BasePackagesPath -ChildPath $Language
    }

    # Target
    if ($TargetPath)
    {
        $Script:TargetImageFilePath = $TargetPath
        $Script:TargetPath = [System.IO.Path]::GetDirectoryName($TargetPath)
        if (-not $Script:TargetPath)
        {
            $Script:TargetPath = "."
        }
        $Script:ImageFormat = [System.IO.Path]::GetExtension($TargetPath).Substring(1)
    }

    # Image size in bytes
    $Script:MaxSize = $MaxSize

    # Drivers
    $Script:DriversPath = $DriversPath

    # Domain
    $Script:DomainBlobPath = $DomainBlobPath

    # Compute the file paths.
    # -----------------------

    # Source
    $Script:ImageConverterPath = Join-Path -Path $PSScriptRoot -ChildPath $IMAGE_CONVERTER
    
    if ($Script:HasMediaPath)
    {
        $Script:ImageFilePath = Join-Path -Path $Script:NanoPath -ChildPath $IMAGE_NAME;
    
        $Script:PackageFilePaths = @{}
        $Script:LanguagePackageFilePaths = @{}

        if ($Packages)
        {
            $Packages | ForEach-Object { 
                $Script:PackageFilePaths.Add($_, (Join-Path -Path $Script:PackagesPath -ChildPath ($_ + ".cab"))) 
                $Script:LanguagePackageFilePaths.Add($_, (Join-Path -Path $Script:LanguagePackagesPath -ChildPath ($_ + ".cab")))
            }
        }
    }

    # Base
    $Script:BaseWimImageFilePath = Join-Path -Path $BasePath -ChildPath $IMAGE_NAME
    $Script:BaseDismFilePath = Join-Path -Path $Script:BaseToolsPath -ChildPath "dism.exe"

    $Script:BasePackageFilePaths = @{}
    $Script:BaseLanguagePackageFilePaths = @{}

    if ($Packages)
    {
        $Packages | ForEach-Object { 
            $Script:BasePackageFilePaths.Add($_, (Join-Path -Path $Script:BasePackagesPath -ChildPath ($_ + ".cab"))) 
            $Script:BaseLanguagePackageFilePaths.Add($_, (Join-Path -Path $Script:BaseLanguagePackagesPath -ChildPath ($_ + ".cab")))
        }
    }

    $Script:BaseImageFilePath = Join-Path -Path $BasePath -ChildPath ((Split-Path -Path $BasePath -Leaf) + "." + $Script:ImageFormat)

    # Target
    $Script:TargetTempPath = Join-Path -Path $BasePath -ChildPath "Temp"
    $Script:TargetMountPath = Join-Path -Path $Script:TargetTempPath -ChildPath "Mount"
    $Script:TargetUnattendFilePath = Join-Path -Path $Script:TargetTempPath -ChildPath "Unattend.xml"
    $Script:TargetDomainBlobPath = Join-Path -Path $Script:TargetTempPath -ChildPath "djoin.blob"
    $Script:TargetSetupCompleteFilePath = Join-Path -Path $Script:TargetTempPath -ChildPath "SetupComplete.cmd"
    
    if ($TargetPath)
    {
        $Script:TargetDebuggingKeyFilePath = Join-Path -Path $Script:TargetPath -ChildPath $KERNEL_DEBUG_KEY_FILE
    }

    $Script:MergePath = $MergePath
}

Function Test-Paths([String[]]$Packages)
{
    Write-Verbose -Message $Strings.MSG_CHECKING_PATHS

    if ($Script:HasMediaPath)
    {
        # Check media directory structure.
        if (!(Test-Path -Path $Script:NanoPath))
        {
            Throw ($Strings.ERR_DIRECTORY_DOES_NOT_EXIST_IN_MEDIA_DIRECTORY -f "NanoServer")
        }
        if (!(Test-Path -Path $Script:PackagesPath))
        {
            Throw ($Strings.ERR_DIRECTORY_DOES_NOT_EXIST_IN_DIRECTORY -f "Packages", "NanoServer", $Script:NanoPath)
        }
        if (!(Test-Path -Path $Script:LanguagePackagesPath))
        {
            Throw ($Strings.ERR_DIRECTORY_DOES_NOT_EXIST_IN_DIRECTORY -f $Language, "Packages", $Script:PackagesPath)
        }

        if (!(Test-Path -Path $Script:SourcesPath))
        {
            Throw ($Strings.ERR_DIRECTORY_DOES_NOT_EXIST_IN_MEDIA_DIRECTORY -f "Sources")
        }
        
        # Check that the Nano Server image is present in the media path.
        if (!(Test-Path -Path $Script:ImageFilePath))
        {
            Throw ($Strings.ERR_IMAGE_DOES_NOT_EXIST -f $IMAGE_NAME)
        }
    }
    else
    {
        # Check base directory structure.
        if (!(Test-Path -Path $Script:BasePath) -and !$script:Internal)
        {
            Throw $Strings.ERR_BASE_DIRECTORY_DOES_NOT_EXIST
        }
        if (!(Test-Path -Path $Script:BaseToolsPath))
        {
            Throw ($Strings.ERR_DIRECTORY_DOES_NOT_EXIST_IN_BASE_DIRECTORY -f "Tools")
        }
        if (!(Test-Path -Path $Script:BasePackagesPath))
        {
            Throw ($Strings.ERR_DIRECTORY_DOES_NOT_EXIST_IN_BASE_DIRECTORY -f "Packages")
        }

        if (!(Test-Path -Path $Script:BaseLanguagePackagesPath))
        {
            Write-Output -InputObject ($Strings.ERR_DIRECTORY_DOES_NOT_EXIST_IN_DIRECTORY -f $Language, "Packages", $Script:BasePackagesPath)
        }
        
        # Check that the Nano Server image is present in the base path.
        if (!(Test-Path -Path $Script:BaseWimImageFilePath) -and !$script:Internal -and $Script:NewImage)
        {
            Throw ($Strings.ERR_IMAGE_DOES_NOT_EXIST_IN_BASE_DIRECTORY -f $IMAGE_NAME)
        }
    }

    # Check that the existing image actually exists
    if (!$Script:HasMediaPath)
    {
        if ((!$Script:TargetImageFilePath -or !(Test-Path -Path $Script:TargetImageFilePath)) -and !$Script:NewImage)
        {
            Throw $Strings.ERR_SPECIFIED_IMAGE_DOES_NOT_EXIST
        }

        if (!($Script:ImageFormat -eq "vhd") -and !($Script:ImageFormat -eq "vhdx"))
        {
            Throw ($Strings.ERR_INVALID_IMAGE_TYPE_SPECIFIED -f $Script:ImageFormat)
        }
    }

    # Check that the given drivers path exists.
    if ($Script:DriversPath -and !(Test-Path -Path $Script:DriversPath))
    {
        Throw ($Strings.ERR_DRIVERS_DIRECTORY_DOES_NOT_EXIST -f $Script:DriversPath)
    }

    # Check that the image converter script is present.
    if ($Script:HasMediaPath -and !(Test-Path -Path $Script:ImageConverterPath))
    {
        Throw $Strings.ERR_IMAGE_CONVERTER_SCRIPT_DOES_NOT_EXIST
    }

    if ($Script:HasMediaPath)
    {
        # Check that the files for the requested packages are present in the media directory.
        $PackagesNotFound = $Script:PackageFilePaths.GetEnumerator() | Where-Object { ($Packages.Contains($_.Key) -and !(Test-Path -Path $_.Value)) }
        $LanguagePackagesNotFound = $Script:LanguagePackageFilePaths.GetEnumerator() | Where-Object { ($Packages.Contains($_.Key) -and !(Test-Path -Path $_.Value)) }
    }
    else
    {
        # Check that the files for the requested packages are present in the base directory.
        $PackagesNotFound = $Script:BasePackageFilePaths.GetEnumerator() | Where-Object { ($Packages.Contains($_.Key) -and !(Test-Path -Path $_.Value)) }
        $LanguagePackagesNotFound = $Script:BaseLanguagePackageFilePaths.GetEnumerator() | Where-Object { ($Packages.Contains($_.Key) -and !(Test-Path -Path $_.Value)) }
    }
    
    if ($PackagesNotFound)
    {
        $PackagesNotFound | ForEach-Object { Write-Log $LEVEL_WARNING ($Strings.ERR_PACKAGE_DOES_NOT_EXIST -f $_.Value) }
    }
    if ($LanguagePackagesNotFound)
    {
        $LanguagePackagesNotFound | ForEach-Object { Write-Log $LEVEL_WARNING ($Strings.ERR_LANGUAGE_PACKAGE_DOES_NOT_EXIST -f $_.Value) }
    }

    if ($PackagesNotFound -or $LanguagePackagesNotFound)
    {
        Throw $Strings.ERR_ONE_OR_MORE_PACKAGES_DO_NOT_EXIST
    }
    
    # Check that the specified domain blob path exists.
    if ($Script:DomainBlobPath -and !(Test-Path -Path $Script:DomainBlobPath))
    {
        Throw $Strings.ERR_DOMAIN_BLOB_DOES_NOT_EXIST
    }

    if ($Script:MergePath -and !(Test-Path $Script:MergePath))
    {
        Throw $Strings.ERR_MERGE_PATH_DOES_NOT_EXIST
    }
}

Function Initialize-Paths()
{
    Write-Verbose -Message $Strings.MSG_CREATING_PATHS

    New-Item -ItemType Directory -Force -Path $Script:BasePath | Write-Verbose
    New-Item -ItemType Directory -Force -Path $Script:BaseToolsPath | Write-Verbose
    New-Item -ItemType Directory -Force -Path $Script:BasePackagesPath | Write-Verbose
    New-Item -ItemType Directory -Force -Path $Script:BaseLanguagePackagesPath | Write-Verbose

    New-Item -ItemType Directory -Force -Path $Script:TargetPath | Write-Verbose
    New-Item -ItemType Directory -Force -Path $Script:TargetMountPath  | Write-Verbose

    $Script:TargetMountPath = (Resolve-Path -Path (Join-Path -Path $Script:TargetTempPath -ChildPath "Mount")).Path 
}

### -----------------------------------
### Phase 1
### -----------------------------------

Function Copy-Files()
{
    if (!$Script:HasMediaPath)
    {
        Write-Verbose -Message $Strings.MSG_SKIPPING_FILE_COPY

        return
    }

    Write-Verbose -Message $Strings.MSG_COPYING_FILES
    Write-Progress -Activity $Strings.MSG_COPYING_FILES

    # Copy the tools (exclude the large, unnecessary WIM's in that folder).
    Copy-Item -Path $Script:SourcesPath\* -Destination $Script:BaseToolsPath -Exclude *.wim -Force

    # Copy the image
    Copy-Item -Path $Script:ImageFilePath -Destination $Script:BasePath -Force

    # Copy the packages
    Copy-Item -Path $Script:PackagesPath\*.cab -Destination $Script:BasePackagesPath -Force
    Copy-Item -Path $Script:LanguagePackagesPath\*.cab -Destination $Script:BaseLanguagePackagesPath -Force
}

Function Convert-Image()
{
    Write-Verbose -Message $Strings.MSG_CONVERTING_IMAGE
    Write-Progress -Activity $Strings.MSG_CONVERTING_IMAGE

    $Parameters = @{}
    $Parameters["-SourcePath"] = $Script:BaseWimImageFilePath
    $Parameters["-VHDPath"] = $Script:BaseImageFilePath
    $Parameters["-VHDFormat"] = $Script:ImageFormat
    $Parameters["-EnableDebugger"] = "None"
    $Parameters["-Edition"] = "CORESYSTEMSERVER_INSTALL"
    if ($Script:ImageFormat -eq "vhdx")
    {
        $Parameters["-DiskLayout"] = "UEFI"
    }
    else
    {
        $Parameters["-DiskLayout"] = "BIOS"
    }
    $Parameters["-SizeBytes"] = $Script:MaxSize

    & $Script:ImageConverterPath @Parameters
}

Function Copy-Image()
{
    Write-Verbose -Message $Strings.MSG_COPYING_IMAGE
    Write-Progress -Activity $Strings.MSG_COPYING_IMAGE

    Copy-Item -Path $Script:BaseImageFilePath -Destination $Script:TargetImageFilePath
}

### -----------------------------------
### Phase 2
### -----------------------------------

Function Add-Directory()
{
    if (!$Script:MergePath)
    {
        Write-Verbose -Message $Strings.MSG_SKIPPING_DIRECTORY_MERGING
    
        return
    }
    
    Write-Verbose -Message $Strings.MSG_MERGING_DIRECTORY
    Write-Progress -Activity $Strings.MSG_MERGING_DIRECTORY
    
    Copy-Item -Recurse -Force -Path $Script:MergePath -Destination $Script:TargetMountPath
}

Function Add-Packages([String[]]$Packages)
{
    if (!$Packages)
    {
        Write-Verbose -Message $Strings.MSG_SKIPPING_PACKAGE_ADDITION
        
        return
    }

    Write-Verbose -Message $Strings.MSG_ADDING_PACKAGES
    Write-Progress -Activity $Strings.MSG_ADDING_PACKAGES

    $Packages | ForEach-Object { 
        Add-Package $_ $Script:BasePackageFilePaths[$_] $False
        Add-Package $_ $Script:BaseLanguagePackageFilePaths[$_] $True 
    }
}

Function Add-Package([String]$PackageName, [String]$PackageFilePath, [Bool]$IsLanguage)
{
    if (!(Test-Path -Path $PackageFilePath))
    {
        return
    }
    
    if ($IsLanguage)
    {        
        $Message = $Strings.MSG_ADDING_LANGUAGE_PACKAGE -f $PackageName
    }
    else
    {
        $Message = $Strings.MSG_ADDING_PACKAGE -f $PackageName
    }

    Write-Progress -Id 1 -Activity $Message

    Invoke-ExternalCommand "& '$Script:BaseDismFilePath' /Add-Package /PackagePath:'$PackageFilePath' /Image:'$Script:TargetMountPath' /LogLevel:2 /LogPath:'$Script:DismLogFile'"

    Write-Progress -Id 1 -Activity $Message -Completed
}

Function Add-Drivers()
{
    if (!$Script:DriversPath)
    {
        Write-Verbose -Message $Strings.MSG_SKIPPING_DRIVER_ADDITION

        return
    }

    Write-Verbose -Message $Strings.MSG_ADDING_DRIVERS
    Write-Progress -Activity $Strings.MSG_ADDING_DRIVERS

    Invoke-ExternalCommand "& '$Script:BaseDismFilePath' /Add-Driver /Driver:'$Script:DriversPath' /Recurse /Image:'$Script:TargetMountPath' /LogLevel:2 /LogPath:'$Script:DismLogFile'"
}

### -----------------------------------
### Phase 3
### -----------------------------------

Function ConvertTo-String([SecureString]$SecureString)
{
    if (-not $SecureString)
    {
        return $null
    }

    $PointerToPasswordString = [System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($SecureString)
    $ManagedPasswordString = [System.Runtime.InteropServices.Marshal]::PtrToStringUni($PointerToPasswordString)
    [System.Runtime.InteropServices.Marshal]::ZeroFreeCoTaskMemUnicode($PointerToPasswordString)
    
    return $ManagedPasswordString
}

Function Add-ServicingDescriptor([String]$ComputerName, [SecureString]$AdministratorPassword)
{
    if (-not $ComputerName -and -not $AdministratorPassword)
    {
        return
    }

    Write-Verbose -Message $Strings.MSG_ADDING_UNATTEND
    Write-Progress -Activity $Strings.MSG_ADDING_UNATTEND
    
    # Write out the unattend.
    Write-Xml $ComputerName $AdministratorPassword
    
    # Embed the descriptor into the image.
    Invoke-ExternalCommand "& '$Script:BaseDismFilePath' /Image:'$Script:TargetMountPath' /Apply-Unattend:'$Script:TargetUnattendFilePath' /LogLevel:2 /LogPath:'$Script:DismLogFile'"

    # Copy the unattend over.
    New-Item -ItemType Directory -Force -Path $Script:TargetMountPath\Windows\Panther | Out-Null
    Copy-Item -Path $Script:TargetUnattendFilePath -Destination $Script:TargetMountPath\Windows\Panther -Force
}

Function Write-Xml([String]$ComputerName, [SecureString]$AdministratorPassword)
{
    $Xml = New-Object -TypeName Xml
    $XmlNs = "urn:schemas-microsoft-com:unattend"
    
    $XmlDecl = $Xml.CreateXmlDeclaration("1.0", "utf-8", $Null)
    $XmlRoot = $Xml.DocumentElement
    $Xml.InsertBefore($XmlDecl, $XmlRoot) | Out-Null

    $XmlUnattended = $Xml.CreateElement("unattend", $XmlNs)
    $XmlUnattended.SetAttribute("xmlns:wcm", "http://schemas.microsoft.com/WMIConfig/2002/State")
    $XmlUnattended.SetAttribute("xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance")
    $Xml.AppendChild($XmlUnattended) | Out-Null

    if ($AdministratorPassword)
    {
        Write-AdministratorPasswordXml $Xml $XmlNs $XmlUnattended $AdministratorPassword
    }

    if ($ComputerName)
    {
        Write-ComputerNameXml $Xml $XmlNs $XmlUnattended $ComputerName
    }
    
    # Normal .NET methods are unaware of the PowerShell context. In this case,
    # the path to save the XML to is relative. While PowerShell would resolve
    # it as we would expect, the .NET method will do so relative to its working
    # directory, which is not necessarily the same as PowerShell's. So, we need
    # to expand the relative path manually.
    $TargetPath = $Script:TargetUnattendFilePath
    if (-not [System.IO.Path]::IsPathRooted($TargetPath))
    {
        $TargetPath = Join-Path -Path (Get-Location) -ChildPath $Script:TargetUnattendFilePath
    }
    $Xml.Save([System.IO.Path]::GetFullPath($TargetPath))
}

Function Write-ComputerNameXml([Xml]$Xml, [String]$XmlNs, [System.Xml.XmlElement]$XmlUnattended, [String]$ComputerName)
{
    $XmlSettings = $Xml.CreateElement("settings", $XmlNs)
    $XmlSettings.SetAttribute("pass", "offlineServicing")
    $XmlUnattended.AppendChild($XmlSettings) | Out-Null

    $XmlComponent = $Xml.CreateElement("component", $XmlNs)
    $XmlComponent.SetAttribute("name", "Microsoft-Windows-Shell-Setup")
    $XmlComponent.SetAttribute("processorArchitecture", "amd64")
    $XmlComponent.SetAttribute("publicKeyToken", "31bf3856ad364e35")
    $XmlComponent.SetAttribute("language", "neutral")
    $XmlComponent.SetAttribute("versionScope", "nonSxS")
    $XmlSettings.AppendChild($XmlComponent) | Out-Null

    $XmlComputerName = $Xml.CreateElement("ComputerName", $XmlNs)
    $XmlName = $Xml.CreateTextNode($ComputerName)
    $XmlComputerName.AppendChild($XmlName) | Out-Null
    $XmlComponent.AppendChild($XmlComputerName) | Out-Null
}

Function Write-AdministratorPasswordXml([Xml]$Xml, [String]$XmlNs, [System.Xml.XmlElement]$XmlUnattended, [SecureString]$AdministratorPassword)
{
    $XmlSettings = $Xml.CreateElement("settings", $XmlNs)
    $XmlSettings.SetAttribute("pass", "oobeSystem")
    $XmlUnattended.AppendChild($XmlSettings) | Out-Null

    $XmlComponent = $Xml.CreateElement("component", $XmlNs)
    $XmlComponent.SetAttribute("name", "Microsoft-Windows-Shell-Setup")
    $XmlComponent.SetAttribute("processorArchitecture", "amd64")
    $XmlComponent.SetAttribute("publicKeyToken", "31bf3856ad364e35")
    $XmlComponent.SetAttribute("language", "neutral")
    $XmlComponent.SetAttribute("versionScope", "nonSxS")
    $XmlSettings.AppendChild($XmlComponent) | Out-Null

    $XmlUserAccounts = $Xml.CreateElement("UserAccounts", $XmlNs)
    $XmlComponent.AppendChild($XmlUserAccounts) | Out-Null

    $XmlAdministratorPassword = $Xml.CreateElement("AdministratorPassword", $XmlNs)
    $XmlUserAccounts.AppendChild($XmlAdministratorPassword) | Out-Null
    
    $XmlValue = $Xml.CreateElement("Value", $XmlNs)
    $XmlText = $Xml.CreateTextNode([Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes((ConvertTo-String $AdministratorPassword) + "AdministratorPassword")))
    $XmlValue.AppendChild($XmlText) | Out-Null
    $XmlAdministratorPassword.AppendChild($XmlValue) | Out-Null

    $XmlPlainText = $Xml.CreateElement("PlainText", $XmlNs)
    $XmlPassword = $Xml.CreateTextNode("false")
    $XmlPlainText.AppendChild($XmlPassword) | Out-Null
    $XmlAdministratorPassword.AppendChild($XmlPlainText) | Out-Null
}

Function Join-Domain([String]$DomainName, [Bool]$ReuseDomainNode)
{
    # If the target image must join a domain, but a blob was not provided, one
    # must be harvested from the local machine.
    if ($DomainName -and !$Script:DomainBlobPath)
    {
        Write-Verbose -Message $Strings.MSG_COLLECTING_DOMAIN_BLOB

        $Command = "djoin /Provision /Domain $DomainName /Machine $ComputerName /SaveFile '$Script:TargetDomainBlobPath'"
        if ($ReuseDomainNode)
        {
            $Command += " /Reuse"
        }

        Invoke-ExternalCommand $Command

        $Script:DomainBlobPath = $Script:TargetDomainBlobPath
    }

    if ($Script:DomainBlobPath)
    {
        Write-Verbose -Message $Strings.MSG_JOINING_DOMAIN

        Invoke-ExternalCommand "djoin /RequestODJ /LoadFile '$Script:DomainBlobPath' /WindowsPath '$Script:TargetMountPath\Windows'"
    }
}

### -----------------------------------
### Phase 4
### -----------------------------------

Function Enable-Debug([String]$BCDPath)
{
    Write-Verbose -Message $Strings.MSG_ENABLING_DEBUG
    Write-Progress -Activity $Strings.MSG_ENABLING_DEBUG
 
    Invoke-ExternalCommand("bcdedit /Store '$BCDPath' /BootDebug ``{bootmgr``} ON")
    Invoke-ExternalCommand("bcdedit /Store '$BCDPath' /BootDebug ``{default``} ON")
    Invoke-ExternalCommand("bcdedit /Store '$BCDPath' /Debug ``{default``} ON")
}

Function Enable-DebugSerial([String]$BCDPath, [Int]$Port, [Int]$BaudRate)
{
    Invoke-ExternalCommand("bcdedit /Store '$BCDPath' /DBGSettings SERIAL DEBUGPORT:$Port BAUDRATE:$BaudRate")
}

Function Enable-DebugNet([String]$BCDPath, [String]$RemoteIP, [String]$RemotePort, [String]$Key)
{
    $Command = "bcdedit /Store '$BCDPath' /DBGSettings NET HOSTIP:$RemoteIP PORT:$RemotePort"
    if ($Key)
    {
        $Command += " KEY:$Key"
    }

    Invoke-ExternalCommand("$Command > '$Script:TargetDebuggingKeyFilePath'")
    
    Write-Log $LEVEL_OUTPUT ($Strings.MSG_KERNEL_DEBUG_KEY_FILE -f $Script:TargetDebuggingKeyFilePath)
}

Function Enable-DebugFirewire([String]$BCDPath, [Int]$Channel)
{
    Invoke-ExternalCommand("bcdedit /Store '$BCDPath' /DBGSettings 1394 Channel:$Channel")
}

Function Enable-DebugUSB([String]$BCDPath, [String]$TargetName)
{
    Invoke-ExternalCommand("bcdedit /Store '$BCDPath' /DBGSettings USB TargetName:$TargetName")
}

Function Enable-EMS([String]$BCDPath, [Int]$Port, [Int]$BaudRate)
{
    Write-Verbose -Message $Strings.MSG_ENABLING_EMS
    Write-Progress -Activity $Strings.MSG_ENABLING_EMS

    Invoke-ExternalCommand("bcdedit /Store '$BCDPath' /EMS ``{default``} ON")
    Invoke-ExternalCommand("bcdedit /Store '$BCDPath' /EMSSettings EMSPORT:$Port EMSBAUDRATE:$BaudRate")
    Invoke-ExternalCommand("bcdedit /Store '$BCDPath' /BootEMS ``{default``} ON")
    Invoke-ExternalCommand("bcdedit /Store '$BCDPath' /BootEMS ``{bootmgr``} ON")
}

Function Write-SetupComplete(
    [Bool]$OpenPort,
    [String]$InterfaceNameOrIndex,
    [String]$Ipv6Address,
    [String]$Ipv4Address,
    [String]$Ipv4SubnetMask,
    [String]$Ipv4Gateway)
{
    New-Item -ItemType Directory -Force -Path "$Script:TargetMountPath\Windows\Setup\Scripts" | Out-Null

    # To populate the batch file, the > and >> operators cannot be used. The
    # resulting file must be encoded in ASCII.
    $SetupCompleteCommand = "@ECHO OFF`n"
    if ($Ipv6Address)
    {
        $SetupCompleteCommand += "netsh interface ipv6 set address `"$InterfaceNameOrIndex`" $Ipv6Address`n"
    }
    if ($Ipv4Address)
    {
        $SetupCompleteCommand += "netsh interface ipv4 set address `"$InterfaceNameOrIndex`" static $Ipv4Address $Ipv4SubnetMask $Ipv4Gateway`n"
    }
    if ($OpenPort)
    {
        $SetupCompleteCommand += "netsh advfirewall firewall add rule name=`"WinRM 5985`" protocol=TCP dir=in localport=5985 profile=any action=allow`n"
    }
    
    Set-Content -Value $SetupCompleteCommand -Path "$Script:TargetSetupCompleteFilePath" -Encoding ASCII
    
    Copy-Item -Path $Script:TargetSetupCompleteFilePath -Destination "$Script:TargetMountPath\Windows\Setup\Scripts" -Force
}

### -----------------------------------
### Helper Methods
### -----------------------------------

Function Mount-Image()
{
    Write-Verbose -Message $Strings.MSG_MOUNTING_IMAGE
    Write-Progress -Activity $Strings.MSG_MOUNTING_IMAGE

    Invoke-ExternalCommand "& '$Script:BaseDismFilePath' /Mount-Image /ImageFile:'$Script:TargetImageFilePath' /MountDir:'$Script:TargetMountPath' -Index:1 /LogLevel:2 /LogPath:'$Script:DismLogFile'"
}

Function Dismount-Image([Switch]$Discard)
{
    Write-Verbose -Message $Strings.MSG_DISMOUNTING_IMAGE
    Write-Progress -Activity $Strings.MSG_DISMOUNTING_IMAGE

    if ($Discard)
    {
        Invoke-ExternalCommand "& '$Script:BaseDismFilePath' /Unmount-Image /MountDir:'$Script:TargetMountPath' /Discard /LogLevel:2 /LogPath:'$Script:DismLogFile'"
    }
    else
    {
        Invoke-ExternalCommand "& '$Script:BaseDismFilePath' /Unmount-Image /MountDir:'$Script:TargetMountPath' /Commit /LogLevel:2 /LogPath:'$Script:DismLogFile'"
    }
}

Function Mount-AsBasicData()
{
    $HasMountedVhd = $False
    try
    {
        Mount-VHD -Path $Script:TargetImageFilePath -NoDriveLetter
        $HasMountedVhd = $True
        $disk = Get-VHD -Path $Script:TargetImageFilePath | Get-Disk
        $diskId = $disk.Number
        $partition = $disk | Get-Partition | Where-Object { $_.Type -eq "System" }
        $partId = $partition.PartitionNumber
        $partGuid = $partition.Guid
        
        $DiskpartScript = Join-Path -Path $Script:TargetTempPath -ChildPath "diskpart.txt"
        
        $DiskpartCommands = "select disk $diskId`nselect partition $partId`nset id=ebd0a0a2-b9e5-4433-87c0-68b6b72699c7"
        $DiskpartCommands | Out-File -Encoding ASCII -FilePath $DiskpartScript

        Invoke-ExternalCommand "diskpart.exe /s $DiskpartScript"
        
        $partition | Add-PartitionAccessPath -AccessPath $Script:TargetMountPath -ErrorAction Stop
        Remove-Item $DiskpartScript
        
        return $partGuid
    }
    catch
    {
        if ($HasMountedVhd)
        {
            Dismount-VHD -Path $Script:TargetImageFilePath
            $HasMountedVhd = $False
        }
        
        throw
    }
}

Function Dismount-AsSystemPartition([String]$guid)
{
    try
    {
        $partition = Get-Partition | Where-Object { $_.Guid -eq $guid }
        $diskId = $partition.DiskNumber
        $partId = $partition.PartitionNumber
        
        $partition | Remove-PartitionAccessPath -AccessPath $Script:TargetMountPath -ErrorAction Stop
        
        $DiskpartScript = Join-Path -Path $Script:TargetTempPath -ChildPath "diskpart.txt"

        $DiskpartCommands = "select disk $diskId`nselect partition $partId`nset id=c12a7328-f81f-11d2-ba4b-00a0c93ec93b"
        $DiskpartCommands | Out-File -Encoding ASCII -FilePath $DiskpartScript
        Invoke-ExternalCommand "diskpart.exe /s $DiskpartScript"
        
        Remove-Item $DiskpartScript
    }
    catch
    {
        Dismount-VHD -Path $Script:TargetImageFilePath
    }
}

Function Invoke-ExternalCommand([String]$Command)
{
    Write-Log $LEVEL_VERBOSE $Command
    $Output = (Invoke-Expression -Command ("{0} 2>&1" -f $Command) | Out-String)

    if ($LastExitCode)
    {
        Write-Log $LEVEL_NONE $Output -Verbose

        Throw ($Strings.ERR_EXTERNAL_CMD -f $LastExitCode)
    }
}

Function Write-Log([String]$Level, [String]$Message, [Bool]$AppendNewLine = $False, [switch]$NoOutput)
{
    $LogMessage = $Message
    if ($AppendNewLine)
    {
        $LogMessage += "`n"
    }
    Write-Output -InputObject "$(Get-Date) $LogMessage" | Out-File -FilePath $Script:LogFile -Append

    if (-not $NoOutput)
    {
        switch ($Level)
        {
            { $_ -eq $LEVEL_WARNING } { Write-Warning -Message $Message }
            { $_ -eq $LEVEL_VERBOSE } { Write-Verbose -Message $Message }
            { $_ -eq $LEVEL_OUTPUT } { Write-Output -InputObject $Message }
        }
    }
}

Function Verify-UserIsAdministrator()
{
    $CurrentUser = New-Object -TypeName Security.Principal.WindowsPrincipal -ArgumentList $([Security.Principal.WindowsIdentity]::GetCurrent())
    if (!$CurrentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator))
    {
        Throw $Strings.ERR_USER_MUST_BE_ADMINISTRATOR
    }
}

Function New-DynamicParameter([String]$Name, [System.Type]$Type, $Value, [switch]$Mandatory, [switch]$NotNull)
{
    $ParamAttr = New-Object -TypeName System.Management.Automation.ParameterAttribute
    $ParamAttr.ParameterSetName  = "__AllParameterSets"
    $ParamAttr.Mandatory = $Mandatory

    $AttrCollection = New-Object -TypeName System.Collections.ObjectModel.Collection[System.Attribute]
    $AttrCollection.Add($ParamAttr)

    $Parameter = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameter -ArgumentList ($Name, $Type, $AttrCollection)

    if ($Value)
    {
        $Parameter.Value = $Value
    }

    return $Parameter
}

Export-ModuleMember -Function New-NanoServerImage, Edit-NanoServerImage, Get-NanoServerPackages
