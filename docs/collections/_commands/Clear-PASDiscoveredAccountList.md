---
category: psPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Clear-PASDiscoveredAccountList
schema: 2.0.0
title: Clear-PASDiscoveredAccountList
---

# Clear-PASDiscoveredAccountList

## SYNOPSIS
Deletes all discovered accounts

## SYNTAX

```
Clear-PASDiscoveredAccountList [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes all discovered accounts and related dependencies from the Pending Accounts list.

Membership of the Vault admins group required.
Requires CyberArk Version 12.1 or higher.

## EXAMPLES

### EXAMPLE 1
```powershell
PS C:\> Clear-PASDiscoveredAccountList
```

Deletes all discovered accounts from the Pending Accounts list.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Clear-PASDiscoveredAccountList](https://pspas.pspete.dev/commands/Clear-PASDiscoveredAccountList)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete-Discovered-accounts.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete-Discovered-accounts.htm)
