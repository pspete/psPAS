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
