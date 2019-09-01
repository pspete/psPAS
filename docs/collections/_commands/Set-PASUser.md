---
title: Set-PASUser
---

## SYNOPSIS

Updates a vault user

## SYNTAX

    Set-PASUser [-UserName] <String> [[-NewPassword] <SecureString>] [[-Email] <String>]
    [[-FirstName] <String>] [[-LastName] <String>] [[-ChangePasswordOnTheNextLogon] <Boolean>]
    [[-ExpiryDate] <DateTime>] [[-UserTypeName] <String>] [[-Disabled] <Boolean>]
    [[-Location] <String>]

## DESCRIPTION

Updates an existing user in the vault

## PARAMETERS

    -UserName <String>
        The name of the user to update in the vault

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -NewPassword <SecureString>
        The password to set on the account.
        Must meet the password complexity requirements

        Required?                    false
        Position?                    2
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -Email <String>
        The user's email address

        Required?                    false
        Position?                    3
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -FirstName <String>
        The user's first name

        Required?                    false
        Position?                    4
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -LastName <String>
        The user's last name

        Required?                    false
        Position?                    5
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -ChangePasswordOnTheNextLogon <Boolean>
        Whether or not user will be forced to change password on next logon

        Required?                    false
        Position?                    6
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -ExpiryDate <DateTime>
        Expiry Date to set on account.

        Required?                    false
        Position?                    7
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -UserTypeName <String>
        The User Type

        Required?                    false
        Position?                    8
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -Disabled <Boolean>
        Whether or not the user will be enabled or disabled.

        Required?                    false
        Position?                    9
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -Location <String>
        The Vault Location for the user

        Required?                    false
        Position?                    10
        Default value
        Accept pipeline input?       false
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
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>set-pasuser -UserName Bill -Disabled $true

    Disables vault user Bill
