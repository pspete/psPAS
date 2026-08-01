---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASReport
schema: 2.0.0
title: Get-PASReport
---

# Get-PASReport

## SYNOPSIS

Returns a list of available reports

## SYNTAX

```
Get-PASReport [-limit <Int32>] [-search <String>] [-sort <String>] [-sortDirection <String>]
 [-createdBy <String>] [-name <String>] [-records <String>] [-status <String>] [-type <String>]
 [-FilterLogicalOperator <String>] [<CommonParameters>]
```

## DESCRIPTION

Returns a list of reports available to the authenticated user

All matching reports are returned; if the API paginates the results across multiple
pages, subsequent pages are requested automatically.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PASReport
```

Returns a list of all available reports

### Example 2

```powershell
PS C:\> Get-PASReport -search "Accounts" -limit 10
```

Returns all reports with a name, description, reportType, or (where available) human-readable status/category
field matching the term "Accounts", requesting 10 results per page.

### Example 3

```powershell
PS C:\> Get-PASReport -status Done -createdBy pspete
```

Returns reports with a status of Done, created by the user pspete.

### Example 4

```powershell
PS C:\> Get-PASReport -status Done -type InventoryReports.InventoryReportUI -FilterLogicalOperator OR
```

Returns reports with a status of Done, or a type of InventoryReports.InventoryReportUI.

### Example 5

```powershell
PS C:\> Get-PASReport -sort CreatedAt -sortDirection desc
```

Returns reports sorted by their creation date, most recently created first.

## PARAMETERS

### -limit

The number of reports to return on one page.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -search

A simple, case-insensitive keyword search.

Searches across name, description, createdBy, status, and statusAdditionalInfo.

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

### -sort

The property to sort returned reports by.

Valid Values:
- CreatedAt

Undocumented by CyberArk; observed from PVWA browser network traffic.
CreatedAt is the only property confirmed to work; other properties were tried and did not sort as expected.

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

### -sortDirection

The direction to sort reports in, when a value for sort is also specified.

When desc is specified, the sort value is prefixed with "-" to request descending order.
When not specified, ascending order is used.

Undocumented by CyberArk; observed from PVWA browser network traffic.

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

### -createdBy

Filters reports by the username of the report's creator.

Only the EQ operator is supported; other operators are rejected by the API.
Undocumented by CyberArk; observed to map to the internal field name TaskUsername.

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

### -name

Filters reports by report name.

Only the EQ operator is supported; other operators are rejected by the API.
Undocumented by CyberArk; observed to map to the internal field name TaskName.

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

### -records

Filters reports by the number of records they contain.

Only the EQ operator is supported; other operators are rejected by the API.
Undocumented by CyberArk; observed to map to the internal field name ReportNumberOfRecords.

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

### -status

Filters reports by generation status (e.g. Done).

Only the EQ operator is supported; other operators are rejected by the API.
Undocumented by CyberArk; observed to map to the internal field name TaskStatus.

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

### -type

Filters reports by report type.

Only the EQ operator is supported; other operators are rejected by the API.
Undocumented by CyberArk; observed to map to the internal field name TaskSubtype.

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

### -FilterLogicalOperator

The logical operator (AND/OR) used to combine multiple filter parameters, when more than one
of createdBy, name, records, status, or type is specified together. Defaults to AND.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: AND
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### psPAS.CyberArk.Vault.Report

## NOTES

Undocumented by CyberArk; the API's filter parameter was tested against every property returned
by this command. Only createdBy, name, records, status, and type are accepted as filter fields,
and each only supports the EQ operator - all other documented operators (NE, GT, GE, LT, LE, IN,
NOTIN, CONTAINS, NOTCONTAINS, STARTSWITH, ENDSWITH, IS NULL, IS NOTNULL) are rejected by the API
for these fields.

createdAt and size are recognized by the API (errors reference their internal field names,
CreatedAt and FileSize) but reject every operator tried, so neither is usable as a filter field
at this time.

duration, filename, filters, isScheduled, lastUsedAt, lastUsedBy, location, safe, statusAdditionalInfo,
and taskId are not recognized as filter fields at all.

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASReport](https://pspas.pspete.dev/commands/Get-PASReport)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/get-reports.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/get-reports.htm)
