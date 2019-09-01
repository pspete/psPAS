---
title: Get-PASApplicationAuthenticationMethod
---

## SYNOPSIS

Returns information about all of the authentication methods of a specific application.

## SYNTAX

    Get-PASApplicationAuthenticationMethod [-AppID] <String> [<CommonParameters>]

## DESCRIPTION

Returns information about all of the authentication methods of a specific application.

The user authenticated to the vault running the command must have the "Audit Users" permission.

## PARAMETERS

    -AppID <String>
        The name of the application for which information about authentication methods will
        be returned.

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Get-PASApplicationAuthenticationMethod -AppID NewApp

    Gets all authentication methods of application NewApp
