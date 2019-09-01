---
title: Remove-PASApplicationAuthenticationMethod
---

## SYNOPSIS

Deletes an authentication method from an application

## SYNTAX

    Remove-PASApplicationAuthenticationMethod [-AppID] <String> [-AuthID] <String> [-WhatIf] [-Confirm]
    [<CommonParameters>]

## DESCRIPTION

Deletes a specific authentication method from a defined application.

"Manage Users" permission is required.

## PARAMETERS

    -AppID <String>
        The ID of the application in which the authentication will be deleted.

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AuthID <String>
        The unique ID of the specific authentication.

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


    Should accept pipeline objects from other *-PASApplication* function.

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Remove-PASApplicationAuthenticationMethod -AppID NewApp -AuthID 1

    Deletes authentication method with ID of 1 from "NewApp"




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Get-PASApplicationAuthenticationMethod -AppID NewApp |
        Remove-PASApplicationAuthenticationMethod

    Deletes all authentication methods from "NewApp"
