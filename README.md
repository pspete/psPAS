# psPAS

**CyberArk PowerShell Module**

PowerShell module for CyberArk Privileged Account Security Web Services REST API.

Exposes the available methods of the web service for CyberArk PAS up to v9.9.

----------
## Getting Started

NOTE: Currently only CyberArk authentication is enabled for the module.

### Prerequisites

 - Requires Powershell v3 (minimum)
 - CyberArk PAS REST API/Web Service
	 - Your version of CyberArk determines the supported functions.
	 - Check the [compatibility table](#CyberArk_Version_Compatibility) to determine what you can use. 
 - A CyberArk user with which to authenticate.

### Install & Use

Save the Module to your powershell modules folder of choice.
Find your local PowerShell module paths with the following command:
```
$env:PSModulePath
```
The name of the folder for the module should be "psPAS".

Import the module:

```
Import-Module psPAS
```
Discover Commands:
```
Get-Command -Module psPAS
```

Logon to the CyberArk Vault:

```
$token = New-PASSession -Credential $VaultCredentials -BaseURI https://PVWA_URL
```

The New-PASSession output contains:

 - The CyberArk Authentication Token
	 - Required for all subsequent calls to the API
 - A WebSession object
	 - Useful if the API sits behind a loadbalancer
 - The specified PVWA URL
	 - For convenience

This output can be piped into all other functions to provide the values for the necessary default parameters.
```
$token | Get-PASAccount -Keywords root -Safe UNIX

$token | Add-PASSafe -SafeName psPAS -ManagingCPM PasswordManager -NumberOfVersionsRetention 10
```
A CyberArk authentication token, and the URL of the Web Service, MUST be provided to each function (with the exception of Logon via New-PASSession).
```
Get-PASUser -UserName psPASUser -sessionToken $token.sessionToken -baseURI "http://PVWA"
```
## Author

* **Pete Maan** - [pspete](https://github.com/pspete)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments
Hat Tips:

**Warren Frame** ([RamblingCookieMonster](https://github.com/RamblingCookieMonster)) for    the borrowed    [Add-ObjectDetail.ps1](https://github.com/RamblingCookieMonster/PowerShell/blob/master/Add-ObjectDetail.ps1)    &    [New-DynamicParam.ps1](https://github.com/RamblingCookieMonster/PowerShell/blob/master/New-DynamicParam.ps1)    helper functions.

**Joe Garcia** ([infamousjoeg](https://github.com/infamousjoeg)) for the unofficial API documentation

Chapeau!

## <a id="CyberArk_Version_Compatibility"></a>CyberArk Version Compatibility
|CyberArk Version|Supported psPAS Module Functions|
|:---:|:---|
|9.0|`New-PASSession`<br/>`Close-PASSession`<br/>`Add-PASAccount`<br/>`Get-PASPolicyACL`<br/>`Add-PASPolicyACL`<br/>`Remove-PASPolicyACL`<br/>`Get-PASAccountACL`<br/>`Add-PASAccountACL`<br/>`Remove-PASAccountACL`<br/><br/>|
|9.1|All Previous Functions, and:<br/>`Get-PASApplications`<br/>`Get-PASApplication`<br/>`Add-PASApplication`<br/>`Get-PASApplicationAuthenticationMethods`<br/>`Add-PASApplicationAuthenticationMethod`<br/>`Remove-PASApplication`<br/>`Remove-PASApplicationAuthenticationMethod`<br/><br/>|
|9.2|All Previous Functions, and:<br/>`Add-PASSafe`<br/><br/>|
|9.3|All Previous Functions, and:<br/>`Get-PASAccount`<br/>`Remove-PASAccount`<br/>`Start-PASCredChange`<br/>`Set-PASSafe`<br/>`Remove-PASSafe`<br/>`Add-PASSafeMember`<br/>`Set-PASSafeMember`<br/>`Remove-PASSafeMember`<br/><br/>|
|9.4|All Previous Functions<br/><br/>|
|9.5|All Previous Functions, and:<br/>`Set-PASAccount`<br/><br/>|
|9.6|All Previous Functions, and:<br/>`Add-PASPublicSSHKey`<br/>`Get-PASPublicSSHKey`<br/>`Remove-PASPublicSSHKey`<br/><br/>|
|9.7|All Previous Functions, and:<br/>`Get-PASServerWebService`<br/>`Get-PASSafeShareLogo`<br/>`Get-PASServer`<br/>`New-PASUser`<br/>`Set-PASUser`<br/>`Remove-PASUser`<br/>`Get-PASLoggedOnUser`<br/>`Get-PASUser`<br/>`Unblock-PASUser`<br/>`Add-PASGroupMember`<br/>`Add-PASPendingAccount`<br/>`Get-PASAccountCredentials`<br/>`Start-PASCredVerify`<br/>`Get-PASAccountActivity`<br/>`Get-PASSafe`<br/>`Get-PASSafeMembers`<br/><br/>|
|9.8|All Previous Functions, and:<br/>`New-PASOnboardingRule`<br/>`Remove-PASOnboardingRule`<br/>`Get-PASOnboardingRule`<br/><br/>|
|9.9|All Previous Functions, and:<br/>`New-PASAccountGroup`<br/>`Add-PASAccountGroupMember`<br/><br/>|