---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASPTAExcludedTarget
schema: 2.0.0
title: Get-PASPTAExcludedTarget
---

# Get-PASPTAExcludedTarget

## SYNOPSIS
Get excluded target from the PTA

## SYNTAX

```
Get-PASPTAExcludedTarget [<CommonParameters>]
```

## DESCRIPTION
Returns excluded target properties from PTA security configuration

## EXAMPLES

### EXAMPLE 1
```powershell
Get-PASPTAExcludedTarget
```

Returns all configured excluded targets

### EXAMPLE 2
```powershell
(Get-PASPTAExcludedTarget).cidr
```

Returns only the CIDR values of the configured excluded targets

### EXAMPLE 3
```powershell
Get-PASPTAExcludedTarget | Where-Object { $_.cidr -like '10.*' }
```

Returns excluded targets whose CIDR value falls within the 10.0.0.0/8 range

### EXAMPLE 4
```powershell
(Get-PASPTAExcludedTarget | Measure-Object).Count
```

Returns the number of excluded targets currently configured in PTA

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASPTAExcludedTarget](https://pspas.pspete.dev/commands/Get-PASPTAExcludedTarget)

[https://docs.cyberark.com/PAS/Latest/en/Content/WebServices/GetAdministration.htm](https://docs.cyberark.com/PAS/Latest/en/Content/WebServices/GetAdministration.htm)
