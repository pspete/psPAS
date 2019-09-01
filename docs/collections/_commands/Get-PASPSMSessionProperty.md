---
title: Get-PASPSMSessionProperty
---

## SYNOPSIS

Get property details of PSM Session

## SYNTAX

    Get-PASPSMSessionProperty [-liveSessionId] <String> [<CommonParameters>]

## DESCRIPTION

Returns the property details of an active PSM session.

## PARAMETERS

    -liveSessionId <String>
        The ID of an active session to get properties of.

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

    PS C:\>Get-PASPSMSessionProperty -liveSessionId 123_45

    Returns details of activities in PSM Recording with Id 123_45
