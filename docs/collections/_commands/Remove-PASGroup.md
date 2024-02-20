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
Remove-PASGroup -ID <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes a vault group.

To delete a vault group, the following authorizations are required:
- Add/Update Users

## EXAMPLES

### EXAMPLE 1
```
Remove-PASGroup -GroupID 3
```

Deletes vault group with ID of 3

## PARAMETERS

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

### -ID
{{ Fill ID Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: GroupID

Required: True
Position: Named
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

[https://pspas.pspete.dev/commands/Remove-PASGroup](https://pspas.pspete.dev/commands/Remove-PASGroup)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Users%20Web%20Services%20-%20Delete%20User%20Group.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Users%20Web%20Services%20-%20Delete%20User%20Group.htm)
