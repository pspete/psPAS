---
title: Remove-PASAccount
---

## SYNOPSIS

Deletes an account

## SYNTAX

    Remove-PASAccount -AccountID <String> [-UseClassicAPI]

## DESCRIPTION

Deletes a specific account in the Vault.

The user who runs this web service requires the "Delete Accounts" permission.

## PARAMETERS

    -AccountID <String>
        The unique ID  of the account to delete.
        This is retrieved by the Get-PASAccount function.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UseClassicAPI [<SwitchParameter>]
        Specify the UseClassicAPI to force usage the Classic (v9) API endpoint.

        Required?                    false
        Position?                    named
        Default value                False
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

    PS C:\>Remove-PASAccount -AccountID 19_1

    Deletes the account with AccountID of 19_1
