# psPAS

## **CyberArk PowerShell Module**

PowerShell module for CyberArk Privileged Account Security Web Services REST API.

Exposes the available methods of the web service for CyberArk PAS up to v9.9.

----------

## Latest Update

- Native error messages & CyberArk error codes now included in error output.
- Added examples to all functions help text.
- Hardcoded value for PVWA Virtual Directory removed:
  - You can now specify your own value if the PVWA is published under a Virtual Directory named something other than "PasswordVault".
- Use of TLS 1.2 Security Protocol enforced for Web Requests.
- [Pipeline Support](#Pipeline_Support), where possible, across all functions:
  - All output objects now also contain the URL value, Session Token & WebSession information to pass to subsequent functions on the pipeline.
  - Wherever possible ValueFromPipelinebyPropertyName is set to $true, allowing chained commands like ```Get-PASUser | Set-PASUser```

## Getting Started

LDAP, CyberArk, RADIUS & Shared authentication can be used from CyberArk version 9.7 onwards.

For CyberArk 9.6 and below, only CyberArk authentication is supported.

SAML authentication for the CyberArk REST API is supported from version 9.7, but the psPAS functions to support this are still in development (i.e. not working & not tested). The work in progress functions are included in the module - if you are using SAML authentication, have the insight, and are interested in helping getting this to work, let me know.

### Prerequisites

- Requires Powershell v3 (minimum)
- CyberArk PAS REST API/Web Service
  - Your version of CyberArk determines the supported functions.
  - Check the [compatibility table](#CyberArk_Version_Compatibility) to determine what you can use.
- A user with which to authenticate, with appropriate Vault/Safe permissions.

### Install & Use

Save the Module to your powershell modules folder of choice.

Find your local PowerShell module paths with the following command:

```powershell

$env:PSModulePath

```

The name of the folder for the module should be "psPAS".

Import the module:

```powershell

Import-Module psPAS

```

Discover Commands:

```powershell

Get-Command -Module psPAS

```

Logon to the CyberArk Vault:

```powershell

$token = New-PASSession -Credential $VaultCredentials -BaseURI https://PVWA_URL

```

The New-PASSession output contains:

- The CyberArk Authentication Token
  - Required for all subsequent calls to the API
- A WebSession object
  - Useful if the API sits behind a loadbalancer
- The specified PVWA URL
  - For convenience
- The specified connection Number

This output can be piped into all other functions to provide the values for the parameters required to communicate with the Web Service:

```powershell

$token | Get-PASAccount -Keywords root -Safe UNIX

$token | Add-PASSafe -SafeName psPAS -ManagingCPM PasswordManager -NumberOfVersionsRetention 10

```

A CyberArk authentication token, and the URL of the Web Service, MUST be provided to each function (with the exception of Logon via New-PASSession).

```powershell

Get-PASUser -UserName psPASUser -sessionToken $token.sessionToken -baseURI "https://PVWA"

```

### <a id="Pipeline_Support"></a>Working with the Pipeline

The required values from the New-PASSession function are passed along the pipeline as properties of the output of subsequent psPAS functions, allowing you to create chains of commands.

If the output of one function contains the mandatory parameters of another function, which accepts values by property names, you can utilise the pipeline.

Do exercise caution, and test/validate any pipeline operations in a Non-Prod Lab first.

Examples below:

- Logon, find and update a user, then logoff:

```powershell

Get-Credential |
New-PASSession -BaseURI http://PVWA_URL | Get-PASAccount pete |
Set-PASAccount -Address 10.10.10.10 -Name Pete-psPAS-Test -UserName pspete |
Close-PASSession

```

- Activate a Suspended CyberArk User:

```powershell

$cred | New-PASSession -BaseURI https://cyberark | Get-PASUser PebKac | Unblock-PASUser -Suspended $false

```

- Add a User to a group

```powershell

$token | Get-PASUser -UserName User | Add-PASGroupMember Group

```

- Update Version Retention on all Safes:

```powershell

$token | Get-PASSafe | Set-PASSafe -NumberOfVersionsRetention 25

```

- Add an authentication method to an application

```powershell

$token | Get-PASApplication -AppID testapp |
Add-PASApplicationAuthenticationMethod -AuthType machineAddress -AuthValue "F.Q.D.N"

```

- Remove an authentication method, which matches a condition, from an application

```powershell

$token | Get-PASApplication -AppID testapp |
Get-PASApplicationAuthenticationMethods |
Where-Object{$_.AuthValue -eq "F.Q.D.N"} |
Remove-PASApplicationAuthenticationMethod

```

- Delete all authentication methods of an application (... maybe don't try this one in Production...):

```powershell

$token | Get-PASApplication -AppID testapp |
Get-PASApplicationAuthenticationMethods |
Remove-PASApplicationAuthenticationMethod

```

## Author

- **Pete Maan** - [pspete](https://github.com/pspete)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Contributing

Any and all contributions to this project are appreciated.

The SAML authentication capability needs some attention.

See the [CONTRIBUTING.md](CONTRIBUTING.md) for a few more details.

## Acknowledgements

Hat Tips:

**Warren Frame** ([RamblingCookieMonster](https://github.com/RamblingCookieMonster)) for    the borrowed    [Add-ObjectDetail.ps1](https://github.com/RamblingCookieMonster/PowerShell/blob/master/Add-ObjectDetail.ps1)    &    [New-DynamicParam.ps1](https://github.com/RamblingCookieMonster/PowerShell/blob/master/New-DynamicParam.ps1)    helper functions.

**Joe Garcia** ([infamousjoeg](https://github.com/infamousjoeg)) for the unofficial API documentation

Chapeau!

## <a id="CyberArk_Version_Compatibility"></a>CyberArk Version Compatibility

|CyberArk Version|Supported psPAS Module Functions|
|:---:|:---|
|9.0|`New-PASSession` (CyberArk Authentication Only)<br/>`Close-PASSession`<br/>`Add-PASAccount`<br/>`Get-PASPolicyACL`<br/>`Add-PASPolicyACL`<br/>`Remove-PASPolicyACL`<br/>`Get-PASAccountACL`<br/>`Add-PASAccountACL`<br/>`Remove-PASAccountACL`<br/><br/>|
|9.1|All Previous Functions, and:<br/>`Get-PASApplications`<br/>`Get-PASApplication`<br/>`Add-PASApplication`<br/>`Get-PASApplicationAuthenticationMethods`<br/>`Add-PASApplicationAuthenticationMethod`<br/>`Remove-PASApplication`<br/>`Remove-PASApplicationAuthenticationMethod`<br/><br/>|
|9.2|All Previous Functions, and:<br/>`Add-PASSafe`<br/><br/>|
|9.3|All Previous Functions, and:<br/>`Get-PASAccount`<br/>`Remove-PASAccount`<br/>`Start-PASCredChange`<br/>`Set-PASSafe`<br/>`Remove-PASSafe`<br/>`Add-PASSafeMember`<br/>`Set-PASSafeMember`<br/>`Remove-PASSafeMember`<br/><br/>|
|9.4|All Previous Functions<br/><br/>|
|9.5|All Previous Functions, and:<br/>`Set-PASAccount`<br/><br/>|
|9.6|All Previous Functions, and:<br/>`Add-PASPublicSSHKey`<br/>`Get-PASPublicSSHKey`<br/>`Remove-PASPublicSSHKey`<br/><br/>|
|9.7|All Previous Functions, and:<br/>`New-PASSession` (CyberArk, LDAP, RADIUS Authentication)<br/>`New-PASSAMLSession` (*In Development)<br/>`Close-PASSAMLSession` (*In Development)<br/>`New-PASSharedSession`<br/>`Close-PASSharedSession`<br/>`Get-PASServerWebService`<br/>`Get-PASSafeShareLogo`<br/>`Get-PASServer`<br/>`New-PASUser`<br/>`Set-PASUser`<br/>`Remove-PASUser`<br/>`Get-PASLoggedOnUser`<br/>`Get-PASUser`<br/>`Unblock-PASUser`<br/>`Add-PASGroupMember`<br/>`Add-PASPendingAccount`<br/>`Get-PASAccountCredentials`<br/>`Start-PASCredVerify`<br/>`Get-PASAccountActivity`<br/>`Get-PASSafe`<br/>`Get-PASSafeMembers`<br/><br/>|
|9.8|All Previous Functions, and:<br/>`New-PASOnboardingRule`<br/>`Remove-PASOnboardingRule`<br/>`Get-PASOnboardingRule`<br/><br/>|
|9.9|All Previous Functions, and:<br/>`New-PASAccountGroup`<br/>`Add-PASAccountGroupMember`<br/><br/>|