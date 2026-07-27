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
Get-PASReport [-limit <Int32>] [-search <String>] [-filter <String>] [-sort <String>] [-sortDirection <String>]
 [<CommonParameters>]
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
PS C:\> Get-PASReport -filter "status EQ Done AND safe EQ PVWAReports"
```

Returns reports matching the specified filter expression.

### Example 4

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

### -filter

A structured filter expression supporting comparisons, sets, string operations, null checks,
logical composition, and grouping.

Accepted fields: status, createdBy, name, safe

Supported operators:

- Comparison: EQ, NE, GT, GE, LT, LE (numbers/dates; strings compare lexicographically)
- Set: IN, NOTIN
- String: CONTAINS, NOTCONTAINS, STARTSWITH, ENDSWITH
- Null: IS NULL, IS NOTNULL
- Logical: AND, OR
- Grouping: parentheses ( ) for precedence

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASReport](https://pspas.pspete.dev/commands/Get-PASReport)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/get-reports.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/get-reports.htm)
