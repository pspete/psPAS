---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Remove-PASGroup
schema: 2.0.0
title: Remove-PASGroup
---

# Remove-PASGroup

## SYNOPSIS
Deletes a user group

## SYNTAX

```
Remove-PASGroup [-GroupID] <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes a user group.

To delete a user group, the following authorizations are required:

- Add/Update Users

## EXAMPLES

### EXAMPLE 1
```
Delete-PASGroup -GroupID 3
```

Deletes Group with ID of 3

## PARAMETERS

### -GroupID
The unique ID of the group to delete.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
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

[https://pspas.pspete.dev/commands/Remove-PASGroup](https://pspas.pspete.dev/commands/Remove-PASGroup)

