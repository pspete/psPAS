---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Remove-PASSafeMember
schema: 2.0.0
title: Remove-PASSafeMember
---

# Remove-PASSafeMember

## SYNOPSIS
Removes a member from a safe

## SYNTAX

```
Remove-PASSafeMember [-SafeName] <String> [-MemberName] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Removes a specific member from a Safe.
The user who runs this function requires the ManageSafeMembers
permission.

## EXAMPLES

### EXAMPLE 1
```
Remove-PASSafeMember -SafeName TargetSafe -MemberName TargetUser
```

Removes TargetUser as safe member from TargetSafe

## PARAMETERS

### -SafeName
The name of the safe from which to remove the member.

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

### -MemberName
The name of the safe member to remove from the safes list of members.

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

[https://pspas.pspete.dev/commands/Remove-PASSafeMember](https://pspas.pspete.dev/commands/Remove-PASSafeMember)

