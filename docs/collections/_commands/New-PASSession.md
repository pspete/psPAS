---
title: New-PASSession
---

## SYNOPSIS

Authenticates a user to CyberArk Vault/API.

## SYNTAX

    New-PASSession -Credential <PSCredential> [-newPassword <SecureString>] [-type <String>]
    -BaseURI <String> [-PVWAAppName <String>] [-SkipVersionCheck] [-CertificateThumbprint <String>]
    [-SkipCertificateCheck] [-WhatIf] [-Confirm] [<CommonParameters>]

    New-PASSession -Credential <PSCredential> -UseClassicAPI -useRadiusAuthentication <Boolean>
    [-OTP <String>] [-OTPMode <String>] [-OTPDelimiter <String>] [-RadiusChallenge <String>]
    [-connectionNumber <Int32>] -BaseURI <String> [-PVWAAppName <String>] [-SkipVersionCheck]
    [-CertificateThumbprint <String>] [-SkipCertificateCheck] [-WhatIf] [-Confirm] [<CommonParameters>]

    New-PASSession -Credential <PSCredential> -UseClassicAPI [-newPassword <SecureString>]
    [-connectionNumber <Int32>] -BaseURI <String> [-PVWAAppName <String>] [-SkipVersionCheck]
    [-CertificateThumbprint <String>] [-SkipCertificateCheck] [-WhatIf] [-Confirm] [<CommonParameters>]

    New-PASSession -Credential <PSCredential> [-type <String>] [-OTP <String>] [-OTPMode <String>]
    [-OTPDelimiter <String>] [-RadiusChallenge <String>] -BaseURI <String> [-PVWAAppName <String>]
    [-SkipVersionCheck] [-CertificateThumbprint <String>] [-SkipCertificateCheck] [-WhatIf] [-Confirm]
    [<CommonParameters>]

    New-PASSession -SAMLToken <String> -BaseURI <String> [-PVWAAppName <String>] [-SkipVersionCheck]
    [-CertificateThumbprint <String>] [-SkipCertificateCheck] [-WhatIf] [-Confirm] [<CommonParameters>]

    New-PASSession -UseSharedAuthentication -BaseURI <String> [-PVWAAppName <String>]
    [-SkipVersionCheck] [-CertificateThumbprint <String>] [-SkipCertificateCheck] [-WhatIf] [-Confirm]
    [<CommonParameters>]

    New-PASSession [-UseDefaultCredentials] -BaseURI <String> [-PVWAAppName <String>]
    [-SkipVersionCheck] [-CertificateThumbprint <String>] [-SkipCertificateCheck] [-WhatIf] [-Confirm]
    [<CommonParameters>]

## DESCRIPTION

Authenticates a user to a CyberArk Vault and stores an authentication token and a webrequest session object
which are used in subsequent calls to the API.

In addition, this method allows you to set a new password.

Will attempt authentication against the V10 API by default.

For older CyberArk versions, specify the -UseClassicAPI switch parameter to force use of the V9 API endpoint.

Windows authentication is only supported (from CyberArk 10.4+).

Authenticate using CyberArk, LDAP, RADIUS, SAML or Shared authentication (From CyberArk version 9.7+),

For CyberArk version older than 9.7:

- Only CyberArk Authentication method is supported.
- newPassword Parameter is not supported.
- useRadiusAuthentication Parameter is not supported.
- connectionNumber Parameter is not supported.

