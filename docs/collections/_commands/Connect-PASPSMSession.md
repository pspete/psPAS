---
title: Connect-PASPSMSession
---

## SYNOPSIS

Connect to Live PSM Sessions

## SYNTAX

    Connect-PASPSMSession [-SessionId] <String> [-ConnectionMethod] <String> [<CommonParameters>]

## DESCRIPTION

Returns connection data necessary to monitor an active PSM session.

## PARAMETERS

    -SessionId <String>
        The unique ID of the PSM Live Session.

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ConnectionMethod <String>
        The expected parameters to be returned, either RDP or PSMGW.

        Required?                    true
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

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Connect-PASPSMSession -LiveSessionId $SessionUUID -ConnectionMethod RDP

    Returns parameters to connect to Live PSM Session via RDP.




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Connect-PASPSMSession -LiveSessionId $SessionUUID -ConnectionMethod PSMGW

    Returns parameters to connect to Live PSM Session via HTML5 GW.
