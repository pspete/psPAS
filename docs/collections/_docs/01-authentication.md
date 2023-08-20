---
title: "Authentication"
permalink: /docs/authentication/
excerpt: "psPAS Authentication"
last_modified_at: 2023-08-20T01:23:45-00:00
---

_Everything begins with a **Logon**:_

To submit a logon request to the CyberArk API, use the psPAS `New-PASSession` command.

All subsequent operations are carried out by `psPAS` utilising the input data provided for the `New-PASSession` request (URL, Certificate), as well as data received from the API after successful authentication (Authentication Token, PVWA Version).

## CyberArk Authentication

- Use a PowerShell credential object containing a valid vault username and password.

````powershell
$cred = Get-Credential

PowerShell credential request
Enter your credentials.
User: safeadmin
Password for user safeadmin: **********


New-PASSession -Credential $cred -BaseURI https://pvwa.somedomain.com
````

## LDAP Authentication

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

## RADIUS Authentication

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

## SAML Authentication

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

## Certificate Authentication

- Where PVWA/IIS requires client certificates, 'psPAS' will use any specified certificates for the duration of the session.

### PKI Authentication Example
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

### PKIPN Authentication Example
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

### Shared Authentication Example
```powershell
$Cert = "0E199489C57E666115666D6E9990C2ACABDB6EDB"
New-PASSession -UseSharedAuthentication -BaseURI https://pvwa.somedomain.com -CertificateThumbprint $Cert
```

## Shared Services Authentication

**Privilege Cloud Shared Services authentication flows require use of the pspete `IdentityCommand` module, available from the Powershell Gallery & GitHub.**

### Identity User

Provide Identity User credentials and tenant details for authentication to CyberArk Identity for Privilege Cloud Shared Services:

```
New-PASSession -IdentityTenantURL https://SomeTenantName.id.cyberark.cloud -PrivilegeCloudURL https://SomeTenant.privilegecloud.cyberark.cloud -Credential $Cred -IdentityUser
```

### Service User

Provide tenant ID and non-interactive API User credentials for authentication via CyberArk Identity for Privilege Cloud Shared Services:

```
New-PASSession -TenantSubdomain YourPrivilegeCloudTenantID -Credential $ServiceUserCreds -ServiceUser
```

Consult the vendor documentation for guidance on setting up a dedicated API Service user for non-interactive API use.

### Tenant Subdomains & Portal URLs
When providing a value for a privilege cloud tenant subdomain, this value is used to discover the identity tenant with which to authenticate:

```
New-PASSession -TenantSubdomain PCloudTenantID -Credential $cred -ServiceUser
```

If you encounter any issue authenticating with the module when providing a subdomain value, you can alternatively specify URL values for both your Identity portal, and Privilege Cloud API:

```
New-PASSession -IdentityTenantURL 'https://ABC123.id.cyberark.cloud' -PrivilegeCloudURL 'https://XYZ789.privilegecloud.cyberark.cloud' -Credential $cred -ServiceUser
```
