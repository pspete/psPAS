---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/New-PASSession
schema: 2.0.0
title: New-PASSession
---

# New-PASSession

## SYNOPSIS
Authenticates a user to CyberArk Vault/API.

## SYNTAX

### Gen2 (Default)
```
New-PASSession -Credential <PSCredential> [-newPassword <SecureString>] [-type <String>]
 [-concurrentSession <Boolean>] -BaseURI <String> [-PVWAAppName <String>] [-SkipVersionCheck]
 [-Certificate <X509Certificate>] [-CertificateThumbprint <String>] [-SkipCertificateCheck] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### Gen1Radius
```
New-PASSession -Credential <PSCredential> [-UseGen1API] -useRadiusAuthentication <Boolean> [-OTP <String>]
 [-OTPMode <String>] [-OTPDelimiter <String>] [-RadiusChallenge <String>] [-connectionNumber <Int32>]
 -BaseURI <String> [-PVWAAppName <String>] [-SkipVersionCheck] [-Certificate <X509Certificate>]
 [-CertificateThumbprint <String>] [-SkipCertificateCheck] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Gen1
```
New-PASSession -Credential <PSCredential> [-UseGen1API] [-newPassword <SecureString>]
 [-connectionNumber <Int32>] -BaseURI <String> [-PVWAAppName <String>] [-SkipVersionCheck]
 [-Certificate <X509Certificate>] [-CertificateThumbprint <String>] [-SkipCertificateCheck] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### Gen2Radius
```
New-PASSession -Credential <PSCredential> [-type <String>] [-OTP <String>] [-OTPMode <String>]
 [-OTPDelimiter <String>] [-RadiusChallenge <String>] [-concurrentSession <Boolean>] -BaseURI <String>
 [-PVWAAppName <String>] [-SkipVersionCheck] [-Certificate <X509Certificate>] [-CertificateThumbprint <String>]
 [-SkipCertificateCheck] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Gen2SAML
```
New-PASSession [-SAMLAuth] [-concurrentSession <Boolean>] -BaseURI <String> [-PVWAAppName <String>]
 [-SkipVersionCheck] [-Certificate <X509Certificate>] [-CertificateThumbprint <String>] [-SkipCertificateCheck]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Gen1SAML
```
New-PASSession -SAMLToken <String> -BaseURI <String> [-PVWAAppName <String>] [-SkipVersionCheck]
 [-Certificate <X509Certificate>] [-CertificateThumbprint <String>] [-SkipCertificateCheck] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### shared
```
New-PASSession [-UseSharedAuthentication] -BaseURI <String> [-PVWAAppName <String>] [-SkipVersionCheck]
 [-Certificate <X509Certificate>] [-CertificateThumbprint <String>] [-SkipCertificateCheck] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### integrated
```
New-PASSession [-UseDefaultCredentials] [-concurrentSession <Boolean>] -BaseURI <String>
 [-PVWAAppName <String>] [-SkipVersionCheck] [-Certificate <X509Certificate>] [-CertificateThumbprint <String>]
 [-SkipCertificateCheck] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Authenticates a user to a CyberArk Vault and stores an authentication token and a webrequest session object
which are used in subsequent calls to the API.

In addition, this method allows you to set a new password.

Will attempt authentication against the V10 API by default.

For older CyberArk versions, specify the -UseClassicAPI switch parameter to force use of the V9 API endpoint.

Windows authentication is only supported (from CyberArk 10.4+).

Authenticate using CyberArk, LDAP, RADIUS, SAML or Shared authentication (From CyberArk version 9.7+).

For CyberArk version older than 9.7:
- Only CyberArk Authentication method is supported.
- newPassword Parameter is not supported.
- useRadiusAuthentication Parameter is not supported.
- connectionNumber Parameter is not supported.

## EXAMPLES

### EXAMPLE 1
```
New-PASSession -Credential $cred -BaseURI https://PVWA -type LDAP
```

Logon to Version 10 with LDAP credential

### EXAMPLE 2
```
New-PASSession -Credential $cred -BaseURI https://PVWA -type LDAP -concurrentSession $true
```

