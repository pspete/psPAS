---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Add-PASPTAIncludedTarget
schema: 2.0.0
title: Add-PASPTAIncludedTarget
---

# Add-PASPTAIncludedTarget

## SYNOPSIS
Adds Included target IP/subnet value in PTA administration configuration

## SYNTAX

```
Add-PASPTAIncludedTarget [-cidr] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds Included target IP/subnet value in PTA administration configuration

## EXAMPLES

### EXAMPLE 1
```powershell
Add-PASPTAIncludedTarget -cidr 192.168.60.10/24
```

Adds 192.168.60.10/24 as an included target in PTA administration

### EXAMPLE 2
```powershell
[PSCustomObject]@{cidr = '10.20.0.0/16'} | Add-PASPTAIncludedTarget
```

Adds 10.20.0.0/16 as an included target using pipeline input

### EXAMPLE 3
```powershell
Add-PASPTAIncludedTarget -cidr 192.168.0.0/16 -WhatIf
```

Shows what would happen if 192.168.0.0/16 were added as an included target, without making the change

### EXAMPLE 4
```powershell
Import-Csv .\included-targets.csv | Add-PASPTAIncludedTarget
```

Reads a list of CIDR values from a CSV file with a "cidr" column and adds each one as an included target in PTA administration

## PARAMETERS

### -cidr
IP/Subnet cidr value

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Add-PASPTAIncludedTarget](https://pspas.pspete.dev/commands/Add-PASPTAIncludedTarget)

[https://docs.cyberark.com/PAS/Latest/en/Content/WebServices/UpdateAdministration.htm](https://docs.cyberark.com/PAS/Latest/en/Content/WebServices/UpdateAdministration.htm)
