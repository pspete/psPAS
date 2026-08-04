---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Add-PASDiscoveryScan
schema: 2.0.0
title: Add-PASDiscoveryScan
---

# Add-PASDiscoveryScan

## SYNOPSIS

Creates a discovery scan in the Vault.

## SYNTAX

```
Add-PASDiscoveryScan [-scanType] <String> [-scanCredentials] <Object[]> [[-discoveryName] <String>]
 [-managingScanner] <String> [[-scheduleInformation] <Object>] [[-csvFile] <String>] [[-fileName] <String>]
 [[-scanProperties] <Hashtable>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Creates an Active Directory or CSV-file discovery scan in the Vault.

Requires CyberArk Self-Hosted version 12.2 or higher.

## EXAMPLES

### Example 1

```powershell
$scanCredentials = @{
    scanAccountId = '538_3'
}
$scheduleInformation = @{ daysOfWeek = @('Sunday'); time = '18:00:00' }
$scanProperties = @{ domainName = 'contoso.com'; OU = 'All OUs'; useSecureProtocol = $true }

Add-PASDiscoveryScan -scanType ActiveDirectory -scanCredentials $scanCredentials `
    -discoveryName 'Windows domain discovery' -managingScanner PasswordManager `
    -scheduleInformation $scheduleInformation -scanProperties $scanProperties
```

Creates a scheduled Active Directory discovery scan.

## PARAMETERS

### -scanType

The type of discovery scan to create. Valid values are `ActiveDirectory` and `CsvFile`.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: ActiveDirectory, CsvFile

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -scanCredentials

One or more credential objects for the scan. Active Directory scans can specify an existing CyberArk account with `scanAccountId`, or a `username` and `password`. CSV-file scans require `username` and `password` only.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -discoveryName

The name of the discovery scan.

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

### -managingScanner

The name of the scanner that manages the discovery scan.

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

### -scheduleInformation

The scan schedule object. It can contain `daysOfWeek` and `time` properties.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -csvFile

Base64-encoded contents of the CSV input file. Required when `scanType` is `CsvFile`.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -fileName

Name of the CSV input file. Required when `scanType` is `CsvFile`.

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

### -scanProperties

Additional scan-type-specific request properties. Each entry is sent as a top-level request property. For example, an Active Directory scan can provide `@{ domainName = 'contoso.com'; OU = 'All OUs'; useSecureProtocol = $true }`.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.

## INPUTS

### System.Management.Automation.PSCustomObject

You can pipe objects with `scanType`, `scanCredentials`, and `managingScanner` properties to this command.

## OUTPUTS

### System.Management.Automation.PSCustomObject

Returns a `psPAS.CyberArk.Vault.DiscoveryScan` object.

## NOTES

Requires CyberArk Self-Hosted version 12.2 or higher.

## RELATED LINKS

[Add-PASDiscoveryScan](https://pspas.pspete.dev/commands/Add-PASDiscoveryScan)
