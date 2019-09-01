---
title: Resume-PASPSMSession
---

## SYNOPSIS

Resumes a Suspended PSM Session.

## SYNTAX

    Resume-PASPSMSession [-LiveSessionId] <String>

## DESCRIPTION

Resumes a suspended, active PSM session, identified by the unique ID of the PSM Session, allowing a privileged user to continue working.

## PARAMETERS

    -LiveSessionId <String>
        The unique ID/SessionGuid of a Suspended PSM Session.

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

    PS C:\>Resume-PASPSMSession -LiveSessionId $SessionUUID

    Terminates Live PSM Session identified by the session UUID.
