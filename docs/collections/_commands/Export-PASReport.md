---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Export-PASReport
schema: 2.0.0
---

# Export-PASReport

## SYNOPSIS
Exports a report to an Excel or CSV

## SYNTAX

```
Export-PASReport -Safe <String> -Folder <String> -FileName <String> -Type <String> [-ReportFormat] <String>
 [-path] <String> [<CommonParameters>]
```

## DESCRIPTION
Exports a report to an Excel or CSV

## EXAMPLES

### Example 1
```powershell
PS C:\> Export-PASReport -Safe 'PVWAReports' -Folder 'Root\33' `
    -FileName 'InventoryReports.InventoryReportUI_2025-09-07_180314.094.xml' `
    -Type 'InventoryReports.InventoryReportUI' -ReportFormat XLSX -path C:\Temp\
```

Exports a report in XLSX format

### Example 2
```powershell
PS C:\> Export-PASReport -Safe 'PVWAReports' -Folder 'Root\33' `
    -FileName 'InventoryReports.InventoryReportUI_2025-09-07_180314.094.xml' `
    -Type 'InventoryReports.InventoryReportUI' -ReportFormat XLS -path C:\Temp\
```

Exports a report in XLS format

### Example 3
```powershell
PS C:\> Export-PASReport -Safe 'PVWAReports' -Folder 'Root\33' `
    -FileName 'InventoryReports.InventoryReportUI_2025-09-07_180314.094.xml' `
    -Type 'InventoryReports.InventoryReportUI' -ReportFormat CSV -path C:\Temp\Report.csv
```

Exports a report in CSV format

## PARAMETERS

### -ReportFormat
The format to export the report in
- XLSX
- XLS
- CSV

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -path
The path to save the report to

For CSV reports, the path must include the required filename.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FileName
The name of the report file to export from the Report Safe

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

### -Folder
The folder in the Report Safe the report is stored in

```yaml
Type: String
Parameter Sets: (All)
Aliases: location

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Safe
The Safe the report is stored in

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

### -Type
The Type name of the report to be exported

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

[https://pspas.pspete.dev/commands/Add-PASUserAllowedAuthenticationMethod](https://pspas.pspete.dev/commands/Export-PASReport)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/download-report.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/download-report.htm)
