---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASPSMRecordingProperty
schema: 2.0.0
title: Get-PASPSMRecordingProperty
---

# Get-PASPSMRecordingProperty

## SYNOPSIS
Get property details of PSM Recordings

## SYNTAX

```
Get-PASPSMRecordingProperty [-RecordingID] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the property details of a recorded session.

## EXAMPLES

### EXAMPLE 1
```
Get-PASPSMRecordingProperty -RecordingID 123_45
```

Returns details of activities in PSM Recording with Id 123_45

### EXAMPLE 2
```
Get-PASPSMRecordingProperty -SessionID 123_45
```

Returns the property details of PSM Recording with Id 123_45, using the SessionID alias for the RecordingID parameter.

### EXAMPLE 3
```
Get-PASPSMRecording -RecordingID 123_45 | Get-PASPSMRecordingProperty
```

Gets the PSM Recording with Id 123_45, and returns its property details. The RecordingID is passed via the pipeline.

### EXAMPLE 4
```
Get-PASPSMRecording -Safe Win-Safe -FromTime (Get-Date).AddDays(-1) | Get-PASPSMRecordingProperty
```

Returns property details for every PSM Recording created on the Win-Safe safe in the last 24 hours.

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

[https://pspas.pspete.dev/commands/Get-PASPSMRecordingProperty](https://pspas.pspete.dev/commands/Get-PASPSMRecordingProperty)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetRecordingProperties.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetRecordingProperties.htm)
