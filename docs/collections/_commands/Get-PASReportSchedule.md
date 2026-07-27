---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASReportSchedule
schema: 2.0.0
title: Get-PASReportSchedule
---

# Get-PASReportSchedule

## SYNOPSIS
Returns details of available report schedules

## SYNTAX

```
Get-PASReportSchedule [-id <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns all available report schedules for the user

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-PASReportSchedule
```

Returns all report schedules for the user

## PARAMETERS

### -id
When specified, returns a specific report schedule, otherwise returns all the user has access to. 

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
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

[https://pspas.pspete.dev/commands/Get-PASReportSchedule](https://pspas.pspete.dev/commands/Get-PASReportSchedule)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/get-tasks.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/get-tasks.htm)