Establish a concurrent session

### EXAMPLE 3
```
New-PASSession -Credential $cred -BaseURI https://PVWA -type CyberArk
```

Logon to Version 10 with CyberArk credential

### EXAMPLE 4
```
New-PASSession -BaseURI https://PVWA -UseDefaultCredentials
```

Logon to Version 10 with Windows Integrated Authentication

### EXAMPLE 5
```
New-PASSession -Credential $cred -BaseURI https://PVWA -UseClassicAPI
```

Logon to Version 9 with credential
Request would be sent to PVWA URL https://PVWA/PasswordVault/

### EXAMPLE 6
```
New-PASSession -Credential $cred -BaseURI https://PVWA -PVWAAppName CustomVault -UseClassicAPI
```

Logon to Version 9 where PVWA Virtual Directory has non-default name
Request would be sent to PVWA URL https://PVWA/CustomVault/

### EXAMPLE 7
```
New-PASSession -UseSharedAuthentication -BaseURI https://PVWA.domain.com
```

Gets authorisation token by authenticating to a CyberArk Vault using shared authentication.

### EXAMPLE 8
```
New-PASSession -SAMLToken $SAMLToken -BaseURI https://PVWA.domain.com
```

Authenticates to a CyberArk Vault using SAML authentication.

### EXAMPLE 9
```
New-PASSession -Credential $cred -BaseURI https://PVWA -type RADIUS
```

Logon to Version 10 using RADIUS

### EXAMPLE 10
```
New-PASSession -Credential $cred -BaseURI https://PVWA -useRadiusAuthentication $True
```

Logon using RADIUS via the 1st gen API

### EXAMPLE 11
```
New-PASSession -Credential $cred -BaseURI https://PVWA -type RADIUS -OTP 123456
```

Logon to Version 10 using RADIUS (Challenge) & OTP (Response)

### EXAMPLE 12
```
New-PASSession -Credential $cred -BaseURI https://PVWA -UseClassicAPI -useRadiusAuthentication $True -OTP 123456 -OTPMode Append
```

Logon using RADIUS & OTP (Append Mode) via the 1st gen API

### EXAMPLE 13
```
New-PASSession -Credential $cred -BaseURI https://PVWA -type RADIUS -OTP push -OTPMode Append
```

Logon to Version 10 using RADIUS & Push Authentication (works with DUO 2FA)

### EXAMPLE 14
```
New-PASSession -UseSharedAuthentication -BaseURI https://pvwa.some.co -CertificateThumbprint 0e194289c57e666115109d6e2800c24fb7db6edb
```

If authentication via certificates is configured, provide CertificateThumbprint details.

### EXAMPLE 15
```
New-PASSession -Credential $cred -BaseURI $url -SkipCertificateCheck
```

Skip SSL Certificate validation for the session.

### EXAMPLE 16
```
New-PASSession -Credential $cred -BaseURI https://PVWA -type LDAP -Certificate $Certificate
```

Logon to Version 10 with LDAP credential & Client Certificate

### EXAMPLE 17
```
New-PASSession -Credential $cred -BaseURI https://PVWA -type Windows -OTP 123456
```

Perform initial Windows authentication and satisfy secondary RADIUS challenge

### EXAMPLE 18
```
New-PASSession -Credential $cred -BaseURI https://PVWA -type RADIUS -OTP 123456 -RadiusChallenge Password -OTPMode Challenge
```

For RADIUS, send OTP first and password value as response to challenge.

### EXAMPLE 19
```
New-PASSession -Credential $cred -BaseURI https://PVWA -type RADIUS
```

Perform initial authentication and supply OTP value for  RADIUS challenge when prompted.

### EXAMPLE 20
```
New-PASSession -BaseURI $url -SAMLAuth
```

Perform saml authentication from version 11.4

## PARAMETERS

### -Credential
A Valid PSCredential object.

```yaml
Type: PSCredential
Parameter Sets: Gen2, Gen2Radius
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

```yaml
Type: PSCredential
Parameter Sets: Gen1Radius, Gen1
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -UseGen1API
Specify to send the authentication request via the Gen1 API endpoint.

