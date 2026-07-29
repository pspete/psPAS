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

### EXAMPLE 2
```
Export-PASPSMRecording -RecordingID 123_45 -path C:\PSMRecordings\
```

Saves PSM Recording with Id 123_45 into the C:\PSMRecordings\ folder, using the recording's original file name.

### EXAMPLE 3
```
Get-PASPSMRecording -RecordingID 123_45 | Export-PASPSMRecording -path C:\PSMRecordings\
```

Gets the PSM Recording with Id 123_45, and saves it to the C:\PSMRecordings\ folder. The RecordingID is passed via the pipeline.

### EXAMPLE 4
```
Get-PASPSMRecording -Safe Win-Safe -FromTime (Get-Date).AddDays(-1) | Export-PASPSMRecording -path C:\PSMRecordings\
```

Saves every PSM Recording created on the Win-Safe safe in the last 24 hours to the C:\PSMRecordings\ folder.

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
The path to save the PSM recording to.
If the path includes a file name and extension, the recording is saved to that exact file; otherwise the path is treated as a destination folder.

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
