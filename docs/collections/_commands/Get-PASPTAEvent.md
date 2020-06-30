---
title: Get-PASPTAEvent
---

## SYNOPSIS

Returns PTA security events

## SYNTAX

    Get-PASPTAEvent [-lastUpdatedEventDate <DateTime>] [-status <String>] [-accountID <String>] [<CommonParameters>]

    Get-PASPTAEvent [-lastUpdatedEventDate <DateTime>] [-UseLegacyMethod] [<CommonParameters>]

## DESCRIPTION

    Returns PTA security events

## PARAMETERS

    -lastUpdatedEventDate <DateTime>
        Starting date from which to get security events.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -status <String>
        The status of the security event (open or closed).
        Requires 11.4

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -accountID <String>
        The unique account identifier of the account relating to the Security Event.
        Requires 11.4

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UseLegacyMethod [<SwitchParameter>]
        Specify to send lastUpdatedEventDate using legacy method
        Requires 11.4

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Get-PASPTAEvent

    Returns all PTA security events




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Get-PASPTAEvent -lastUpdatedEventDate $date

    Returns all PTA security events since $date




    -------------------------- EXAMPLE 3 --------------------------

    PS C:\>Get-PASPTAEvent -status OPEN

    Returns all PTA security events with an Open status.




    -------------------------- EXAMPLE 4 --------------------------

    PS C:\>Get-PASPTAEvent -lastUpdatedEventDate $date -UseLegacyMethod

    Returns all PTA security events since $date