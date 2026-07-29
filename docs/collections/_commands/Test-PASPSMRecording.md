---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Test-PASPSMRecording
schema: 2.0.0
title: Test-PASPSMRecording
---

# Test-PASPSMRecording

## SYNOPSIS
Determine if a PSM Session / Recording is valid

## SYNTAX

```
Test-PASPSMRecording [-SessionID] <String> [<CommonParameters>]
```

## DESCRIPTION
Determines if a provided PSM Session / Recording is valid.

Returns $True if valid.

## EXAMPLES

### EXAMPLE 1
```
Test-PASPSMRecording -SessionID 334_3
```

Tests validity of recorded PSM Session File

### EXAMPLE 2
```
if (Test-PASPSMRecording -SessionID 334_3) { Export-PASPSMRecording -RecordingID 334_3 -path C:\PSMRecordings\ }
```

Tests validity of the PSM Recording with Id 334_3, and only exports it if it is valid.

### EXAMPLE 3
```
[PSCustomObject]@{SessionID = '334_3'} | Test-PASPSMRecording
```

Tests validity of the PSM Session/Recording with Id 334_3. The SessionID value is passed via the pipeline, by property name.

### EXAMPLE 4
```
'334_3', '335_9', '338_2' | ForEach-Object { Test-PASPSMRecording -SessionID $_ }
```

Tests validity of multiple PSM Session/Recording Ids.

## PARAMETERS

### -SessionID
Unique ID of the recorded PSM session

```yaml
Type: String
Parameter Sets: (All)
Aliases:

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
Minimum CyberArk Version 11.2

## RELATED LINKS

[https://pspas.pspete.dev/commands/Test-PASPSMRecording](https://pspas.pspete.dev/commands/Test-PASPSMRecording)
