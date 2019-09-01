---
title: Set-PASUserPassword
---

## SYNOPSIS

Updates a vault user

## SYNTAX

    Set-PASUserPassword [-id] <Int32> [-NewPassword] <SecureString>

## DESCRIPTION

Updates an existing user in the vault

## PARAMETERS

    -id <Int32>
        The name of the user to update in the vault

        Required?                    true
        Position?                    1
        Default value                0
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -NewPassword <SecureString>
        The password to set on the account.
        Must meet the password complexity requirements

        Required?                    true
        Position?                    2
        Default value
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
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Set-PASUserPassword -id 123 -NewPassword $SecureString

    Resets password on account with id 123
