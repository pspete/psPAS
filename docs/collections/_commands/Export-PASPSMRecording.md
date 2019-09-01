---
title: Export-PASPSMRecording
---

## SYNOPSIS

Saves a PSM Recording

## SYNTAX

    Export-PASPSMRecording [-RecordingID] <String> [-path] <String> [<CommonParameters>]

## DESCRIPTION

Saves a specific recorded session to a file

## PARAMETERS

    -RecordingID <String>
        Unique ID of the recorded PSM session

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -path <String>
        The folder to export the PSM recording to.

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

    PS C:\>Export-PASPSMRecording -RecordingID 123_45 -path C:\PSMRecording.avi

    Saves PSM Recording with Id 123_45 to C:\PSMRecording.avi
