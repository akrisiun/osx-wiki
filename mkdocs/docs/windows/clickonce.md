# ClickOnce VS 2017

<https://docs.microsoft.com/en-us/visualstudio/deployment/how-to-set-the-clickonce-publish-version>,
<https://docs.microsoft.com/en-us/visualstudio/deployment/clickonce-unmanaged-api-reference>
ClickOnce unmanaged public APIs from dfshim.dll. 

#  Powershell signed cert

<https://technet.microsoft.com/itpro/powershell/windows/pkiclient/new-selfsignedcertificate>

```
PS>
New-SelfSignedCertificate -DnsName "www.fabrikam.com", "www.contoso.com" -CertStoreLocation "cert:\LocalMachine\My"

New-SelfSignedCertificate -DnsName "Green" -CertStoreLocation "cert:\LocalMachine\My"


New-SelfSignedCertificate -Type Custom -Provider "Microsoft Platform Crypto Provider" -Subject "CN=Patti Fuller" -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.2","2.5.29.17={text}upn=pattifuller@contoso.com") -KeyExportPolicy NonExportable -KeyUsage DigitalSignature -KeyAlgorithm RSA -KeyLength 2048 -CertStoreLocation "Cert:\CurrentUser\My"

Set-Location -Path "cert:\LocalMachine\My"
ls
```

## Mage UI 

"c:\Program Files (x86)\Microsoft SDKs\Windows\v8.1A\bin\NETFX 4.5.1 Tools\mageui.exe" 

# ClickOnce strong-named assemblies resign

https://www.preemptive.com/dotfuscator/ce/docs/help/5.27/advanced_clickonce.html

If your assemblies were strong-named, re-sign the protected versions of those assemblies with sn.exe (Strong Name Tool), for example:

```
sn.exe -R Dotfuscated\YourApplication.exe strong_name_key.snk

Copy the protected assemblies on top of the unprotected versions in the ClickOnce publish location, for example:

copy /y Dotfuscated\YourApplication.exe \
     "publish\Application Files\YourApplication_1_0_0_0\"

Update the application manifest with mage.exe (Manifest Generation and Editing Tool), for example:

mage.exe -Update "publish\Application Files\YourApplication_1_0_0_0\YourApplication.exe.manifest"\
         -CertFile YourKey.pfx -Password your_pfx_password

Update the deployment manifest, for example:

mage.exe -Update publish\YourApplication.application \
    -AppManifest "publish\Application Files\YourApplication_1_0_0_0\YourApplication.exe.manifest" \
    -CertFile YourKey.pfx -Password your_pfx_password

```

