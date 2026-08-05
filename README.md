[![psPAS][]][Docs]

[psPAS]: /docs/assets/images/header_photo.png
[Logo]: /docs/assets/images/shop_banner_symbol.png
[Docs]: https://pspas.pspete.dev

# **psPAS: PowerShell Module for the Idira (CyberArk) API**

**The complete PowerShell interface to Idira (CyberArk) Privileged Access Security** — one consistent, pipeline-native module for Privilege Cloud (SaaS) and Privileged Access Manager Self-Hosted alike.

Full documentation: [https://pspas.pspete.dev](https://pspas.pspete.dev)

---

## Module Status

| Master Branch               | Latest Build               | PowerShell Gallery        | CodeFactor                 | Coverage                     | License                      |
| --------------------------- | -------------------------- | ------------------------- | -------------------------- | ---------------------------- | ---------------------------- |
| [![appveyor][]][av-site]    | [![tests][]][tests-site]   | [![psgallery][]][ps-site] | [![codefactor][]][cf-site] | [![codecov][]][codecov-link] | [![license][]][license-link] |
| [![release][]][github-site] | [![github][]][installlink] | [![downloads][]][ps-site] |                            |                              |                              |

[appveyor]: https://ci.appveyor.com/api/projects/status/j45hbplm4dq4vfye/branch/master?svg=true
[av-site]: https://ci.appveyor.com/project/pspete/pspas/branch/master
[psgallery]: https://img.shields.io/powershellgallery/v/psPAS.svg
[ps-site]: https://www.powershellgallery.com/packages/psPAS
[license]: https://img.shields.io/github/license/pspete/psPAS.svg
[license-link]: https://github.com/pspete/psPAS/blob/master/LICENSE.md
[tests]: https://img.shields.io/appveyor/tests/pspete/pspas.svg
[tests-site]: https://ci.appveyor.com/project/pspete/pspas
[downloads]: https://img.shields.io/powershellgallery/dt/pspas.svg?color=blue
[cf-site]: https://www.codefactor.io/repository/github/pspete/pspas
[codefactor]: https://www.codefactor.io/repository/github/pspete/pspas/badge
[codecov]: https://codecov.io/gh/pspete/psPAS/branch/master/graph/badge.svg
[codecov-link]: https://codecov.io/gh/pspete/psPAS
[github]: https://img.shields.io/github/downloads/pspete/psPAS/total?color=brightgreen
[github-site]: https://github.com/pspete/psPAS/releases/latest
[release]: https://img.shields.io/github/v/release/pspete/psPAS?color=brightgreen
[installlink]: https://github.com/pspete/psPAS#install-options

---

## Why psPAS

- **First-class Privilege Cloud / ISPSS support** — authenticate as an Identity or Service user (via the companion [IdentityCommand](https://github.com/pspete/IdentityCommand) module) and use the same `psPAS` module as self-hosted PVWA. Some commands are Privilege Cloud-only, some self-hosted-only — `psPAS` enforces that automatically instead of leaving you to work it out. See [Authenticate](#authenticate).
- **Complete API coverage** — 234 commands spanning every major area of Idira: Accounts, Safes, Users & Directories, Platforms, Authentication, PSM, Privileged Threat Analytics, Vault Remote Manager, Reports and more. See [psPAS Functions](#pspas-functions).
- **Trusted at scale** — 230,000+ downloads on the PowerShell Gallery and counting (see the live badge above).
- **Built for the PowerShell pipeline, not just the REST API** — commands accept and emit typed objects, so `Get-PASSafe | Get-PASSafeMember` (and much longer chains) just work, instead of you gluing `Invoke-RestMethod` calls and JSON parsing together by hand.
- **Tested, not just written** — every public function ships with a Pester test and is gated by PSScriptAnalyzer in CI; nothing reaches the PowerShell Gallery without passing both.
- **In active use and development since 2017** — regular releases, a maintained [changelog](CHANGELOG.md), and ongoing contributions/sponsorship — see [Acknowledgements](#acknowledgements).

![Logo][Logo]

- [Usage](#usage)
  - [Quick Start](#quick-start)
  - [Authenticate](#authenticate)
  - [Working with the Pipeline](#working-with-the-pipeline)
  - [More Examples](#more-examples)
- [psPAS Functions](#pspas-functions)
- [Installation](#installation)
  - [Prerequisites](#prerequisites)
  - [Install Options](#install-options)
  - [Verification](#verification)
- [Sponsors](#sponsors)
- [Changelog](#changelog)
- [Author](#author)
- [License](#license)
- [Contributing](#contributing)
- [Support](#support)
- [Acknowledgements](#acknowledgements)

## Usage

### Quick Start

```powershell
Install-Module -Name psPAS -Scope CurrentUser

$cred = Get-Credential
New-PASSession -Credential $cred -BaseURI https://pvwa.somedomain.com

Get-PASSafe -search Finance | Get-PASSafeMember

UserName     SafeName      Permissions
--------     --------      -----------
FinanceAdmin FinanceSafe01 @{useAccounts=True; retrieveAccounts=True; listAccounts=True;...

Close-PASSession
```

Everything else in `psPAS` builds on this pattern: authenticate once with `New-PASSession`, then pipe `psPAS` commands together like any other PowerShell objects.

### Authenticate

_Everything begins with a **Logon**:_

To submit a logon request to the Idira API, use the psPAS `New-PASSession` command.

All subsequent operations are carried out by `psPAS` using the input data provided for the `New-PASSession` request (URL, Certificate), as well as data received from the API after successful authentication (Authentication Token, PVWA Version).

Most new Idira deployments today are Privilege Cloud (SaaS), so that's the first option below — self-hosted PVWA is just as fully supported and follows straight after.

#### Privilege Cloud / ISPSS (SaaS)

**Privilege Cloud authentication flows require the pspete `IdentityCommand` module, available from the [Powershell Gallery](https://www.powershellgallery.com/packages/IdentityCommand) & [GitHub](https://github.com/pspete/IdentityCommand).** `psPAS` uses it to handle the ISPSS logon; from there it's the same module used against self-hosted PVWA — some commands are Privilege Cloud-only, some self-hosted-only, and `psPAS` enforces that automatically rather than letting the API reject an unsupported call.

##### Identity User

Provide Identity User credentials and tenant details for authentication to Idira for Privilege Cloud:

```
#using URL
New-PASSession -IdentityTenantURL https://SomeTenantName.id.cyberark.cloud -PrivilegeCloudURL https://SomeTenant.privilegecloud.cyberark.cloud -Credential $Cred -IdentityUser
```

```
#using subdomain
New-PASSession -TenantSubdomain SomeTenantName -Credential $Cred -IdentityUser
```

##### Service User

Provide tenant ID and non-interactive API User credentials for authentication via Idira Identity for Privilege Cloud:

```
New-PASSession -TenantSubdomain YourPrivilegeCloudTenantID -Credential $ServiceUserCreds -ServiceUser
```

Consult the vendor documentation for guidance on setting up a dedicated API Service user for non-interactive API use.

#### Self-Hosted PVWA

##### Local User Authentication

- Use a PowerShell credential object containing a valid vault username and password.

```powershell
$cred = Get-Credential

PowerShell credential request
Enter your credentials.
User: safeadmin
Password for user safeadmin: **********


New-PASSession -Credential $cred -BaseURI https://pvwa.somedomain.com
```

##### LDAP Authentication

- Specify LDAP credentials allowed to authenticate to the vault.

```powershell
$cred = Get-Credential

PowerShell credential request
Enter your credentials.
User: xApprover_1
Password for user xApprover_1: **********


New-PASSession -Credential $cred -BaseURI https://pvwa.somedomain.com -type LDAP

Get-PASLoggedOnUser

UserName    Source UserTypeName AgentUser Expired Disabled Suspended
--------    ------ ------------ --------- ------- -------- ---------
xApprover_1 LDAP   EPVUser      False     False   False    False
```

##### RADIUS Authentication

```powershell
$cred = Get-Credential

PowerShell credential request
Enter your credentials.
User: DuoUser
Password for user DuoUser: **********


New-PASSession -Credential $cred -BaseURI https://pvwa.somedomain.com -type RADIUS -OTP 123456

Get-PASLoggedOnUser

UserName Source UserTypeName AgentUser Expired Disabled Suspended
-------- ------ ------------ --------- ------- -------- ---------
DuoUser  LDAP   EPVUser      False     False   False    False
```

##### SAML Authentication

SAML SSO authentication using IWA and ADFS can be performed

```powershell
New-PASSession -BaseURI $url -SAMLAuth
```

Where IWA SSO is not possible, the [PS-SAML-Interactive](https://github.com/allynl93/PS-SAML-Interactive) module can be used to get the SAMLResponse from an authentication service.

The SAMLResponse received from the IdP is sent to complete saml authentication to the API.

```powershell
import-module -name 'C:\PS-SAML-Interactive.psm1'

$loginURL = 'https://company.okta.com/home/app1/0oa11xddwdzhvlbiZ5d7/aln1k2HsUl5d7'
$baseURL = 'https://pvwa.mycompany.com'

$loginResponse = New-SAMLInteractive -LoginIDP $loginURL

New-PASSession -SAMLAuth -concurrentSession $true -BaseURI $baseURL -SAMLResponse $loginResponse
```

##### Certificate Authentication

- Where PVWA/IIS requires client certificates, 'psPAS' will use any specified certificates for the duration of the session.

PKI Authentication Example:

```powershell
Add-Type -AssemblyName System.Security
# Get Valid Certs
$MyCerts = [System.Security.Cryptography.X509Certificates.X509Certificate2[]](Get-ChildItem Cert:\CurrentUser\My)
# Select Cert
$Cert = [System.Security.Cryptography.X509Certificates.X509Certificate2UI]::SelectFromCollection(
    $MyCerts,
    'Choose a certificate',
    'Choose a certificate',
    'SingleSelection'
) | select -First 1

New-PASSession -Credential $cred -BaseURI $url -type PKI -Certificate $Cert
```

Shared Authentication Example:

```powershell
$Cert = "0E199489C57E666115666D6E9990C2ACABDB6EDB"
New-PASSession -UseSharedAuthentication -BaseURI https://pvwa.somedomain.com -CertificateThumbprint $Cert
```

### Working with the Pipeline

`psPAS` commands return typed objects, so standard PowerShell cmdlets and multi-command chains work exactly as you'd expect:

```powershell
# Find directory groups assigned to Safes
Get-PASSafe -search Finance | Get-PASSafeMember -memberType group -includePredefinedUsers $false |
    Where-Object { Get-PASGroup -search $_.UserName -groupType Directory }

UserName                SafeName      Permissions
--------                --------      -----------
ACC-G-FinanceSafe01-Usr FinanceSafe01 @{useAccounts=True; retrieveAccounts=True; listAccounts=True;...
ACC-G-FinanceSafe01-Adm FinanceSafe01 @{useAccounts=True; retrieveAccounts=True; listAccounts=True;...
```

Three ordinary `psPAS` commands and a standard `Where-Object` — no manual JSON or REST calls in sight.

### More Examples

Rather than duplicate a manual's worth of code in this file, worked examples for common tasks live in the [psPAS Module Guide][docs-guide], each with the same real request/response output style as above:

- [Search][docs-search] — finding Safes, Safe Members, Users and Accounts
- [Administration][docs-admin] — adding accounts, Safes and Safe Members, importing platforms & connection components
- [CPM Operations][docs-cpm] — verify, change & reconcile tasks
- [Bulk Operations][docs-bulk] — onboarding/removing accounts and Safes in bulk from a CSV
- [Safe Permissions][docs-permissions] — defining reusable Safe permission "roles" and applying them
- [PSM Sessions][docs-psm] — finding, monitoring and terminating live sessions
- [Update Accounts][docs-update] — single & multi-property JSON patch updates
- [Methods][docs-methods] — using the ScriptMethods attached to psPAS output objects (e.g. `Get-PASSafe`'s `SafeMembers()`, or converting a retrieved password straight to a `PSCredential`)
- [API Sessions][docs-sessions] — working with more than one authenticated session at once

A larger collection of ready-to-run scripts is maintained in the [psPAS-Examples](https://github.com/pspete/psPAS-Examples) repository.

[docs-guide]: https://pspas.pspete.dev/docs/authentication/
[docs-search]: https://pspas.pspete.dev/docs/search/
[docs-admin]: https://pspas.pspete.dev/docs/administration/
[docs-cpm]: https://pspas.pspete.dev/docs/cpm-operations/
[docs-bulk]: https://pspas.pspete.dev/docs/bulk-operations/
[docs-permissions]: https://pspas.pspete.dev/docs/safe-permissions/
[docs-psm]: https://pspas.pspete.dev/docs/psm-sessions/
[docs-update]: https://pspas.pspete.dev/docs/update-accounts/
[docs-methods]: https://pspas.pspete.dev/docs/methods/
[docs-sessions]: https://pspas.pspete.dev/docs/api-sessions/

![Logo][Logo]

## psPAS Functions

`psPAS` includes over 250 commands, grouped below by the area of Idira they cover:

| Category                      | Commands | Covers                                                                                                                                                 |
| ----------------------------- | :------: | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Accounts & Secrets            |    55    | Onboard, retrieve, rotate, link & audit privileged accounts; CPM verify/change/reconcile; JIT access; discovered & dependent accounts; discovery scans |
| Privileged Threat Analytics   |    31    | Security events, risky command rules, remediation & PTA configuration                                                                                  |
| Users, Groups & Directories   |    27    | Vault users and groups, LDAP directory configuration and mappings                                                                                      |
| Authentication & Sessions     |    25    | Every logon flow (CyberArk, LDAP, RADIUS, SAML, PKI, OIDC, Shared Services), session timeout/idle tracking, FIDO2 & SSH keys, OAuth Identity Providers |
| Platforms & Onboarding        |    22    | Import/export/copy/rename CPM platforms, master policy, automatic onboarding rules                                                                     |
| System, Server & Integrations |    17    | System health, server info, custom ticketing, IP allow lists, BYOK                                                                                     |
| PSM Session Monitoring        |    12    | Live & recorded session activity, suspend/resume/terminate                                                                                             |
| Safes & Safe Members          |    9     | Safe lifecycle and Safe membership/permissions                                                                                                         |
| Vault Remote Manager          |    9     | Self-hosted Vault/DR service control, status & failover                                                                                                |
| UI Customization              |    9     | Custom UI themes                                                                                                                                       |
| Reports                       |    8     | Available reports, schedules & exports                                                                                                                 |
| Access Requests               |    7     | Dual-control request/approve/deny workflow                                                                                                             |
| ACLs (Account & Policy)       |    6     | OPM privileged command rules                                                                                                                           |
| Applications (AAM)            |    6     | Application Access Manager identities & authentication methods                                                                                         |
| Account Groups                |    5     | Grouping accounts for coordinated password changes                                                                                                     |
| Connections                   |    4     | Connection Components & PSM Servers                                                                                                                    |

Full detail for every command — parameters, examples, and the minimum Idira (CyberArk) version required — is in the [online Command Reference](https://pspas.pspete.dev/commands/), or straight from PowerShell once the module is installed:

```powershell
# List every command in the module
Get-Command -Module psPAS

# Full help, including examples, for one command
Get-Help Get-PASAccount -Full
```

Version requirements are enforced at runtime too — if your Idira version doesn't support a parameter you've supplied, `psPAS` tells you before the request is sent rather than letting the API reject it.

![Logo][Logo]

## Installation

### Prerequisites

- PowerShell Core, or Windows Powershell v5 (minimum)
- Idira REST API/PVWA Web Service (available and accessible over HTTPS using TLS 1.2 and TLS 1.3)
- A user who can authenticate and has the necessary Vault/Safe permissions.

### Install Options

Users can download psPAS from GitHub or the PowerShell Gallery.

Choose any of the following ways to download the module and install it:

#### Option 1: Install from PowerShell Gallery

This is the easiest and most popular way to install the module.

**PowerShell 5.0 or above** must be used to download the module from the [PowerShell Gallery](https://www.powershellgallery.com/packages/psPAS/).

1. Open a PowerShell prompt

2. Execute the following command:

```powershell
Install-Module -Name psPAS -Scope CurrentUser
```

#### Option 2: Manual Install

The module files can be manually copied to one of your PowerShell module directories.

Use the following command to get the paths to your local PowerShell module folders:

```powershell

$env:PSModulePath.split(';')

```

The module files must be placed in one of the listed directories, in a folder called `psPAS`.

More: [about_PSModulePath](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_psmodulepath)

The module files are available to download using a variety of methods:

##### PowerShell Gallery

- Download from the module from the [PowerShell Gallery](https://www.powershellgallery.com/packages/psPAS/):
  - Run the PowerShell command `Save-Module -Name psPAS -Path C:\temp`
  - Copy the `C:\temp\psPAS` folder to your "Powershell Modules" directory of choice.

##### psPAS Release

- [Download the latest GitHub release](https://github.com/pspete/psPAS/releases/latest)
  - Unblock & Extract the archive
  - Rename the extracted `psPAS-v#.#.#` folder to `psPAS`
  - Copy the `psPAS` folder to your "Powershell Modules" directory of choice.

##### psPAS Branch

- [Download `GitHub Branch`](https://github.com/pspete/psPAS/archive/master.zip)
  - Unblock & Extract the archive
  - Copy the `psPAS` (`\<Archive Root>\psPAS-master\psPAS`) folder to your "Powershell Modules" directory of choice.

### Verification

Validate Install:

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

Get-Help New-PASUser -Full

```

![Logo][Logo]

## Sponsors

A huge thank you to the organizations and individuals supporting this project.

**Johannes Persson Consulting AB**

## Sponsorship

Please support continued psPAS development; consider sponsoring <a href="https://github.com/sponsors/pspete"> @pspete on GitHub Sponsors</a>

## Changelog

All notable changes to this project will be documented in the [Changelog](CHANGELOG.md)

## Author

- **Pete Maan** - [pspete](https://github.com/pspete)

## License

This project is [licensed under the MIT License](LICENSE.md).

## Contributing

Any and all contributions to this project are appreciated.

See the [CONTRIBUTING.md](CONTRIBUTING.md) for a few more details.

## Support

psPAS is neither developed nor supported by Palo Alto Networks; any official support channels offered by the vendor are not appropriate for seeking help with the psPAS module.

Help and support should be sought by [opening an issue][new-issue], or emailing <a href="mailto:pspas@pspete.dev">pspas@pspete.dev</a>.

[new-issue]: https://github.com/pspete/psPAS/issues/new

Priority support could be considered for <a href="https://github.com/sponsors/pspete">sponsors of @pspete</a>, <a href="mailto:pspas@pspete.dev">contact us</a> to discuss options.

## Acknowledgements

Hat Tips:

**JP-Consulting** ([JP-Consulting](https://github.com/johannesconsulting))
for the high effort contributions to the project

**Joe Garcia** ([infamousjoeg](https://github.com/infamousjoeg))
for the unofficial API documentation, general API wizardry & knowledge sharing.

**Jesse McWilliams**
([JesseMcWilliamss](https://github.com/JesseMcWilliamss))
For the information needed to add PKIPN authentication into `New-PASSession`

**Wojciech Ossowski**
([Qrelis](https://github.com/Qrelis))
For sharing the details of the account unlock API.

**Allyn Lindsay**
([allynl93](https://github.com/allynl93))
for [PS-SAML-Interactive](https://github.com/allynl93/PS-SAML-Interactive)

**Assaf Miron**
([AssafMiron](https://github.com/AssafMiron))
For the JSON formatting assistance.

**Warren Frame**
([RamblingCookieMonster](https://github.com/RamblingCookieMonster)) for [Add-ObjectDetail.ps1](https://github.com/RamblingCookieMonster/PowerShell/blob/master/Add-ObjectDetail.ps1).

Chapeau!

![Logo][Logo]
