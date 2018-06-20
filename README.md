# psPAS

## **PowerShell Module for CyberArk Privileged Account Security**

Use PowerShell to manage CyberArk via the Web Services REST API.

Contains all published methods of the API up to CyberArk v10.3.

----------

### Module Status

&nbsp;|&nbsp;
-----|-----
PowerShell Gallery | [![PowerShell Gallery](https://img.shields.io/powershellgallery/v/psPAS.svg)](https://www.powershellgallery.com/packages/psPAS)
Master Branch Build | [![Build status](https://ci.appveyor.com/api/projects/status/j45hbplm4dq4vfye/branch/master?svg=true)](https://ci.appveyor.com/project/pspete/pspas/branch/master)
Latest Build (all branches) | [![AppVeyor tests](https://img.shields.io/appveyor/tests/pspete/pspas.svg)](https://ci.appveyor.com/project/pspete/pspas)
Code Coverage | [![Coverage Status](https://coveralls.io/repos/github/pspete/psPAS/badge.svg)](https://coveralls.io/github/pspete/psPAS)
License | [![license](https://img.shields.io/github/license/pspete/psPAS.svg)](https://github.com/pspete/psPAS/blob/master/LICENSE.md)

----------

- [psPAS](#pspas)
  - [Introduction](#powershell-module-for-cyberark-privileged-account-security)
    - [Status](#status-information)
  - [Usage](#usage)
  - [Module Functions](#module-functions)
  - [Installation](#installation)
    - [Prerequisites](#prerequisites)
    - [Install Options](#install-options)
    - [Verification](#verification)
  - [Changelog](#changelog)
  - [Author](#author)
  - [License](#license)
  - [Contributing](#contributing)
  - [Acknowledgements](#acknowledgements)

## Usage

It all starts with a **Logon**

![New-PASSession](/media/New-PASSession.png)

The output of _`New-PASSession`_ can be used as input for subsequent commands.

![Logon](/media/logon.gif)

In the below examples, the **`$token`** variable contains the values for the</br>
_`sessionToken`_ & _`baseURI`_ parameters, which are mandatory for all functions.

![Get-PASAccount](/media/Get-PASAccount.png)

Use the pipeline to allow multiple successive commands to be executed.

![Example Pipeline](/media/ExamplePipeline.png)

**Save time on repetitive support tasks...**

Unlock Users:

![Unblock-PASUser](/media/PebKac.png)

![Problem Exists Between Keyboard and Chair](/media/pebkac.gif)

Add Users as Group Members:

![Add-PASGroupMember](/media/Add-PASGroupMember.png)

Streamline your safe creation process...

![Add-PASSafe](/media/Add-PASSafe.png)

![Safe Creation](/media/safes.gif)

Achieve consistent safe permissions...

![Add-PASSafeMember](/media/Add-PASSafeMember.png)

Enact changes across multiple safes, with speed...

![Set-PASSafeMember](/media/Set-PASSafeMember.png)

![Set-PASSafe](/media/Set-PASSafe.png)

![Set Safe Permissions](media/permissions.gif)

Onboard a User Account...

![Add-PASAccount](/media/Add-PASAccount.png)

Onboard User Accounts, in bulk...

![Bulk Add Accounts](/media/BulkAddAccount.png)

Check-In locked accounts...

![Unlock-PASAccount](/media/Unlock-PASAccount.png)

Make changes to multiple managed accounts...

![Set-PASAccount](/media/Set-PASAccount.png)

![Edit Accounts](media/accounts.gif)

See the module in action in the below "_CyberArk REST API: From Start-to-Finish_" video:

[![YouTube Demo](media/youtube.png)](https://www.youtube.com/watch?v=yZinhjsuV1I)

## <a id="CyberArk_Version_Compatibility"></a> Module Functions

Your version of CyberArk determines which functions of psPAS will be supported.

Check the below table to determine what is available for you to use.

The CyberArk Version listed is the minimum required to use the function.

The module will attempt to confirm that your version of CyberArk meets the minimum

version requirement (if you are using version 9.7+, and the function being invoked

requires version 9.8+).

**Function Name**|**Description**|**CyberArk</br>Version**</br>
-----|-----|-----:
[`New-PASSession`](/psPAS/Functions/Authentication/New-PASSession.ps1)|Authenticates a user </br>to CyberArk Vault|**9.0**
[`Close-PASSession`](/psPAS/Functions/Authentication/Close-PASSession.ps1)|Logoff from CyberArk </br>Vault.|**9.0**
[`New-PASSAMLSession`](/psPAS/Functions/Authentication/New-PASSAMLSession.ps1)|Authenticates a </br>user to CyberArk </br>Vault using SAML|**9.7**
[`Close-PASSAMLSession`](/psPAS/Functions/Authentication/Close-PASSAMLSession.ps1)|Logoff from CyberArk </br>Vault SAML Session.|**9.7**
[`New-PASSharedSession`](/psPAS/Functions/Authentication/New-PASSharedSession.ps1)|Authenticates a </br>user to CyberArk Vault.|**9.7**
[`Close-PASSharedSession`](/psPAS/Functions/Authentication/Close-PASSharedSession.ps1)|Logoff from CyberArk </br>Vault shared user.|**9.7**
[`Add-PASPublicSSHKey`](/psPAS/Functions/Authentication/Add-PASPublicSSHKey.ps1)|Adds an authorised </br>public SSH key for a </br>specific user in the </br>Vault.|**9.6**
[`Get-PASPublicSSHKey`](/psPAS/Functions/Authentication/Get-PASPublicSSHKey.ps1)|Retrieves a user's </br>SSH Keys.|**9.6**
[`Remove-PASPublicSSHKey`](/psPAS/Functions/Authentication/Remove-PASPublicSSHKey.ps1)|Deletes a specific </br>Public SSH Key from </br>a specific vault user|**9.6**
[`Add-PASAccountACL`](/psPAS/Functions/AccountACL/Add-PASAccountACL.ps1)|Adds a new privileged </br>command rule to an </br>account.|**9.0**
[`Get-PASAccountACL`](/psPAS/Functions/AccountACL/Get-PASAccountACL.ps1)|Lists privileged </br>commands rule for an </br>account|**9.0**
[`Remove-PASAccountACL`](/psPAS/Functions/AccountACL/Remove-PASAccountACL.ps1)|Deletes privileged </br>commands rule from </br>an account|**9.0**
[`Add-PASAccountGroupMember`](/psPAS/Functions/AccountGroups/Add-PASAccountGroupMember.ps1)|Adds an </br>account as a member </br>of an account group.|**9.95**
[`Get-PASAccountGroup`](/psPAS/Functions/AccountGroups/Get-PASAccountGroup.ps1)|Returns all the </br>account groups in a </br>specific Safe.|**9.10**
[`Get-PASAccountGroupMember`](/psPAS/Functions/AccountGroups/Get-PASAccountGroupMember.ps1)|Returns all </br>the members of a </br>specific account group.|**9.10**
[`New-PASAccountGroup`](/psPAS/Functions/AccountGroups/New-PASAccountGroup.ps1)|Adds a new account </br>group to the Vault|**9.95**
[`Remove-PASAccountGroupMember`](/psPAS/Functions/AccountGroups/Remove-PASAccountGroupMember.ps1)|Deletes a member </br>of an account group|**9.10**
[`Add-PASAccount`](/psPAS/Functions/Accounts/Add-PASAccount.ps1)|Adds a new privileged </br>account to the Vault|**9.0**
[`Add-PASPendingAccount`](/psPAS/Functions/Accounts/Add-PASPendingAccount.ps1)|Adds discovered </br>account or SSH key as </br>a pending account in </br>the accounts feed.|**9.7**
[`Get-PASAccount`](/psPAS/Functions/Accounts/Get-PASAccount.ps1)|Returns information </br>about an account.|**9.3**
[`Get-PASAccountActivity`](/psPAS/Functions/Accounts/Get-PASAccountActivity.ps1)|Returns activities </br>for an account.|**9.7**
[`Get-PASAccountPassword`](/psPAS/Functions/Accounts/Get-PASAccountPassword.ps1)|Returns password </br>for an account.|**9.7**
[`Invoke-PASCredChange`](/psPAS/Functions/Accounts/Invoke-PASCredChange.ps1)|Initiate CPM password </br>change to new random </br>or specified value.|**9.10**
[`Invoke-PASCredReconcile`](/psPAS/Functions/Accounts/Invoke-PASCredReconcile.ps1)|Initiates password </br>reconcile by the CPM </br>to a new random password.|**9.10**
[`Invoke-PASCredVerify`](/psPAS/Functions/Accounts/Invoke-PASCredVerify.ps1)|Marks account for </br>immediate verification </br>by the CPM.|**9.10**
[`Remove-PASAccount`](/psPAS/Functions/Accounts/Remove-PASAccount.ps1)|Deletes an account|**9.3**
[`Set-PASAccount`](/psPAS/Functions/Accounts/Set-PASAccount.ps1)|Updates an existing </br>accounts details.|**9.5**
[`Start-PASCredChange`](/psPAS/Functions/Accounts/Start-PASCredChange.ps1)|Initiates an immediate </br>password change by the </br>CPM to a new random </br>password.|**9.3**
[`Start-PASCredVerify`](/psPAS/Functions/Accounts/Start-PASCredVerify.ps1)|Marks account for </br>immediate verification </br>by the CPM|**9.7**
[`Unlock-PASAccount`](/psPAS/Functions/Accounts/Unlock-PASAccount.ps1)|Checks in an exclusive </br>account in to the Vault.|**9.10**
[`Add-PASApplication`](/psPAS/Functions/Applications/Add-PASApplication.ps1)|Adds a new application </br>to the Vault|**9.1**
[`Add-PASApplicationAuthenticationMethod`](/psPAS/Functions/Applications/Add-PASApplicationAuthenticationMethod.ps1)|Adds an authentication </br>method to an application.|**9.1**
[`Get-PASApplication`](/psPAS/Functions/Applications/Get-PASApplication.ps1)|Returns details of </br>applications in the Vault|**9.1**
[`Get-PASApplicationAuthenticationMethod`](/psPAS/Functions/Applications/Get-PASApplicationAuthenticationMethod.ps1)|Returns information about </br>all of the authentication </br>methods of a specific </br>application.|**9.1**
[`Remove-PASApplication`](/psPAS/Functions/Applications/Remove-PASApplication.ps1)|Deletes an application|**9.1**
[`Remove-PASApplicationAuthenticationMethod`](/psPAS/Functions/Applications/`Remove-PASApplicationAuthenticationMethod.ps1)|Deletes an authentication </br>method from an application|**9.1**
[`Import-PASConnectionComponent`](/psPAS/Functions/Connections/Import-PASConnectionComponent.ps1)|Imports a </br>Connection Component|**10.3**
[`Get-PASPSMConnectionParameter`](/psPAS/Functions/Connections/Get-PASPSMConnectionParameter.ps1)|Get required parameters to </br>connect through PSM|**9.10**
[`Get-PASPSMRecording`](/psPAS/Functions/Monitoring/Get-PASPSMRecording.ps1)|Get details of PSM </br>Recording|**9.10**
[`Get-PASPSMSession`](/psPAS/Functions/Monitoring/Get-PASPSMSession.ps1)|Get details of Live PSM </br>Sessions|**9.10**
[`Resume-PASPSMSession`](/psPAS/Functions/Monitoring/Resume-PASPSMSession.ps1)|Resumes a Suspended PSM </br>Session.|**10.2**
[`Stop-PASPSMSession`](/psPAS/Functions/Monitoring/Stop-PASPSMSession.ps1)|Terminates a Live PSM </br>Session.|**10.1**
[`Suspend-PASPSMSession`](/psPAS/Functions/Monitoring/Suspend-PASPSMSession.ps1)|Suspends a Live PSM </br>Session.|**10.2**
[`Get-PASOnboardingRule`](/psPAS/Functions/OnboardingRules/Get-PASOnboardingRule.ps1)|Gets all automatic </br>on-boarding rules|**9.7**
[`New-PASOnboardingRule`](/psPAS/Functions/OnboardingRules/New-PASOnboardingRule.ps1)|Adds a new on-boarding </br>rule to the Vault|**9.7**
[`Remove-PASOnboardingRule`](/psPAS/Functions/OnboardingRules/Remove-PASOnboardingRule.ps1)|Deletes an automatic </br>on-boarding rule|**9.7**
[`Get-PASPlatform`](/psPAS/Functions/Platforms/Get-PASPlatform.ps1)|Retrieves details of a </br>specified platform from </br>the Vault.|**9.10**
[`Import-PASPlatform`](/psPAS/Functions/Platforms/Import-PASPlatform.ps1)|Import a new platform|**10.2**
[`Add-PASPolicyACL`](/psPAS/Functions/PolicyACL/Add-PASPolicyACL.ps1)|Adds a new privileged </br>command rule|**9.0**
[`Get-PASPolicyACL`](/psPAS/Functions/PolicyACL/Get-PASPolicyACL.ps1)|Lists OPM Rules for </br>a policy|**9.0**
[`Remove-PASPolicyACL`](/psPAS/Functions/PolicyACL/Remove-PASPolicyACL.ps1)|Delete all privileged </br>commands on policy|**9.0**
[`Approve-PASRequest`](/psPAS/Functions/Requests/Approve-PASRequest.ps1)|Confirm a single request|**9.10**
[`Deny-PASRequest`](/psPAS/Functions/Requests/Deny-PASRequest.ps1)|Reject a single request|**9.10**
[`Get-PASRequest`](/psPAS/Functions/Requests/Get-PASRequest.ps1)|List requests|**9.10**
[`Get-PASRequestDetail`](/psPAS/Functions/Requests/Get-PASRequestDetail.ps1)|Get request details|**9.10**
[`New-PASRequest`](/psPAS/Functions/Requests/New-PASRequest.ps1)|Creates an access request </br>for a specific account|**9.10**
[`Remove-PASRequest`](/psPAS/Functions/Requests/Remove-PASRequest.ps1)|Deletes a request from </br>the Vault|**9.10**
[`Add-PASSafeMember`](/psPAS/Functions/SafeMembers/Add-PASSafeMember.ps1)|Adds a Safe Member to </br>a safe|**9.3**
[`Get-PASSafeMember`](/psPAS/Functions/SafeMembers/Get-PASSafeMember.ps1)|Lists the members of a </br>Safe|**9.7**
[`Remove-PASSafeMember`](/psPAS/Functions/SafeMembers/Remove-PASSafeMember.ps1)|Removes a member from </br>a safe|**9.3**
[`Set-PASSafeMember`](/psPAS/Functions/SafeMembers/Set-PASSafeMember.ps1)|Updates a Safe Member's </br>Permissions|**9.3**
[`Add-PASSafe`](/psPAS/Functions/Safes/Add-PASSafe.ps1)|Adds a new safe to the </br>Vault|**9.2**
[`Get-PASSafe`](/psPAS/Functions/Safes/Get-PASSafe.ps1)|Returns safe details </br>from the vault.|**9.7**
[`Remove-PASSafe`](/psPAS/Functions/Safes/Remove-PASSafe.ps1)|Deletes a safe from the </br>Vault|**9.3**
[`Set-PASSafe`](/psPAS/Functions/Safes/Set-PASSafe.ps1)|Updates a safe in the </br>Vault|**9.3**
[`Get-PASSafeShareLogo`](/psPAS/Functions/ServerWebServices/Get-PASSafeShareLogo.ps1)|Returns details of </br>SafeShare Logo|**9.7**
[`Get-PASServer`](/psPAS/Functions/ServerWebServices/Get-PASServer.ps1)|Returns details of the </br>Web Service Server|**9.7**
[`Get-PASServerWebService`](/psPAS/Functions/ServerWebServices/Get-PASServerWebService.ps1)|Returns details </br>of the Web Service|**9.7**
[`Get-PASComponentDetail`](/psPAS/Functions/SystemHealth/Get-PASComponentDetail.ps1)|Returns details & health </br>information about CyberArk </br>component instances.|**10.1**
[`Get-PASComponentSummary`](/psPAS/Functions/SystemHealth/Get-PASComponentSummary.ps1)|Returns consolidated </br>information about </br>CyberArk Components.|**10.1**
[`Add-PASGroupMember`](/psPAS/Functions/User/Add-PASGroupMember.ps1)|Adds a vault user as </br>a group member|**9.7**
[`Get-PASLoggedOnUser`](/psPAS/Functions/User/Get-PASLoggedOnUser.ps1)|Returns details of </br>the logged on user|**9.7**
[`Get-PASUser`](/psPAS/Functions/User/New-PASSession.ps1)|Returns details of a user|**9.7**
[`New-PASUser`](/psPAS/Functions/User/New-PASUser.ps1)|Creates a new vault user|**9.7**
[`Remove-PASUser`](/psPAS/Functions/User/Remove-PASUser`.ps1)|Deletes a vault user|**9.7**
[`Set-PASUser`](/psPAS/Functions/User/Set-PASUser`.ps1)|Updates a vault user|**9.7**
[`Unblock-PASUser`](/psPAS/Functions/User/Unblock-PASUser`.ps1)|Activates a suspended user|**9.7**

## Installation

### Prerequisites

- Requires Powershell v3 (minimum)
- CyberArk PAS REST API/Web Service
- A user with which to authenticate, with appropriate Vault/Safe permissions.

### Install Options

This repository contains a folder named ```psPAS```.

The folder needs to be copied to one of your PowerShell Module Directories.

Use one of the following methods:

#### Option 1: Install from PowerShell Gallery

PowerShell 5.0 or above & Administrator rights are required.

To download the module from the [PowerShell Gallery](https://www.powershellgallery.com/packages/psPAS/), </br>
from an elevated PowerShell prompt, run:

````Install-Module -Name psPAS -Scope CurrentUser````

#### Option 2: Manual Install

Find your PowerShell Module Paths with the following command:

```powershell

$env:PSModulePath.split(';')

```

[Download the ```master branch```](https://github.com/pspete/psPAS/archive/master.zip)

Extract the archive

Copy the ```psPAS``` folder to your "Powershell Modules" directory of choice.

#### Verification

Validate Module Exists on your local machine:

```powershell

Get-Module -ListAvailable psPAS

```

Import the module:

```powershell

Import-Module psPAS

```

List Module Commands:

```powershell

Get-Command -Module psPAS

```

Get detailed information on specific commands:

```powershell

Get-Help Add-PASUser -Full

```

## Changelog

All notable changes to this project will be documented in the [Changelog](CHANGELOG.md)

## Author

- **Pete Maan** - [pspete](https://github.com/pspete)

## License

This project is [licensed under the MIT License](LICENSE.md).

## Contributing

Any and all contributions to this project are appreciated.

The SAML authentication capability needs testing, no federation service is</br>
available to me to confirm that the functionality works as required...

See the [CONTRIBUTING.md](CONTRIBUTING.md) for a few more details.

## Acknowledgements

Hat Tips:

**Warren Frame**
([RamblingCookieMonster](https://github.com/RamblingCookieMonster)) for the borrowed [Add-ObjectDetail.ps1](https://github.com/RamblingCookieMonster/PowerShell/blob/master/Add-ObjectDetail.ps1)
& </br>[New-DynamicParam.ps1](https://github.com/RamblingCookieMonster/PowerShell/blob/master/New-DynamicParam.ps1)
helper functions.

**Joe Garcia** ([infamousjoeg](https://github.com/infamousjoeg))
for the unofficial API documentation

Chapeau!
