---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASSafeShareLogo
schema: 2.0.0
title: Get-PASSafeShareLogo
---

# Get-PASSafeShareLogo

## SYNOPSIS
Returns details of configured SafeShare Logo

## SYNTAX

```
Get-PASSafeShareLogo [-ImageType] <String> [<CommonParameters>]
```

## DESCRIPTION
Gets configuration details of logo displayed in the SafeShare WebGUI

Deprecated from version 13.2

## EXAMPLES

### EXAMPLE 1
```
Get-PASSafeShareLogo -ImageType Square
```

Retrieves Safe Share Logo

## PARAMETERS

### -ImageType
The requested logo type: Square or Watermark.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
SafeShare no longer available from CyberArk

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASSafeShareLogo](https://pspas.pspete.dev/commands/Get-PASSafeShareLogo)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Server%20Web%20Services%20-%20Logo.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Server%20Web%20Services%20-%20Logo.htm)
