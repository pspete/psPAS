---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASReportActivity
schema: 2.0.0
title: Get-PASReportActivity
---

# Get-PASReportActivity

## SYNOPSIS

Returns the activity groups and activities available for use in reports

## SYNTAX

```
Get-PASReportActivity [[-Type] <String>] [<CommonParameters>]
```

## DESCRIPTION

Returns the list of activity groups available for reports, and the activities within
each group. The response is intended to populate filters or selection lists in reporting
features.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PASReportActivity
```

Returns all available activity groups and their activities.

### Example 2

```powershell
PS C:\> Get-PASReportActivity -Type ActivitiesReport
```

Returns activity groups and activities scoped to the ActivitiesReport report type.

## PARAMETERS

### -Type

The type of report to return activity groups/activities for.

This is not the same as the activityGroup values returned in the response.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: ActivitiesReport, ActiveNonActiveSafesReport

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### psPAS.CyberArk.Vault.Report.ActivityGroup

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASReportActivity](https://pspas.pspete.dev/commands/Get-PASReportActivity)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/rest-api-get-reportparams-activities.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/rest-api-get-reportparams-activities.htm)
