---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Import-PASConnectionComponent
schema: 2.0.0
title: Import-PASConnectionComponent
---

# Import-PASConnectionComponent

## SYNOPSIS
Import a new connection component.

## SYNTAX

```
Import-PASConnectionComponent [-ImportFile] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Allows administrators to import a new connection component, such as those available to download from the
CyberArk Marketplace.

## EXAMPLES

### EXAMPLE 1
```
Import-PASConnectionComponent -ImportFile ConnectionComponent.zip
```

Imports ConnectionComponent.zip Connection Component

## PARAMETERS

### -ImportFile
The zip file that contains the connection component.

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
Minimum CyberArk version 10.3

## RELATED LINKS

[https://pspas.pspete.dev/commands/Import-PASConnectionComponent](https://pspas.pspete.dev/commands/Import-PASConnectionComponent)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/ImportConnComponent.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/ImportConnComponent.htm)