Relevant for CyberArk versions earlier than 10.4

```yaml
Type: SwitchParameter
Parameter Sets: Gen1Radius
Aliases: UseClassicAPI

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

```yaml
Type: SwitchParameter
Parameter Sets: Gen1
Aliases: UseClassicAPI

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -newPassword
Optional parameter, enables you to change a CyberArk users password.

Must be supplied as a SecureString (Not Plain Text).

```yaml
Type: SecureString
Parameter Sets: Gen2, Gen1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SAMLAuth
Supported from 11.4

Specify to authenticate after retrieval of saml token.

```yaml
Type: SwitchParameter
Parameter Sets: Gen2SAML
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SAMLToken
SAML token that identifies the session, encoded in BASE 64.

```yaml
Type: String
Parameter Sets: Gen1SAML
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UseSharedAuthentication
Specify the UseSharedAuthentication switch to use the Shared Authentication API endpoint to logon

```yaml
Type: SwitchParameter
Parameter Sets: shared
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -useRadiusAuthentication
Whether or not users will be authenticated via a RADIUS server.

```yaml
Type: Boolean
Parameter Sets: Gen1Radius
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -type
When using the version 10 API endpoint, specify the type of authentication to use.

Valid values are:
- CyberArk
- LDAP
- Windows
  - only a valid option for version 10.4 onward.
- RADIUS

```yaml
Type: String
Parameter Sets: Gen2, Gen2Radius
Aliases:

Required: False
Position: Named
Default value: CyberArk
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -OTP
One Time Passcode, if known, for RADIUS authentication.

```yaml
Type: String
Parameter Sets: Gen1Radius, Gen2Radius
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -OTPMode
Specify if OTP is to be sent in 'Append' (appended to the password) or 'Challenge' mode (sent in response to RADIUS Challenge).

```yaml
Type: String
Parameter Sets: Gen1Radius, Gen2Radius
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -OTPDelimiter
The character to use as a delimiter when appending the OTP to the password.

Defaults to comma ",".

```yaml
Type: String
Parameter Sets: Gen1Radius, Gen2Radius
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RadiusChallenge
Specify if Radius challenge is satisfied by 'OTP' or 'Password'.

If "OTP" (Default), Password will be sent first, with OTP as the challenge response.

If "Password", then OTP value will be sent first, and Password will be sent as the challenge response.

```yaml
Type: String
Parameter Sets: Gen1Radius, Gen2Radius
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UseDefaultCredentials
See Invoke-WebRequest

Uses the credentials of the current user to send the web request

```yaml
Type: SwitchParameter
Parameter Sets: integrated
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -concurrentSession
Enables multiple simultaneous connection sessions as the same user.

Requires 11.3+

```yaml
Type: Boolean
Parameter Sets: Gen2, Gen2Radius, Gen2SAML, integrated
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -connectionNumber
In order to allow more than one connection for the same user simultaneously, each request
should be sent with different 'connectionNumber'.

Valid values: 1-100

```yaml
Type: Int32
Parameter Sets: Gen1Radius, Gen1
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -BaseURI
A string containing the base web address to send te request to.

Pass the portion the PVWA HTTP address.

Do not include "/PasswordVault/"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PVWAAppName
The name of the CyberArk PVWA Virtual Directory.

Defaults to PasswordVault

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: PasswordVault
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SkipVersionCheck
If the SkipVersionCheck switch is specified, Get-PASServer will not be called after
successfully authenticating.

Get-PASServer is not supported before version 9.7.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Certificate
See Invoke-WebRequest

Specifies the client certificate that is used for a secure web request.

Enter a variable that contains a certificate or a command or expression that gets the certificate.

```yaml
Type: X509Certificate
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CertificateThumbprint
See Invoke-WebRequest

The thumbprint of the certificate to use for client certificate authentication.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipCertificateCheck
Skips certificate validation checks.

Using this parameter is not secure and is not recommended.

This switch is only intended to be used against known hosts using a self-signed certificate for testing purposes.

Use at your own risk.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/New-PASSession](https://pspas.pspete.dev/commands/New-PASSession)

