---
external help file: psPAS-help.xml
Module Name: psPAS
online version:
schema: 2.0.0
title: Get-PASReportSetting
---

# Get-PASReportSetting

## SYNOPSIS
Gets report settings

## SYNTAX

```
Get-PASReportSetting -Type <String> [<CommonParameters>]
```

## DESCRIPTION
Gets the default filter values for a report type.

Requires CyberArk Version 15.0 or higher.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-PASReportSetting -Type ActivitiesReport
```

Gets the default filter values for the ActivitiesReport report type

## PARAMETERS

### -Type
The report type

Valid values: ActivitiesReport, ActiveNonActiveSafesReport

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```
### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASReportSetting](https://pspas.pspete.dev/commands/Get-PASReportSetting)
