# psPAS
**CyberArk PowerShell Module**

PowerShell module for CyberArk Privileged Account Security Web Services REST API.

Exposes all methods of the web service for CyberArk v9.6

----------
## Getting Started
NOTE: Initial Release. 

 - Work In Progress
 - All Testing Appreciated

### Prerequisites

Requires Powershell v3 (minimum)
CyberArk PAS v9.6 (or higher) REST API/Web Service
If using a CyberArk REST API/Web Service lower than v9.6, not all functions will work (some will - version dependant).

### Install & Use

Save the Module to your powershell modules folder of choice.

Import the module:

```
Import-Module psPAS
```

Logon to the Vault:

```
$token = New-PASSession -Credential $VaultCredentials -BaseURI https:\\PVWA_URL
```

The New-PASSession output contains:

 - The CyberArk Authentication Token
	 - Required for all subsequent calls to the API
 - A WebSession object
	 - Useful if the API sits behind a loadbalancer
 - The specified PVWA URL
	 - For convenience

This output can be piped into all other functions:
```
$token | Get-PASAccount -Keywords root -Safe UNIX

$token | Add-PASSafe -SafeName psPAS -ManagingCPM PasswordManager -NumberOfVersionsRetention 10
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
