---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/New-PASReportTask
schema: 2.0.0
title: New-PASReportTask
---

# New-PASReportTask

## SYNOPSIS

Creates a new schedule for reports

## SYNTAX

```
New-PASReportTask [[-version] <Int32>] [[-type] <String>] [-subType] <String> [-name] <String>
 [-keepTaskDefinition] <Boolean> [[-startTime] <DateTime>] [[-recurrenceType] <String>]
 [[-recurrenceValue] <String>] [[-daysOfWeek] <String>] [[-weekNumber] <String>]
 [[-Subscribers] <Subscriber[]>] [-notifyOnFailure] <Boolean> [-Filters <TaskFilter[]>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

Creates a new schedule for reports

A `[Subscriber]` Class has been created to assist witho formatting of data for this request, see the example below

A `[TaskFilter]` Class has been created to assist with formatting filter data for report tasks

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

PS C:\> New-PASReportTask -version 1 -type 'Report' -subType 'CyberArk.Reports.LicenseCapacityReport.LicenseCapacityReportUI' `
-name 'Some Report' -keepTaskDefinition $true -Subscribers $Subscriber -notifyOnFailure $True$
```

Adds a new report schedule

### Example 2

```powershell
PS C:\> $LdapInfo = [LdapInfo]::new('cyberark.local', 'CN=pspete,OU=Users,DC=cyberark,DC=local')
PS C:\> $Subscriber = [Subscriber]::new('pspete', 'User', $true, $LdapInfo)
PS C:\> New-PASReportTask -subType 'CyberArk.Reports.LicenseCapacityReport.LicenseCapacityReportUI' -name 'Weekly License Report' `
-keepTaskDefinition $true -startTime (Get-Date '02:00') -recurrenceType Weekly -recurrenceValue 1 -daysOfWeek '1,3,5' `
-Subscribers $Subscriber -notifyOnFailure $true
```

Creates a report schedule that runs weekly on Monday, Wednesday and Friday, non-interactively building the subscriber and LDAP info objects and notifying "pspete" of the results.

### Example 3

```powershell
PS C:\> New-PASReportTask -subType 'CyberArk.Reports.LicenseCapacityReport.LicenseCapacityReportUI' -name 'Some Report' `
-keepTaskDefinition $true -notifyOnFailure $false -WhatIf
```

Shows what would happen if the report schedule was created, without actually creating it.

### Example 4

```powershell
PS C:\> $Filter = [TaskFilter]::new('SomeColumn', 'SomeValue')
PS C:\> New-PASReportTask -subType 'CyberArk.Reports.ActivitiesReport.ActivitiesReportUI' -name 'Filtered Activity Report' `
-keepTaskDefinition $true -notifyOnFailure $false -Filters $Filter
```

Creates a report schedule with a filter applied, restricting the report to rows where "SomeColumn" matches "SomeValue".

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

### -Filters

Create definition for one or more report filters using the `[TaskFilter]` Class.

Only applicable to report tasks; each filter narrows the report by a name/value pair
matching one of the columns available in the underlying report.

The set of valid filter names differs per subType - see NOTES. A filter name not
documented for the specified subType generates a warning, but is still sent to the API.

Requires CyberArk version 15.0 or later.

```yaml
Type: TaskFilter[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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
Position: 10
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

Days of the week to trigger the task.

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

### -keepTaskDefinition

Keep task definition after execution.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: False
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
Position: 3
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
Position: 11
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
Position: 6
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
Position: 7
Default value: None
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
Position: 5
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
Accepted values: InventoryReports.InventoryReportUI, CyberArk.Reports.ApplicationReports.ApplicationReportUI, InventoryReports.ComplianceReportUI, CyberArk.Reports.EntitlementReport.EntitlementReportUI, CyberArk.Reports.ActivitiesReport.ActivitiesReportUI, CyberArk.Reports.LicenseCapacityReport.LicenseCapacityReportUI, CyberArk.Reports.UsersReport.UsersListReportUI, CyberArk.Reports.ActiveNonActiveSafesReport.ActiveNonActiveSafesReportUI, CyberArk.Reports.OwnersListReport.OwnersListReportUI

Required: True
Position: 2
Default value: None
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
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -version

Task definition version

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: 0
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
Position: 9
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

The filter names accepted by the `-Filters` parameter differ per report `-subType`. The
following names are documented by CyberArk for each subType; anything else generates a
warning (not an error) since CyberArk may support filters here which are not yet reflected
in this list:

- InventoryReports.InventoryReportUI (Privileged accounts): accountName, deviceType,
  platformId, numberOfDays, activitiesOption, onlyAccountsWithFailures, onlyDisabledAccounts,
  freeSearch, group, includeServiceAccounts, safe
- CyberArk.Reports.ApplicationReports.ApplicationReportUI (Applications): freeSearch,
  includeSubLocations, location
- InventoryReports.ComplianceReportUI (Compliance Status): accountName, deviceType,
  platformId, numberOfDays, activitiesOption, onlyAccountsWithFailures, onlyDisabledAccounts,
  freeSearch, accountChangeMode, expiresIn, expireOption, includeAboutToExpire,
  onlyExpiredAccounts, safe
- CyberArk.Reports.EntitlementReport.EntitlementReportUI (Entitlement): includeCommandPermissions,
  includeSubLocations, location, safe, includeDisabledUsers, includeGroups, targetAccount,
  targetPolicyID, targetSystem, userOrGroup, userType
- CyberArk.Reports.ActivitiesReport.ActivitiesReportUI (Activity log): activitiesFilter,
  clientId, displayOnlyAlerts, includeSubLocations, historyOptions, actionsInPrevDays,
  historyFromDate, historyToDate, location, safe, userType, includeDeletedUsers, requestId,
  targetAccount, targetPolicyID, targetSystem, userOrGroup
- CyberArk.Reports.LicenseCapacityReport.LicenseCapacityReportUI (License capacity): none
- CyberArk.Reports.UsersReport.UsersListReportUI (Users): includeDisabledUsers,
  includeSubLocations, historyOptions, actionsInPrevDays, historyFromDate, historyToDate,
  location, userOrGroup, userActivityType
- CyberArk.Reports.ActiveNonActiveSafesReport.ActiveNonActiveSafesReportUI (Safes):
  activitiesFilter, ignoreBackupActivities, includeSubLocations, historyOptions,
  actionsInPrevDays, historyFromDate, historyToDate, location, safe, safeType
- CyberArk.Reports.OwnersListReport.OwnersListReportUI (Owners): safe, userOrGroup

For the `activitiesFilter` filter (Activity log and Safes subTypes), the value is a
comma-separated list of activity `code`s. Use `Get-PASReportActivity` to look up the
available activity groups/codes for the connected environment.

## RELATED LINKS

[https://pspas.pspete.dev/commands/New-PASReportTask](https://pspas.pspete.dev/commands/New-PASReportTask)

[https://pspas.pspete.dev/commands/Get-PASReportActivity](https://pspas.pspete.dev/commands/Get-PASReportActivity)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/create-task.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/create-task.htm)
