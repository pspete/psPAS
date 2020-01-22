---
title: Test-PASPSMRecording
---

## SYNOPSIS

    Determine if a PSM Session / Recording is valid

## SYNTAX

    Test-PASPSMRecording [-SessionID] <String> [<CommonParameters>]

## DESCRIPTION

    Determines if a provided PSM Session / Recording is valid.
    Returns $True if valid.

## PARAMETERS

    -SessionID <String>
        Unique ID of the recorded PSM session

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

        Minimum CyberArk Version 11.2

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Test-PASPSMRecording -SessionID 334_3

    Tests validity of recorded PSM Session File
