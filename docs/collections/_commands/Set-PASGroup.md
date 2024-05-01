---
category: psPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Set-PASGroup
schema: 2.0.0
title: Set-PASGroup
---

# Set-PASGroup

## SYNOPSIS
Renames a Vault group

## SYNTAX

```
Set-PASGroup -ID <Int32> [-GroupName] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a Vault group.
The authenticated user requires the following permissions:
- Add\Update users

Requires CyberArk Version 12.0+

## EXAMPLES

### EXAMPLE 1
```powershell
PS C:\> Set-PASGroup -GroupID 420 -GroupName SomeName
```

Renames group with id 420 to "SomeName"

## PARAMETERS

### -GroupName
A new name for the group

```yaml
Type: String
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

[https://pspas.pspete.dev/commands/Set-PASGroup](https://pspas.pspete.dev/commands/Set-PASGroup)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/12.0/en/Content/WebServices/Update-group.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/12.0/en/Content/WebServices/Update-group.htm)
