---
title: Remove-PASApplication
---

## SYNOPSIS

Deletes an application

## SYNTAX

    Remove-PASApplication [-AppID] <String>

## DESCRIPTION

Deletes a specific application.

"Manage Users" permission is required to be held.

## PARAMETERS

    -AppID <String>
        The name of the application to delete.

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


    Should accept pipeline objects from other *-PASApplication* function.

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Remove-PASApplication -AppID NewApp

    Deletes application "NewApp"
