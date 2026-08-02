---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Set-PASReportTask
schema: 2.0.0
title: Set-PASReportTask
---

# Set-PASReportTask

## SYNOPSIS

Updates an existing report schedule

## SYNTAX

```
Set-PASReportTask [-id] <String> [[-name] <String>] [[-keepTaskDefinition] <Boolean>]
 [[-notifyOnFailure] <Boolean>] [[-Subscribers] <PSObject[]>] [[-startTime] <DateTime>]
 [[-recurrenceType] <String>] [[-recurrenceValue] <String>] [[-daysOfWeek] <String>] [[-weekNumber] <String>]
 [[-filters] <PSObject[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Updates an existing report schedule.

A `[Subscriber]` Class has been created to assist with formatting of subscriber data for this request,
and a `[TaskFilter]` Class to assist with formatting filter data - see the examples below.

This command is only available for self-hosted PAS, and requires CyberArk version 14.6 or later.

## EXAMPLES

### Example 1

```powershell
PS C:\> Set-PASReportTask -id 9c91791b-76cf-46c4-a961-b562b9447dc3 -name 'Weekly License Report'
```

Renames the report schedule. The schedule, subscribers, filters and all other properties of the task
are left unchanged.

### Example 2

```powershell
PS C:\> Set-PASReportTask -id 9c91791b-76cf-46c4-a961-b562b9447dc3 -recurrenceType Weekly -recurrenceValue 1 -daysOfWeek '2,4'
```

Updates the schedule to run weekly on Tuesday and Thursday. The existing start time is retained.

### Example 3

```powershell
PS C:\> Get-PASReportTask -name 'Weekly License Report' | Set-PASReportTask -startTime (Get-Date '2026-09-01 02:00') -notifyOnFailure $true
```

Finds the report schedule by name and updates its start time, enabling failure notifications.

### Example 4

```powershell
PS C:\> $LdapInfo = [LdapInfo]::new('cyberark.local', 'CN=pspete,OU=Users,DC=cyberark,DC=local')
PS C:\> $Subscriber = [Subscriber]::new('pspete', 'User', $true, $LdapInfo)
PS C:\> Set-PASReportTask -id 9c91791b-76cf-46c4-a961-b562b9447dc3 -Subscribers $Subscriber
```

Replaces the subscribers of the report schedule, notifying "pspete" of the results.

### Example 5

```powershell
PS C:\> $Filter = [TaskFilter]::new('safe', 'SomeSafe')
PS C:\> Set-PASReportTask -id 9c91791b-76cf-46c4-a961-b562b9447dc3 -filters $Filter
```

Replaces the filters of the report schedule, restricting the report to the "SomeSafe" safe.

### Example 6

```powershell
PS C:\> Set-PASReportTask -id 9c91791b-76cf-46c4-a961-b562b9447dc3 -name 'Some Report' -WhatIf
```

Shows what would happen if the report schedule was updated, without actually updating it.

## PARAMETERS

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Subscribers

The subscribers to notify of the report results.

Any subscribers currently configured on the task are replaced by the supplied value.

Use the `[Subscriber]` Class to format the required data.

```yaml
Type: PSObject[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -daysOfWeek

The days of the week on which the report runs, as a comma separated list of day numbers,
where 0 is Sunday and 6 is Saturday.

Applicable to a weekly recurrence.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -filters

The filters to apply to the report.

Any filters currently configured on the task are replaced by the supplied value.

Use the `[TaskFilter]` Class to format the required data. The filter names accepted by the API
differ per report subType.

```yaml
Type: PSObject[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -id

The unique ID of the report schedule to update.

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

### -keepTaskDefinition

Whether the task definition is retained after the report has been generated.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -name

The name of the report schedule.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -notifyOnFailure

Whether subscribers are notified if report generation fails.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -recurrenceType

Recurrence type.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -recurrenceValue

Frequency multiplier (e.g. every 2 weeks).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -startTime

Scheduled start time.

Must be later than the current date and time, otherwise the API returns an error.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -weekNumber

Week number for monthly recurrence.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe objects with an `id` property to this command, such as the output of `Get-PASReportTask`.

## OUTPUTS

### psPAS.CyberArk.Vault.Task

## NOTES

Minimum CyberArk version 14.6. Self-hosted PAS only.

`-Subscribers` and `-filters` replace the current values in full rather than adding to them.
To add to the existing collections, read the current values from `Get-PASReportTask` first.

`-daysOfWeek` is supplied as day numbers, but the API returns the configured days as names
(for example `Monday`).

The API validates the schedule against the configured recurrence, and may move `startTime`
forward to the next occurrence which satisfies `-daysOfWeek`.

## RELATED LINKS

[https://pspas.pspete.dev/commands/Set-PASReportTask](https://pspas.pspete.dev/commands/Set-PASReportTask)

[https://pspas.pspete.dev/commands/Get-PASReportTask](https://pspas.pspete.dev/commands/Get-PASReportTask)

[https://pspas.pspete.dev/commands/New-PASReportTask](https://pspas.pspete.dev/commands/New-PASReportTask)

[https://pspas.pspete.dev/commands/Remove-PASReportTask](https://pspas.pspete.dev/commands/Remove-PASReportTask)
