---
title: Unlock-PASAccount
---

## SYNOPSIS

Checks in an exclusive account in to the Vault.

## SYNTAX

    Unlock-PASAccount [-AccountID] <String>

## DESCRIPTION

Checks in an account, locked due to an exclusive account policy, to the Vault.

If the account is managed automatically by the CPM, after it is checked in,the password is changed immediately.

If the account is managed manually, a notification is sent to a user who is authorised to change the password.

The account is checked in automatically after it has been changed.

Requires Initiate CPM password management operations on the Safe where the account is stored.

## PARAMETERS

    -AccountID <String>
        The unique ID  of the account.
        This is retrieved by the Get-PASAccount function.

        Required?                    true
        Position?                    1
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

    PS C:\>Unlock-PASAccount -AccountID 21_3

    Will check-in exclusive access account with ID of "21_3"




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Get-PASAccount xAccount | Unlock-PASAccount

    Will check-in exclusive access account xAccount
