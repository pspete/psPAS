---
title: "Authentication"
permalink: /docs/authentication/
excerpt: "psPAS Authentication"
last_modified_at: 2023-03-06T01:23:45-00:00
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

Provide tenant ID and credentials for authentication via CyberArk Identity for Privilege Cloud Shared Services:

```
New-PASSession -TenantSubdomain YourPrivilegeCloudTenantID -Credential $PCloudCreds
```