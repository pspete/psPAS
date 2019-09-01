---
title: Get-PASSafe
---

## SYNOPSIS

Returns safe details from the vault.

## SYNTAX

    Get-PASSafe [-FindAll] [-TimeoutSec <Int32>] [<CommonParameters>]

    Get-PASSafe [-SafeName <String>] [-TimeoutSec <Int32>] [<CommonParameters>]

    Get-PASSafe [-query <String>] [-TimeoutSec <Int32>] [<CommonParameters>]

## DESCRIPTION

Gets safe by SafeName, by search query string, or, by default will return all safes.

## PARAMETERS

    -SafeName <String>
        The name of a specific safe to get details of.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -query <String>
        Query String for safe search in the vault

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -FindAll [<SwitchParameter>]
        Specify to find all safes.
        If SafeName or query are not specified, FindAll is the default behaviour.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -TimeoutSec <Int32>
        See Invoke-WebRequest
        Specify a timeout value in seconds

        Required?                    false
        Position?                    named
        Default value                0
        Accept pipeline input?       false
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Get-PASSafe -SafeName SAFE1

    Returns details of "Safe1"
