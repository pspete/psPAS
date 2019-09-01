---
title: Stop-PASPSMSession
---

## SYNOPSIS

Terminates a Live PSM Session.

## SYNTAX

    Stop-PASPSMSession [-LiveSessionId] <String>

## DESCRIPTION

Terminates a Live PSM Session identified by the unique ID of the PSM Session.

## PARAMETERS

    -LiveSessionId <String>
        The unique ID/SessionGuid of a Live PSM Session.

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -WhatIf [<SwitchParameter>]

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -Confirm [<SwitchParameter>]

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Stop-PASPSMSession -LiveSessionId $SessionUUID

    Terminates Live PSM Session identified by the session UUID.
