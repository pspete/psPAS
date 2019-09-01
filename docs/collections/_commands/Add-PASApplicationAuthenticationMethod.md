---
title: Add-PASApplicationAuthenticationMethod
---

## SYNOPSIS

Adds an authentication method to an application.

## SYNTAX

    Add-PASApplicationAuthenticationMethod [-AppID] <String> [-AuthType] <String> [-AuthValue] <String>
    [<CommonParameters>]

## DESCRIPTION

Adds a new authentication method to a specific application iin the vault.

The "Manage Users" permission is required to be held by the user running the function.

## PARAMETERS

    -AppID <String>
        The name of the application for which a new authentication method is being added.

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AuthType <String>
        The tye of authentication.
        Valid Values are machineAddress, osUser, path, hashValue

        Required?                    true
        Position?                    2
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AuthValue <String>
        The content of the authentication.

        Required?                    true
        Position?                    3
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

    PS C:\>Add-PASApplicationAuthenticationMethod -AppID NewApp -AuthType machineAddress
    -AuthValue AppServer1.domain.com

    Adds a Machine Address application authentication mechanism to NewApp




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Add-PASApplicationAuthenticationMethod -AppID NewApp -AuthType osUser
    -AuthValue Domain\SomeUser

    Adds an osUSer application authentication mechanism to NewApp




    -------------------------- EXAMPLE 3 --------------------------

    PS C:\>Add-PASApplicationAuthenticationMethod -AppID NewApp -AuthType path
    -AuthValue SomePath

    Adds path application authentication mechanism to NewApp




    -------------------------- EXAMPLE 4 --------------------------

    PS C:\>Add-PASApplicationAuthenticationMethod -AppID NewApp -AuthType certificateserialnumber
    -AuthValue 040000000000FA3DEFE9A9 -Comment "DEV Cert"

    Adds certificateserialnumber application authentication mechanism to NewApp
