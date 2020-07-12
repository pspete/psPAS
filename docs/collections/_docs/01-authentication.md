---
title: "Authentication"
permalink: /docs/authentication/
excerpt: "psPAS Authentication"
last_modified_at: 2019-09-01T01:33:52-00:00
---

_It all starts with a **Logon**_

`New-PASSession` is used to send a logon request to the CyberArk API.

On successful authentication `psPAS` uses the data which was provided for the request & also returned from the API for all subsequent operations.

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

### Challenge Mode

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

### Append Mode

- Some 2FA solutions allow a One Time Passcode to be sent with the password.

  - If an OTP is provided, it is sent to the API with the password, separated by a delimiter: "`$Password,$OTP`"

````powershell
$cred = Get-Credential

PowerShell credential request
Enter your credentials.
User: DuoUser
Password for user DuoUser: **********


New-PASSession -Credential $cred -BaseURI https://pvwa.somedomain.com -type RADIUS -OTP 738458 -OTPMode Append

Get-PASLoggedOnUser

UserName Source UserTypeName AgentUser Expired Disabled Suspended
-------- ------ ------------ --------- ------- -------- ---------
DuoUser  LDAP   EPVUser      False     False   False    False
````

## Shared Authentication with Client Certificate

- If IIS is configured to require client certificates, `psPAS` will use any provided certificate details for the duration of the session.

````powershell
$Cert = "0E199489C57E666115666D6E9990C2ACABDB6EDB"
New-PASSession -UseSharedAuthentication -BaseURI https://pvwa.somedomain.com
-CertificateThumbprint $Cert
````
