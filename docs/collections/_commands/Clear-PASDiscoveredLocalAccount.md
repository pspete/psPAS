---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Clear-PASDiscoveredLocalAccount
schema: 2.0.0
---

# Clear-PASDiscoveredLocalAccount

## SYNOPSIS
Deletes all the discovered accounts from the list of discovered accounts for local endpoints.

## SYNTAX

```
Clear-PASDiscoveredLocalAccount [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes all the discovered accounts from the list of discovered accounts for local endpoint Windows and MacOS accounts.

Deleting these accounts from the current discovered accounts list does not affect the next scan for discovered accounts, and the deleted accounts may appear again.

The Delete All discovered accounts action is asynchronous and continues to run in the background, even after the API returns a response.

Applies to the accounts that are discovered by the EPM scanning of endpoints, including loosely connected devices:
- Windows loosely connected devices
- Mac loosely connected devices
- Linux loosely connected devices

Requires one of the following roles:
- Privilege Cloud Administrator
- Privilege Cloud Administrator Basic
- Privilege Cloud Administrator Lite

## EXAMPLES

### EXAMPLE 1
```
Clear-PASDiscoveredLocalAccount
```

Initiates Delete All discovered local accounts action.

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

[https://pspas.pspete.dev/commands/Clear-PASDiscoveredLocalAccount](https://pspas.pspete.dev/commands/Clear-PASDiscoveredLocalAccount)

[https://docs.cyberark.com/privilege-cloud-shared-services/latest/en/Content/Privilege%20Cloud/PrivCloud-DiscoveredAccountsService-DeleteAll.htm](https://docs.cyberark.com/privilege-cloud-shared-services/latest/en/Content/Privilege%20Cloud/PrivCloud-DiscoveredAccountsService-DeleteAll.htm)
