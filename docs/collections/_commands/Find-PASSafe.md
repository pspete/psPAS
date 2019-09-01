---
title: Find-PASSafe
---

## SYNOPSIS

Returns safe list from the vault.

## SYNTAX

    Find-PASSafe [[-search] <String>] [[-TimeoutSec] <Int32>] [<CommonParameters>]

## DESCRIPTION

Returns abbreviated details for all safes

## PARAMETERS

    -search <String>
        List of keywords, separated with a space.

        Required?                    false
        Position?                    1
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -TimeoutSec <Int32>
        See Invoke-WebRequest
        Specify a timeout value in seconds

        Required?                    false
        Position?                    2
        Default value                0
        Accept pipeline input?       false
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## NOTES

This API is largely undocumented, but appears to be available since V10
The documentation mentions no body parameters, but search/offset/limit/sort(NYI)/filter(NYI) seem to work
It returns results faster than the v9 API (invoked with Get-PASSafe) but has a vastly different return object
Recommended Use:  Use this to search for safes many quickly, then use Get-PASSafe to get full details about
individual account.

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Find-PASSafe

    Returns details of all safes which the user has access to.




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Find-PASSafe -search "xyz abc"

    Returns details of all matching safes which the user has access to.
