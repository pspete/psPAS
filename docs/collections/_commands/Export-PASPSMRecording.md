---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Export-PASPSMRecording
schema: 2.0.0
title: Export-PASPSMRecording
---

# Export-PASPSMRecording

## SYNOPSIS
Saves a PSM Recording

## SYNTAX

```
Export-PASPSMRecording [-RecordingID] <String> [-path] <String> [<CommonParameters>]
```

## DESCRIPTION
Saves a specific recorded session to a file

## EXAMPLES

### EXAMPLE 1
```
Export-PASPSMRecording -RecordingID 123_45 -path C:\PSMRecording.avi
```

Saves PSM Recording with Id 123_45 to C:\PSMRecording.avi

## PARAMETERS

### -RecordingID
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

### -path
The folder to export the PSM recording to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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

[https://pspas.pspete.dev/commands/Export-PASPSMRecording](https://pspas.pspete.dev/commands/Export-PASPSMRecording)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/PlayRecording.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/PlayRecording.htm)
