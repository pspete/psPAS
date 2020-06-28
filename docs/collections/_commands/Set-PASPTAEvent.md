---
title: Set-PASPTAEvent
---

## SYNOPSIS

Updates the status of a security event

## SYNTAX

    Set-PASPTAEvent [-EventID] <String> [[-mStatus] <String>] [<CommonParameters>]

## DESCRIPTION

    Updates the status of a security event to open or closed

## PARAMETERS

    -EventID <String>
        The event ID.

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -mStatus <String>
        The status to update (open or closed).

        Required?                    false
        Position?                    2
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

        Minimum Version CyberArk 11.3

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Set-PASPTAEvent -EventID $id