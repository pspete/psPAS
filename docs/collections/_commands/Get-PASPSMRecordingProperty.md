---
title: Get-PASPSMRecordingProperty
---

## SYNOPSIS

Get property details of PSM Recordings

## SYNTAX

    Get-PASPSMRecordingProperty [-RecordingID] <String> [<CommonParameters>]

## DESCRIPTION

Returns the property details of a recorded session.

## PARAMETERS

    -RecordingID <String>
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

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Get-PASPSMRecordingProperty -RecordingID 123_45

    Returns details of activities in PSM Recording with Id 123_45
