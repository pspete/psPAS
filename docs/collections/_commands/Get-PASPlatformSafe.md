---
title: Get-PASPlatformSafe
---

## SYNOPSIS

Get safes by platform id

## SYNTAX

    Get-PASPlatformSafe [-PlatformID] <String> [<CommonParameters>]

## DESCRIPTION

Returns all safes for a given platform ID

## PARAMETERS

    -PlatformID <String>
        The unique ID/Name of the platform.

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

NOTES

        Minimum CyberArk version 11.1

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Get-PASPlatformSafe -PlatformID WINDOMAIN
