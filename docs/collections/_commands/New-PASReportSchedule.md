---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/New-PASReportSchedule
schema: 2.0.0
---

# New-PASReportSchedule

## SYNOPSIS
Creates a new schedule for reports

## SYNTAX

```
New-PASReportSchedule [[-version] <Int32>] [[-type] <String>] [-subType] <String> [-name] <String>
 [-keepTaskDefinition] <Boolean> [[-startTime] <DateTime>] [[-recurrenceType] <String>]
 [[-recurrenceValue] <String>] [[-daysOfWeek] <String>] [[-weekNumber] <String>]
 [[-Subscribers] <Subscriber[]>] [-notifyOnFailure] <Boolean> [<CommonParameters>]
```

## DESCRIPTION
Creates a new schedule for reports

## EXAMPLES

### Example 1
```powershell
PS C:\> New-PASReportSchedule -version 2 -type <String> -subType <String> -name <String>
 -keepTaskDefinition <Boolean> -startTime <DateTime> -recurrenceType <String>
 -recurrenceValue <String> -daysOfWeek <String> -weekNumber <String>
 -Subscribers <Subscriber> -notifyOnFailure <Boolean>
```

Adds a new report schedule

## PARAMETERS

### -version
Task definition version

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -type
Task type.

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

### -subType
Task subtype.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -name
Task name.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -keepTaskDefinition
Keep task definition after execution.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -startTime
Scheduled start time.

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

### -daysOfWeek
Days of the week to trigger the task.

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

### -Subscribers
TODO: Subscriber Class Examples need testing/documenting

```yaml
Type: Subscriber[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -notifyOnFailure
Notify the task creator if execution fails.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: True
Position: 12
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/New-PASReportSchedule](https://pspas.pspete.dev/commands/New-PASReportSchedule)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/create-task.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/create-task.htm)