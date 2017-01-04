## WindowsPowerShellWebAccessa

Install-WindowsFeature -Name WindowsPowerShellWebAccess -ComputerName <computer_name> -IncludeManagementTools
Install-WindowsFeature -Name WindowsPowerShellWebAccess -ComputerName 127.0.0.1 -IncludeManagementTools
Install-PswaWebApplication 
Install-PswaWebApplication -UseTestCertificate
Install-PswaWebApplication -webApplicationName ps �useTestCertificate
Test-PswaAuthorizationRule
Get-PswaAuthorizationRule
Add-PswaAuthorizationRule -UserName * -ComputerName * -ConfigurationName *.
    + CategoryInfo          : InvalidArgument: (:) [Add-PswaAuthorizationRule], ParameterBindingException

PS>
Get-VM * 
Enable-PSRemoting -Force
Add-PswaAuthorizationRule -UserName <domain\u>