## PARAMETERS

    -Credential <PSCredential>
        A Valid PSCredential object.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByValue, ByPropertyName)
        Accept wildcard characters?  false

    -UseClassicAPI [<SwitchParameter>]
        Specify the UseClassicAPI to send the authentication request via the Classic (v9) API endpoint.
        Relevant for CyberArk versions earlier than 10.4

        Required?                    true
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByValue)
        Accept wildcard characters?  false

    -newPassword <SecureString>
        Optional parameter, enables you to change a CyberArk users password.
        Must be supplied as a SecureString (Not Plain Text).

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -SAMLToken <String>
        SAML token that identifies the session, encoded in BASE 64.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UseSharedAuthentication [<SwitchParameter>]
        Specify the UseSharedAuthentication switch to use the Shared Authentication API endpoint to logon

        Required?                    true
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -useRadiusAuthentication <Boolean>
        Whether or not users will be authenticated via a RADIUS server.

        Required?                    true
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -type <String>
        When using the version 10 API endpoint, specify the type of authentication to use.
        Valid values are CyberArk, LDAP, Windows or RADIUS
        Windows is only a valid option for version 10.4 onward.

        Required?                    false
        Position?                    named
        Default value                CyberArk
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -OTP <String>
        One Time Passcode for RADIUS authentication.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -OTPMode <String>
        Specify if OTP is to be sent in 'Append' (appended to the password) or 'Challenge' mode
        (sent in response to RADIUS Challenge).

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -OTPDelimiter <String>
        The character to use as a delimiter when appending the OTP to the password.
        Defaults to comma ",".

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -RadiusChallenge <String>
        Specify if Radius challenge is satisfied by 'OTP' or 'Password'.
        If "OTP" (Default), Password will be sent first, with OTP as the challenge response.
        If "Password", then OTP value will be sent first, and Password will be sent as the
        challenge response.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UseDefaultCredentials [<SwitchParameter>]
        See Invoke-WebRequest
        Uses the credentials of the current user to send the web request

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -connectionNumber <Int32>
        In order to allow more than one connection for the same user simultaneously, each request
        should be sent with different 'connectionNumber'.
        Valid values: 1-100

        Required?                    false
        Position?                    named
        Default value                0
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -BaseURI <String>
        A string containing the base web address to send te request to.
        Pass the portion the PVWA HTTP address.
        Do not include "/PasswordVault/"

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -PVWAAppName <String>
        The name of the CyberArk PVWA Virtual Directory.
        Defaults to PasswordVault

        Required?                    false
        Position?                    named
        Default value                PasswordVault
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -SkipVersionCheck [<SwitchParameter>]
        If the SkipVersionCheck switch is specified, Get-PASServer will not be called after
        successfully authenticating. Get-PASServer is not supported before version 9.7.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -CertificateThumbprint <String>
        See Invoke-WebRequest
        The thumbprint of the certificate to use for client certificate authentication.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -SkipCertificateCheck [<SwitchParameter>]
        Skips certificate validation checks.
        Using this parameter is not secure and is not recommended.
        This switch is only intended to be used against known hosts using a self-signed
        certificate for testing purposes.
        Use at your own risk.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -WhatIf [<SwitchParameter>]

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -Confirm [<SwitchParameter>]

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS > New-PASSession -Credential $cred -BaseURI https://PVWA -type LDAP

    Logon to Version 10 with LDAP credential




    -------------------------- EXAMPLE 2 --------------------------

    PS > New-PASSession -Credential $cred -BaseURI https://PVWA -type CyberArk

    Logon to Version 10 with CyberArk credential




    -------------------------- EXAMPLE 3 --------------------------

    PS > New-PASSession -BaseURI https://PVWA -UseDefaultCredentials

    Logon to Version 10 with Windows Integrated Authentication




    -------------------------- EXAMPLE 4 --------------------------

    PS > New-PASSession -Credential $cred -BaseURI https://PVWA -UseClassicAPI

    Logon to Version 9 with credential
    Request would be sent to PVWA URL https://PVWA/PasswordVault/




    -------------------------- EXAMPLE 5 --------------------------

    PS > New-PASSession -Credential $cred -BaseURI https://PVWA -PVWAAppName CustomVault -UseClassicAPI

    Logon to Version 9 where PVWA Virtual Directory has non-default name
    Request would be sent to PVWA URL https://PVWA/CustomVault/




    -------------------------- EXAMPLE 6 --------------------------

    PS > New-PASSession -UseSharedAuthentication -BaseURI https://PVWA.domain.com

    Gets authorisation token by authenticating to a CyberArk Vault using shared authentication.




    -------------------------- EXAMPLE 7 --------------------------

    PS > New-PASSession -SAMLToken $SAMLToken -BaseURI https://PVWA.domain.com

    Authenticates to a CyberArk Vault using SAML authentication.




    -------------------------- EXAMPLE 8 --------------------------

    PS > New-PASSession -Credential $cred -BaseURI https://PVWA -type RADIUS

    Logon to Version 10 using RADIUS




    -------------------------- EXAMPLE 9 --------------------------

    PS > New-PASSession -Credential $cred -BaseURI https://PVWA -useRadiusAuthentication $True

    Logon using RADIUS via the Classic API




    -------------------------- EXAMPLE 10 --------------------------

    PS > New-PASSession -Credential $cred -BaseURI https://PVWA -type RADIUS
    -OTP 123456 -OTPMode Challenge

    Logon to Version 10 using RADIUS (Challenge) & OTP (Response)




    -------------------------- EXAMPLE 11 --------------------------

    PS > New-PASSession -Credential $cred -BaseURI https://PVWA -UseClassicAPI
    -useRadiusAuthentication $True -OTP 123456 -OTPMode Append

    Logon using RADIUS & OTP (Append Mode) via the Classic API




    -------------------------- EXAMPLE 12 --------------------------

    PS > New-PASSession -Credential $cred -BaseURI https://PVWA -type RADIUS -OTP push -OTPMode Append

    Logon to Version 10 using RADIUS & Push Authentication (works with DUO 2FA)




    -------------------------- EXAMPLE 13 --------------------------

    PS > New-PASSession -UseSharedAuthentication -BaseURI https://pvwa.some.co
    -CertificateThumbprint 0e194289c57e666115109d6e2800c24fb7db6edb

    If authentication via certificates is configured, provide CertificateThumbprint details.




    -------------------------- EXAMPLE 14 --------------------------

    PS > New-PASSession -Credential $cred -BaseURI $url -SkipCertificateCheck

    Skip SSL Certificate validation for the session.
