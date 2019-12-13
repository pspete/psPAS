---
title: Get-PASPlatform
---

## SYNOPSIS

Retrieves details of Vault platforms.

## SYNTAX

    Get-PASPlatform [-Active <Boolean>] [-PlatformType <String>] [-Search <String>] [<CommonParameters>]

    Get-PASPlatform -PlatformID <String> [<CommonParameters>]

## DESCRIPTION

Request platform configuration information from the Vault.

11.1+ can return details of all platforms.
Filters can be used to retrieve a subset of the platforms

For 9.10+, the "PlatformID" parameter must be used to retrieve details of a single
specified platform from the Vault.

The output contained under the "Details" property differs depending
on which method (9.10+ or 11.1+) is used.

## PARAMETERS

    -Active <Boolean>
        Filter active/inactive platforms

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -PlatformType <String>
        Filter regular/group platforms

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Search <String>
        Filter platform by search pattern

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -PlatformID <String>
        The unique ID/Name of the platform.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## NOTES

        Minimum CyberArk version 9.10
        CyberArk version 11.1 required for Active, PlatformType & Search paramters.

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Get-PASPlatform

    Return details of all platforms




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Get-PASPlatform -Active $true

    Get all active platforms




    -------------------------- EXAMPLE 3 --------------------------

    PS C:\>Get-PASPlatform -Active $true -Search "WIN_"

    Get active platforms matching search string "WIN_"




    -------------------------- EXAMPLE 4 --------------------------

    PS C:\>Get-PASPlatform -PlatformID "CyberArk"

    Get details of specific platform CyberArk
