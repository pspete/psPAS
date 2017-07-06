# psPAS

**CyberArk PowerShell Module**

PowerShell module for CyberArk Privileged Account Security Web Services REST API.

Exposes the available methods of the web service for CyberArk PAS v9.9.

----------
## Getting Started

NOTE: Currently only CyberArk authentication is enabled for the module.

### Prerequisites

 - Requires Powershell v3 (minimum)
 - CyberArk PAS REST API/Web Service
 - If using a CyberArk REST API/Web Service lower than v9.9, not all functions will work (some will - version dependant). 
	 - Check the CyberArk Web Services SDK for your CyberArk version to determine available functions. 
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
