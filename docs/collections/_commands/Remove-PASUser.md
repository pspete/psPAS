---
title: Remove-PASUser
---

## SYNOPSIS

Deletes a vault user

## SYNTAX

    Remove-PASUser -id <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]

    Remove-PASUser -UserName <String> [-WhatIf] [-Confirm] [<CommonParameters>]

## DESCRIPTION

Deletes an existing user from the vault

## PARAMETERS

    -id <Int32>
        The numeric id of the user to delete.
        Requires CyberArk version 11.1+

        Required?                    true
        Position?                    named
        Default value                0
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UserName <String>
        The name of the user to delete from the vault

        Required?                    true
        Position?                    named
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

    PS C:\>Remove-PASUser -id 1234

    Deletes vault user with id 1234


    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Remove-PASUser -UserName This_User

    Deletes vault user "This_User"
