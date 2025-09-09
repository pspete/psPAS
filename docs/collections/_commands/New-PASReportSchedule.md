---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/New-PASReportSchedule
schema: 2.0.0
title: New-PASReportSchedule
---

# New-PASReportSchedule

## SYNOPSIS
Creates a new schedule for reports

## SYNTAX

```
New-PASReportSchedule [[-version] <Int32>] [[-type] <String>] [-subType] <String> [-name] <String>
 [-keepTaskDefinition] <Boolean> [[-startTime] <DateTime>] [[-recurrenceType] <String>]
 [[-recurrenceValue] <String>] [[-daysOfWeek] <String>] [[-weekNumber] <String>]
 [[-Subscribers] <Subscriber[]>] [-notifyOnFailure] <Boolean> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a new schedule for reports

A `[Subscriber]` Class has been created to assist witho formatting of data for this request, see the example below

## EXAMPLES

### Example 1
```powershell
PS C:\> $Subscriber = [Subscriber]::AddSubscriber()
Enter subscriber name: pspete
Enter subscriber type: User
Notify on success? (true/false): true
Add LDAP info? (yes/no): yes
Enter LDAP directory name: PSPETE.DEV
Enter full DN:

 > $Subscriber

name   type notifyOnSuccess ldapInfo
----   ---- --------------- --------
pspete User            True LdapInfo

PS C:\> New-PASReportSchedule -version 1 -type 'Report' -subType 'CyberArk.Reports.LicenseCapacityReport.LicenseCapacityReportUI' `
-name 'Some Report' -keepTaskDefinition $true -Subscribers $Subscriber -notifyOnFailure $True$
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
Create definition for one or more subscribers using the `[Subscriber]` Class.

`[Subscriber]::AddSubscriber()` interactively prompts for required details.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/New-PASReportSchedule](https://pspas.pspete.dev/commands/New-PASReportSchedule)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/create-task.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/create-task.htm)
