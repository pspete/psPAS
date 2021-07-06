---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Import-PASPlatform
schema: 2.0.0
title: Import-PASPlatform
---

# Import-PASPlatform

## SYNOPSIS
Import a new platform

## SYNTAX

```
Import-PASPlatform [-ImportFile] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Import a new CPM platform.

## EXAMPLES

### EXAMPLE 1
```
Import-PASPlatform -ImportFile CustomApp.zip
```

Imports CustomApp.zip Platform package

## PARAMETERS

### -ImportFile
The zip file that contains the platform.

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
Minimum CyberArk version 10.2

## RELATED LINKS

[https://pspas.pspete.dev/commands/Import-PASPlatform](https://pspas.pspete.dev/commands/Import-PASPlatform)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/ImportPlatform.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/ImportPlatform.htm)
