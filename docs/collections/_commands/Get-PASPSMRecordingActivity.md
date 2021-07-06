---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASPSMRecordingActivity
schema: 2.0.0
title: Get-PASPSMRecordingActivity
---

# Get-PASPSMRecordingActivity

## SYNOPSIS
Get activity details of PSM Recordings

## SYNTAX

```
Get-PASPSMRecordingActivity [-RecordingID] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns activity details of a PSM recording.

## EXAMPLES

### EXAMPLE 1
```
Get-PASPSMRecordingActivity -RecordingID 123_45
```

Returns details of activities in PSM Recording with Id 123_45

## PARAMETERS

### -RecordingID
Unique ID of the recorded PSM session

```yaml
Type: String
Parameter Sets: (All)
Aliases: SessionID

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Minimum CyberArk Version 10.6

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASPSMRecordingActivity](https://pspas.pspete.dev/commands/Get-PASPSMRecordingActivity)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetRecordingActivities.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetRecordingActivities.htm)
