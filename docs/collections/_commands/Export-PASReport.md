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
Export-PASReport [-data] <String> [-ReportFormat] <String> [-path] <String> [<CommonParameters>]
```

## DESCRIPTION
Exports a report to an Excel or CSV

## EXAMPLES

### Example 1
```powershell
PS C:\> Export-PASReport -data TBC -ReportFormat XLSX -path C:\Temp\
```

Exports a report in XLSX format

### Example 2
```powershell
PS C:\> Export-PASReport -data TBC -ReportFormat XLS -path C:\Temp\
```

Exports a report in XLS format

### Example 3
```powershell
PS C:\> Export-PASReport -data TBC -ReportFormat CSV -path C:\Temp\
```

Exports a report in CSV format

## PARAMETERS

### -data
String containing the report parameters

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
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -path
The path to save the report to

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Add-PASUserAllowedAuthenticationMethod](https://pspas.pspete.dev/commands/Export-PASReport)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/download-report.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/download-report.htm)