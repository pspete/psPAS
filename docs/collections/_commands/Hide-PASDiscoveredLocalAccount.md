---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Hide-PASDiscoveredLocalAccount
schema: 2.0.0
title: Hide-PASDiscoveredLocalAccount
---

# Hide-PASDiscoveredLocalAccount

## SYNOPSIS
Moves a discovered account to the ignore list.

## SYNTAX

```
Hide-PASDiscoveredLocalAccount [-id] <String> [[-reason] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Moves a discovered account to the ignore list, so it is excluded from the active Discovered Accounts list. Use Restore-PASDiscoveredLocalAccount to remove it from the ignore list again.

Requires one of the following roles:
- Privilege Cloud Administrator
- Privilege Cloud Administrator Basic
- Privilege Cloud Administrator Lite

## EXAMPLES

### EXAMPLE 1
```powershell
Hide-PASDiscoveredLocalAccount -id 54507db1-66d7-4dc7-93cf-a310cc19b9fc -reason 'Known test account'
```

Moves the specified discovered account to the ignore list.

### EXAMPLE 2
```powershell
Hide-PASDiscoveredLocalAccount -id 54507db1-66d7-4dc7-93cf-a310cc19b9fc -WhatIf
```

Shows what would happen if the specified discovered account was moved to the ignore list, without actually moving it.

## PARAMETERS

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

### -id
The unique identifier of the discovered account.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -reason
The reason for ignoring the discovered account.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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

[https://pspas.pspete.dev/commands/Hide-PASDiscoveredLocalAccount](https://pspas.pspete.dev/commands/Hide-PASDiscoveredLocalAccount)

[https://docs.cyberark.com/manage/latest/en/content/discovery/discovery-discoveredaccountsservice-ignore.htm](https://docs.cyberark.com/manage/latest/en/content/discovery/discovery-discoveredaccountsservice-ignore.htm)
