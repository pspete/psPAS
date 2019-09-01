---
title: Get-PASSession
---

## SYNOPSIS

Returns information related to the authenticated session

## SYNTAX

    Get-PASSession [<CommonParameters>]

## DESCRIPTION

For the current session, returns data from the module scope:

- Username relating to the session.
- BaseURI: URL value used for sending requests to the API.
- ExternalVersion: PAS version information.
- Websession: Contains Authorization Header, Cookie & Certificate data related to the current session.

The session information can be saved a variable accessible outside of the module scope for use in requests outside
of psPAS.

## PARAMETERS

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Show current session related information

    Get-PASSession




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Save current session related information

    $session = Get-PASSession




    -------------------------- EXAMPLE 3 --------------------------

    PS C:\>Use session information for Invoke-RestMethod command

    $session = Get-PASSession

    Invoke-RestMethod -Method GET -Uri "$session.BaseURI/SomePath" -WebSession $session.WebSession
