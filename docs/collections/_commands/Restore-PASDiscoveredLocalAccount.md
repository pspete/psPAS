---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Restore-PASDiscoveredLocalAccount
schema: 2.0.0
title: Restore-PASDiscoveredLocalAccount
---

# Restore-PASDiscoveredLocalAccount

## SYNOPSIS
Removes a discovered account from the ignore list.

## SYNTAX

```
Restore-PASDiscoveredLocalAccount [-id] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Removes a discovered account from the ignore list, restoring it to the active Discovered Accounts list.

Requires one of the following roles:
- Privilege Cloud Administrator
- Privilege Cloud Administrator Basic
- Privilege Cloud Administrator Lite

## EXAMPLES

### EXAMPLE 1
```powershell
Restore-PASDiscoveredLocalAccount -id 54507db1-66d7-4dc7-93cf-a310cc19b9fc
```

Removes the specified discovered account from the ignore list.

### EXAMPLE 2
```powershell
Restore-PASDiscoveredLocalAccount -id 54507db1-66d7-4dc7-93cf-a310cc19b9fc -WhatIf
```

Shows what would happen if the specified discovered account was removed from the ignore list, without actually removing it.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Restore-PASDiscoveredLocalAccount](https://pspas.pspete.dev/commands/Restore-PASDiscoveredLocalAccount)

[https://docs.cyberark.com/manage/latest/en/content/discovery/discovery-discoveredaccountsservice-restore.htm](https://docs.cyberark.com/manage/latest/en/content/discovery/discovery-discoveredaccountsservice-restore.htm)
