---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Set-PASDirectoryMappingOrder
schema: 2.0.0
title: Set-PASDirectoryMappingOrder
---

# Set-PASDirectoryMappingOrder

## SYNOPSIS
Changes the order of directory mappings for a directory

## SYNTAX

```
Set-PASDirectoryMappingOrder [-DirectoryName] <String> [-MappingsOrder] <Int32[]> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Updates the order of all a directories mappings.

Requires membership of Vault Admins group & "Audit users", "Add/Update users" & "Manage Directory mappings" authorizations.

Minimum version 10.10

## EXAMPLES

### EXAMPLE 1
```
Set-PASDirectoryMappingOrder -DirectoryName "DOMAIN.COM" -MappingsOrder 39,43,41,669,668,667
```

Sets the order of the directory mappings for directory "DOMAIN.COM"

## PARAMETERS

### -DirectoryName
The name of the directory

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

### -MappingsOrder
The MappingID of each directory mapping, in the order they should be applied.

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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

[https://pspas.pspete.dev/commands/Set-PASDirectoryMappingOrder](https://pspas.pspete.dev/commands/Set-PASDirectoryMappingOrder)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-reorder-map.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-reorder-map.htm)
