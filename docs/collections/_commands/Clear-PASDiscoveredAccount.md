---
category: psPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Clear-PASDiscoveredAccount
schema: 2.0.0
title: Clear-PASDiscoveredAccount
---

# Clear-PASDiscoveredAccount

## SYNOPSIS
Deletes all discovered accounts

## SYNTAX

```
Clear-PASDiscoveredAccount [[-id] <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes all discovered accounts and related dependencies from the Pending Accounts list.

Membership of the Vault admins group required.
Requires CyberArk Version 12.1 or higher.

## EXAMPLES

### EXAMPLE 1
```powershell
Clear-PASDiscoveredAccount
```

Deletes all discovered accounts from the Pending Accounts list.

### EXAMPLE 2
```powershell
Clear-PASDiscoveredAccount -id 22_3
```

Deletes discovered account with id 22_3

### EXAMPLE 3
```powershell
Clear-PASDiscoveredAccount -id 22_3,22_4
```

Deletes accounts in bulk

## PARAMETERS

### -id
The unique id of the discovered account. When not supplied, all discovered are deleted/cleard. 

You can supply multiple unique id´s to do a bulk delete.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
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

## RELATED LINKS

[https://pspas.pspete.dev/commands/Clear-PASDiscoveredAccount](https://pspas.pspete.dev/commands/Clear-PASDiscoveredAccount)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete-Discovered-accounts.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete-Discovered-accounts.htm)
