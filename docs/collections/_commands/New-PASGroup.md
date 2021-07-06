---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/New-PASGroup
schema: 2.0.0
title: New-PASGroup
---

# New-PASGroup

## SYNOPSIS
Creates a vault group.

## SYNTAX

```
New-PASGroup [-groupName] <String> [[-description] <String>] [[-location] <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Adds a new Vault group.

Requires the following permissions:
- Add Users
- Update Users

## EXAMPLES

### EXAMPLE 1
```
New-PASGroup -groupName SomeNewGroup -description "Some Description" -location \PSP\CyberArk\Groups
```

Creates SomeNewGroup in the \PSP\CyberArk\Groups vault location

### EXAMPLE 2
```
New-PASGroup -groupName VaultGroup -description "Some Description" -location \
```

Creates VaultGroup in the root vault location

## PARAMETERS

### -groupName
The name of the group to create

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

### -description
A description for the group

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

### -location
The vault location to create the group in.

Preceded by "\"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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
Minimum Version 11.1

## RELATED LINKS

[https://pspas.pspete.dev/commands/New-PASGroup](https://pspas.pspete.dev/commands/New-PASGroup)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/rest-api-create-group.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/rest-api-create-group.htm)
