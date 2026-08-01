---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASReportTask
schema: 2.0.0
title: Get-PASReportTask
---

# Get-PASReportTask

## SYNOPSIS

Returns details of available report schedules

## SYNTAX

### byQuery (Default)
```
Get-PASReportTask [-search <String>] [-subType <String>] [-name <String>] [-FilterLogicalOperator <String>]
 [-limit <Int32>] [<CommonParameters>]
```

### byID
```
Get-PASReportTask [-id <String>] [<CommonParameters>]
```

## DESCRIPTION

Returns all available report schedules (tasks) for the user

All matching tasks are returned; if the API paginates the results across multiple
pages, subsequent pages are requested automatically.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PASReportTask
```

Returns all report schedules for the user

### Example 2

```powershell
PS C:\> Get-PASReportTask -id 6b35d0ae-4fc2-4a30-ab2e-89a944cf4b10
```

Returns the specified report schedule

### Example 3

```powershell
PS C:\> Get-PASReportTask -search "Privileged accounts" -limit 10
```

Returns all report schedules matching the term "Privileged accounts", requesting 10 results per page.

### Example 4

```powershell
PS C:\> Get-PASReportTask -subType InventoryReports.InventoryReportUI
```

Returns report schedules of the InventoryReports.InventoryReportUI subtype.

## PARAMETERS

### -FilterLogicalOperator

The logical operator (AND/OR) used to combine multiple filter parameters, when both
subType and name are specified together. Defaults to AND.

```yaml
Type: String
Parameter Sets: byQuery
Aliases:
Accepted values: AND, OR

Required: False
Position: Named
Default value: AND
Accept pipeline input: False
Accept wildcard characters: False
```

### -id

When specified, returns a specific report schedule, otherwise returns all the user has access to.

```yaml
Type: String
Parameter Sets: byID
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -limit

The number of report schedules to return on one page.

```yaml
Type: Int32
Parameter Sets: byQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -name

Filters report schedules by task name.

Only the EQ operator is supported; other operators are rejected by the API.

```yaml
Type: String
Parameter Sets: byQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -search

A simple, case-insensitive keyword search across common textual fields.

```yaml
Type: String
Parameter Sets: byQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -subType

Filters report schedules by task subtype.

Only the EQ operator is supported; other operators are rejected by the API.

```yaml
Type: String
Parameter Sets: byQuery
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

### psPAS.CyberArk.Vault.Task

## NOTES

Undocumented by CyberArk; the API's filter parameter was tested against every property returned
by this command. Only subType and name are accepted as filter fields, and each only supports the
EQ operator - other operators were not exhaustively tested.

folder, type, keepTaskDefinition, notifyOnFailure, createdAt, createdBy, lastModifiedAt,
lastModifiedBy, schedule, subscribers, and filters are all rejected by the API as filter fields,
despite being returned in the response body.

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASReportTask](https://pspas.pspete.dev/commands/Get-PASReportTask)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/get-tasks.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/get-tasks.htm)
