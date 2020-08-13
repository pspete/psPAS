---
title: Get-PASPTAEvent
---

## SYNOPSIS

    Returns PTA security events

## SYNTAX

    Get-PASPTAEvent [-fromUpdateDate <DateTime>] [-status <String>] [<CommonParameters>]

    Get-PASPTAEvent [-fromUpdateDate <DateTime>] [-status <String>] [-accountID <String>] [<CommonParameters>]

    Get-PASPTAEvent [-lastUpdatedEventDate <DateTime>] [<CommonParameters>]

## DESCRIPTION

    Returns PTA security events

## PARAMETERS

    -fromUpdateDate <DateTime>
        Starting date from which to get security events.
        Requires 11.3

    -status <String>
        The status of the security event (open or closed).
        Requires 11.3

    -accountID <String>
        The unique account identifier of the account relating to the Security Event.
        Requires 11.4

    -lastUpdatedEventDate <DateTime>
        Starting date from which to get security events.

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Get-PASPTAEvent

    Returns all PTA security events




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Get-PASPTAEvent -fromUpdateDate $date

    Returns all PTA security events since $date




    -------------------------- EXAMPLE 3 --------------------------

    PS C:\>Get-PASPTAEvent -status OPEN

    Returns all PTA security events with an Open status.




    -------------------------- EXAMPLE 4 --------------------------

    PS C:\>Get-PASPTAEvent -lastUpdatedEventDate $date

    Returns all PTA security events since $date
