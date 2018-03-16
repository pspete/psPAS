# psPAS

[![Build status](https://ci.appveyor.com/api/projects/status/j45hbplm4dq4vfye/branch/master?svg=true)](https://ci.appveyor.com/project/pspete/pspas/branch/master)
[![AppVeyor tests](https://img.shields.io/appveyor/tests/pspete/pspas.svg)](https://ci.appveyor.com/project/pspete/pspas)
[![Coverage Status](https://coveralls.io/repos/github/pspete/psPAS/badge.svg)](https://coveralls.io/github/pspete/psPAS)
[![PowerShell Gallery](https://img.shields.io/powershellgallery/v/psPAS.svg)](https://www.powershellgallery.com/packages/psPAS)
[![license](https://img.shields.io/github/license/pspete/psPAS.svg)](https://github.com/pspete/psPAS/blob/master/LICENSE.md)

## **Table of Contents**

- [psPAS](#pspas)
  - [CyberArk PowerShell Module](#cyberark-powershell-module)
  - [Latest Updates](#latest-updates)
  - [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Install and Use](#install-and-use)
    - [Working with the Pipeline](#working-with-the-pipeline)
  - [Author](#author)
  - [License](#license)
  - [Contributing](#contributing)
  - [Acknowledgements](#acknowledgements)
  - [CyberArk Version Compatibility](#cyberark-version-compatibility)

## **CyberArk PowerShell Module**

PowerShell module for CyberArk Privileged Account Security Web Services REST API.

Exposes the available methods of the web service for CyberArk PAS up to v10.2.

----------

## Latest Updates

- Module updated to cover CyberArk 10.2 API features:
  - `New-PASOnboardingRule` has added parameters available from 10.2 onwards. The 9.8 & 10.2 parameters are configured as separate parametersets.
  - `Get-PASOnboardingRule` has a new parameter added, allowing search of Onboarding rules by name in version 10.2
  - `Import-PASPlatform` function added, allowing import of CPM Platforms
  - `Get-PASPSMConnectionParameters` updated to facilitate return of HTML5 connection data when PSMGW is configured.
  - `Suspend-PASPSMSession` & `Resume-PASPSMSession` functions added, expanding on the automatic mitigation capability for PSM Sessions.

- Attained 100% Code Coverage in the Tests for the module.

- Bug Fixes:
  - ```Add-PASAccountGroupMember``` was not sending AccountID with request, now fixed.
  - ```New-PASAccountGroup``` fixed an incorrect parameter name (_GroupPlatformID_).
  - ```New-PASSAMLSession``` - authentication token was not being sent in request header, now fixed.
  - ```Get-PASOnboardingRule```, ```New-PASOnboardingRule``` & ```Remove-PASOnboardingRule```, parameters updated to allow specification of alternate PVWA application name (in-line with the rest of the module's functions).

## Getting Started

### Prerequisites

- Requires Powershell v3 (minimum)
- CyberArk PAS REST API/Web Service
  - Your version of CyberArk determines the supported functions.
  - Check the [compatibility table](#CyberArk_Version_Compatibility) to determine what you can use.
- A user with which to authenticate, with appropriate Vault/Safe permissions.
  - LDAP, CyberArk, RADIUS & Shared authentication can be used from CyberArk version 9.7 onwards.
  - For CyberArk 9.6 and below, only CyberArk authentication is supported.
  - SAML authentication is supported from version 9.7; the psPAS functions to support this are untested.
    - The functions are included in the module - if you are using SAML authentication, and can feedback whether the functions work it would be appreciated.

### Install and Use

This repository contains a folder named ```psPAS```.

The folder needs to be copied to one of your PowerShell Module Directories using one of the methods below.

Find your PowerShell Module Paths with the following command:

```powershell

$env:PSModulePath.split(';')

```

#### Option 1: Install from PowerShell Gallery

PowerShell 5.0 or above & Administrator rights are required.

To download the module from the [PowerShell Gallery](https://www.powershellgallery.com/packages/psPAS/), from an elevated PowerShell prompt, run:

````Install-Module -Name psPAS -Scope CurrentUser````

#### Option 2: Manual Install

Download the [```master branch```](https://github.com/pspete/psPAS/tree/master)

Copy the ```psPAS``` folder to your "Powershell Modules" directory of choice.

#### Verification

Validate Module Exists:

```powershell

Get-Module -ListAvailable psPAS

```

Import the module:

```powershell

Import-Module psPAS

```

#### Useful Commands

Discover Module Commands:

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

A CyberArk authentication token, and the URL of the Web Service, MUST be provided to each function (with the exception of Logon via `New-PASSession`).

```powershell

Get-PASUser -UserName psPASUser -sessionToken $token.sessionToken -baseURI "https://PVWA"

```

### <a id="Pipeline_Support"></a>Working with the Pipeline

The required values from the `New-PASSession` function are passed along the pipeline as properties of the output of subsequent psPAS functions, allowing you to create chains of commands.

If the output of one function contains the mandatory parameters of another function, which accepts values by property names, you can utilise the pipeline.

Do exercise caution, and test/validate any pipeline operations in a Non-Prod Lab first.

Examples below:

- Logon, find and update a user, then logoff:

```powershell

Get-Credential |
New-PASSession -BaseURI https://PVWA_URL | Get-PASAccount pete |
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
Get-PASApplicationAuthenticationMethod |
Where-Object{$_.AuthValue -eq "F.Q.D.N"} |
Remove-PASApplicationAuthenticationMethod

```

- Delete all authentication methods of an application (... maybe don't try this one in Production...):

```powershell

$token | Get-PASApplication -AppID testapp |
Get-PASApplicationAuthenticationMethod |
Remove-PASApplicationAuthenticationMethod

```

## Author

- **Pete Maan** - [pspete](https://github.com/pspete)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Contributing

Any and all contributions to this project are appreciated.

The SAML authentication capability needs testing, no federation service is available to me to confirm that the functionality works as required...

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
|9.1|All Previous Functions, and:<br/>`Get-PASApplication`<br/>`Add-PASApplication`<br/>`Get-PASApplicationAuthenticationMethod`<br/>`Add-PASApplicationAuthenticationMethod`<br/>`Remove-PASApplication`<br/>`Remove-PASApplicationAuthenticationMethod`<br/><br/>|
|9.2|All Previous Functions, and:<br/>`Add-PASSafe`<br/><br/>|
|9.3|All Previous Functions, and:<br/>`Get-PASAccount`<br/>`Remove-PASAccount`<br/>`Start-PASCredChange`<br/>`Set-PASSafe`<br/>`Remove-PASSafe`<br/>`Add-PASSafeMember`<br/>`Set-PASSafeMember`<br/>`Remove-PASSafeMember`<br/><br/>|
|9.4|All Previous Functions<br/><br/>|
|9.5|All Previous Functions, and:<br/>`Set-PASAccount`<br/><br/>|
|9.6|All Previous Functions, and:<br/>`Add-PASPublicSSHKey`<br/>`Get-PASPublicSSHKey`<br/>`Remove-PASPublicSSHKey`<br/><br/>|
|9.7|All Previous Functions, and:<br/>`New-PASSession` (CyberArk, LDAP, RADIUS Authentication)<br/>`New-PASSAMLSession`<br/>`Close-PASSAMLSession` <br/>`New-PASSharedSession`<br/>`Close-PASSharedSession`<br/>`Get-PASServerWebService`<br/>`Get-PASSafeShareLogo`<br/>`Get-PASServer`<br/>`New-PASUser`<br/>`Set-PASUser`<br/>`Remove-PASUser`<br/>`Get-PASLoggedOnUser`<br/>`Get-PASUser`<br/>`Unblock-PASUser`<br/>`Add-PASGroupMember`<br/>`Add-PASPendingAccount`<br/>`Get-PASAccountPassword` (_Limited Functionality_)<br/>`Start-PASCredVerify`<br/>`Get-PASAccountActivity`<br/>`Get-PASSafe`<br/>`Get-PASSafeMember`<br/><br/>|
|9.8|All Previous Functions, and:<br/>`New-PASOnboardingRule` (_Limited Functionality_)<br/>`Remove-PASOnboardingRule`<br/>`Get-PASOnboardingRule` (_Limited Functionality_)<br/><br/>|
|9.9|All Previous Functions|
|9.9.5|All Previous Functions, and:<br/>`New-PASAccountGroup`<br/>`Add-PASAccountGroupMember`<br/><br/>|
|9.10|All Previous Functions, and:<br/>`Invoke-PASCredChange` (_Limited Functionality_)<br/>`Invoke-PASCredVerify`<br/>`Invoke-PASCredReconcile`<br/>`Unlock-PASAccount`<br/>`Get-PASAccountGroup`<br/>`Get-PASAccountGroupMember`<br/>`Remove-PASAccountGroupMember`<br/>`New-PASRequest`<br/>`Get-PASRequest`<br/>`Get-PASRequestDetail`<br/>`Remove-PASRequest`<br/>`Approve-PASRequest`<br/>`Deny-PASRequest`<br/>`Get-PASPlatform`<br/>`Get-PASRecording`<br/>`Get-PASLiveSession`<br/>`Get-PASPSMConnectionParameter` (_Limited Functionality_)<br/><br/>|
|10.1|All Previous Functions, and:<br/>`Invoke-PASCredChange` (_Updated for 10.1_)<br/>`Get-PASAccountPassword` (_Updated for 10.1_)<br/>`Stop-PASPSMSession`<br/>`Get-PASComponentSummary`<br/>`Get-PASComponentDetail`<br/><br/>|
|10.2|All Previous Functions, and:<br/>`Get-PASPSMConnectionParameters` (_Updated for 10.2_)<br/>`New-PASOnboardingRule` (_Updated for 10.2_)<br/>`Get-PASOnboardingRule` (_Updated for 10.2_)<br/>`Suspend-PASPSMSession`<br/>`Resume-PASPSMSession`<br/>`Import-PASPSMPlatform`<br/><br/>|
