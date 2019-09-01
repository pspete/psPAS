---
title: Get-PASPTAEvent
---

## SYNOPSIS

Returns PTA security events

## SYNTAX

    Get-PASPTAEvent [[-lastUpdatedEventDate] <DateTime>] [<CommonParameters>]

## DESCRIPTION

Returns PTA security events

## PARAMETERS

    -lastUpdatedEventDate <DateTime>
        Parameter description

        Required?                    false
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

    PS C:\>Get-PASPTAEvent

    Returns all PTA security events
