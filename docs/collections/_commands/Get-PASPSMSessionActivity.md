---
title: Get-PASPSMSessionActivity
---

## SYNOPSIS

Get activity details of Live PSM Sessions

## SYNTAX

    Get-PASPSMSessionActivity [-liveSessionId] <String> [<CommonParameters>]

## DESCRIPTION

Returns activity details of active PSM sessions.

## PARAMETERS

    -liveSessionId <String>
        The ID of an active session to get activities from.

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

    PS C:\>Get-PASPSMSessionActivity -liveSessionId 123_45

    Returns details of activities in active PSM Session with Id 123_45
