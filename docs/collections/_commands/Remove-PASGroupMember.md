---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Remove-PASGroupMember
schema: 2.0.0
title: Remove-PASGroupMember
---

# Remove-PASGroupMember

## SYNOPSIS
Removes a vault user from a group

## SYNTAX

```
Remove-PASGroupMember [-GroupID] <String> [-Member] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Removes an existing member from an existing group in the vault

## EXAMPLES

### EXAMPLE 1
```
Remove-PASGroupMember -GroupID X1_Y2 -Member TargetUser
```

Removes TargetUser from group

## PARAMETERS

### -GroupID
The ID of the group

```yaml
Type: String
Parameter Sets: (All)
Aliases: ID

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Member
The name of the group member

```yaml
Type: String
Parameter Sets: (All)
Aliases: UserName

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

[https://pspas.pspete.dev/commands/Remove-PASGroupMember](https://pspas.pspete.dev/commands/Remove-PASGroupMember)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/RemoveUserFromGroup.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/RemoveUserFromGroup.htm)
