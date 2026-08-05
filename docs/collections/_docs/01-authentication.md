---
title: "Authentication"
permalink: /docs/authentication/
excerpt: "psPAS Authentication"
last_modified_at: 2026-08-03T01:23:45-00:00
---

_Everything begins with a **Logon**:_

To submit a logon request to the Idira (CyberArk) API, use the psPAS `New-PASSession` command.

All subsequent operations are carried out by `psPAS` utilising the input data provided for the `New-PASSession` request (URL, Certificate), as well as data received from the API after successful authentication (Authentication Token, PVWA Version).

`New-PASSession` supports authentication to a self-hosted PVWA and to an Idira Identity Security Platform Shared Services (Privilege Cloud/ISPSS) tenant. Most new Idira deployments today are Privilege Cloud (SaaS), so that's the first set of flows covered below — self-hosted PVWA is just as fully supported and follows straight after.

## Privilege Cloud / ISPSS (SaaS)

**Privilege Cloud/ISPSS authentication flows require use of the pspete `IdentityCommand` module, available from the [PowerShell Gallery](https://www.powershellgallery.com/packages/IdentityCommand) & [GitHub](https://github.com/pspete/IdentityCommand).** `psPAS` uses it to handle the identity logon; the returned authentication token is then used for every subsequent `psPAS` command exactly as it is for a self-hosted PVWA session.

Every ISPSS flow accepts either a `-TenantSubdomain` value, or an explicit `-IdentityTenantURL`/`-PrivilegeCloudURL` pair — see [Tenant Subdomains & Portal URLs](#tenant-subdomains--portal-urls) below.

### Identity User

Provide Identity User credentials and tenant details for interactive authentication to CyberArk Identity for Privilege Cloud Shared Services:

```powershell
# using subdomain
New-PASSession -TenantSubdomain SomeTenantName -Credential $Cred -IdentityUser
```

```powershell
# using explicit URLs
New-PASSession -IdentityTenantURL https://SomeTenantName.id.cyberark.cloud -PrivilegeCloudURL https://SomeTenant.privilegecloud.cyberark.cloud -Credential $Cred -IdentityUser
```

### Service User

Provide tenant details and non-interactive API Service User credentials (OAuth client credentials) for authentication via CyberArk Identity for Privilege Cloud Shared Services:

```powershell
# using subdomain
New-PASSession -TenantSubdomain YourPrivilegeCloudTenantID -Credential $ServiceUserCreds -ServiceUser
```

```powershell
# using explicit URLs
New-PASSession -IdentityTenantURL 'https://ABC123.id.cyberark.cloud' -PrivilegeCloudURL 'https://XYZ789.privilegecloud.cyberark.cloud' -Credential $ServiceUserCreds -ServiceUser
```

Consult the vendor documentation for guidance on setting up a dedicated API Service user for non-interactive API use.

### SAML

Exchange a SAML assertion obtained from a federated identity provider for an authenticated Identity Shared Services session:

```powershell
# using subdomain
New-PASSession -TenantSubdomain YourTenantName -SAMLResponse $SAMLResponse
```

```powershell
# using explicit URLs
New-PASSession -IdentityTenantURL https://SomeTenantName.id.cyberark.cloud -PrivilegeCloudURL https://SomeName.privilegecloud.cyberark.cloud -SAMLResponse $SAMLResponse
```

As with the self-hosted [SAML Authentication](#saml-authentication) flow, the [PS-SAML-Interactive](https://github.com/allynl93/PS-SAML-Interactive) module can be used to retrieve a `$SAMLResponse` value where IWA SSO isn't possible.

### Tenant Subdomains & Portal URLs

When providing a value for a Privilege Cloud tenant subdomain, this value is used to discover the identity tenant to authenticate against:

```powershell
New-PASSession -TenantSubdomain PCloudTenantID -Credential $cred -ServiceUser
```

If you encounter any issue authenticating with the module when providing a subdomain value, you can alternatively specify URL values for both your Identity portal, and Privilege Cloud API:

```powershell
New-PASSession -IdentityTenantURL 'https://ABC123.id.cyberark.cloud' -PrivilegeCloudURL 'https://XYZ789.privilegecloud.cyberark.cloud' -Credential $cred -ServiceUser
```

## Self-Hosted PVWA

### Local User (CyberArk) Authentication

- Use a PowerShell credential object containing a valid vault username and password.

````powershell
$cred = Get-Credential

PowerShell credential request
Enter your credentials.
User: safeadmin
Password for user safeadmin: **********


New-PASSession -Credential $cred -BaseURI https://pvwa.somedomain.com
````

### LDAP Authentication

- Specify LDAP credentials allowed to authenticate to the vault.

````powershell
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
````

### RADIUS Authentication

Send a known One Time Passcode alongside a credential:

````powershell
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
````

For push-based or challenge/response 2FA providers (e.g. DUO), `-OTPMode`, `-OTPDelimiter` and `-RadiusChallenge` control exactly how the OTP value is combined with the password and sent to the RADIUS server:

```powershell
# DUO Push, working with DUO's 2FA Append Mode configuration
New-PASSession -Credential $cred -BaseURI https://pvwa.somedomain.com -type RADIUS -OTP push -OTPMode Append
```

```powershell
# Password appended with OTP, with no delimiter separating the two values
New-PASSession -Credential $cred -BaseURI https://pvwa.somedomain.com -type RADIUS -OTP 123456 -OTPMode Append -OTPDelimiter $null
```

```powershell
# OTP sent first, password sent as the challenge response
New-PASSession -Credential $cred -BaseURI https://pvwa.somedomain.com -type RADIUS -OTP 123456 -RadiusChallenge Password -OTPMode Challenge
```

### Windows Authentication

Native Windows authentication, optionally satisfying a secondary RADIUS challenge:

```powershell
New-PASSession -Credential $cred -BaseURI https://pvwa.somedomain.com -type Windows -OTP 123456
```

Minimum version required 10.4.

### Windows Integrated Authentication

Authenticate using the credentials of the current, already-logged-on Windows user — no `-Credential` value is needed:

```powershell
New-PASSession -BaseURI https://pvwa.somedomain.com -UseDefaultCredentials
```

### SAML Authentication

SAML SSO authentication using IWA and ADFS can be performed:

```powershell
New-PASSession -BaseURI $url -SAMLAuth
```

Minimum version required 11.4.

Where IWA SSO is not possible, the [PS-SAML-Interactive](https://github.com/allynl93/PS-SAML-Interactive) module can be used to get the SAMLResponse from an authentication service.

The SAMLResponse received from the IdP is sent to complete SAML authentication to the API:

```powershell
import-module -name 'C:\PS-SAML-Interactive.psm1'

$loginURL = 'https://company.okta.com/home/app1/0oa11xddwdzhvlbiZ5d7/aln1k2HsUl5d7'
$baseURL = 'https://pvwa.mycompany.com'

$loginResponse = New-SAMLInteractive -LoginIDP $loginURL

New-PASSession -SAMLAuth -concurrentSession $true -BaseURI $baseURL -SAMLResponse $loginResponse
```

Minimum version required 11.4.

### Certificate Authentication

- Where PVWA/IIS requires client certificates, `psPAS` will use any specified certificates for the duration of the session.

#### PKI Authentication Example

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

#### PKIPN Authentication Example

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

New-PASSession -BaseURI $url -type PKIPN -Certificate $Cert
```

#### Shared Authentication Example

```powershell
$Cert = "0E199489C57E666115666D6E9990C2ACABDB6EDB"
New-PASSession -UseSharedAuthentication -BaseURI https://pvwa.somedomain.com -CertificateThumbprint $Cert
```

Shared authentication is not supported in Privilege Cloud.

#### Skipping certificate validation

For testing against a host using a self-signed certificate, certificate validation can be bypassed entirely. This is not secure and should never be used against a production environment:

```powershell
New-PASSession -Credential $cred -BaseURI $url -SkipCertificateCheck
```

### FIDO2 Authentication

Authenticate using a FIDO2/WebAuthn hardware security key:

```powershell
New-PASSession -BaseURI https://pvwa.somedomain.com -type FIDO2 -UserName administrator
```

Minimum version required 14.4. A security key must already be registered for the user — see `Register-PASFIDO2Device`.

### Gen1 API

For self-hosted environments running versions earlier than 10.4, the `-UseGen1API` switch forces the older Gen1 API endpoint to be used for the logon request. It's available alongside the local user, RADIUS and SAML flows:

```powershell
New-PASSession -Credential $cred -BaseURI https://pvwa.somedomain.com -UseGen1API
```

```powershell
# Where the PVWA Virtual Directory has a non-default name
New-PASSession -Credential $cred -BaseURI https://pvwa.somedomain.com -PVWAAppName CustomVault -UseGen1API
```

```powershell
# RADIUS via the Gen1 API
New-PASSession -Credential $cred -BaseURI https://pvwa.somedomain.com -UseGen1API -useRadiusAuthentication $true
```

```powershell
# SAML via the Gen1 API
New-PASSession -SAMLResponse $SAMLToken -UseGen1API -BaseURI https://pvwa.somedomain.com
```

## Other Session Options

- **Changing a password during logon** — pass `-newPassword` to `New-PASSession` (Gen2/Gen1 self-hosted flows) to set a new CyberArk user password as part of a successful logon.
- **Concurrent sessions** — self-hosted flows accept `-concurrentSession $true` (minimum version 11.3) to allow more than one simultaneous session for the same user. See [API Sessions][docs-sessions] for working with more than one authenticated `psPAS` session at once.
- **Skipping the post-logon version check** — `-SkipVersionCheck` prevents `psPAS` from calling `Get-PASServer` immediately after a successful logon; useful against very old (pre-9.7) environments where that call isn't supported.

[docs-sessions]: /docs/api-sessions/
