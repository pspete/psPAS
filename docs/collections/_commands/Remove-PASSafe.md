---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Remove-PASSafe
schema: 2.0.0
title: Remove-PASSafe
---

# Remove-PASSafe

## SYNOPSIS
Deletes a safe from the Vault

## SYNTAX

### Gen2 (Default)
```
Remove-PASSafe [-SafeName] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Gen1
```
Remove-PASSafe [-SafeName] <String> [-UseGen1API] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes a safe from the Vault.

The "Manage" Safe vault permission is required.

Default operation requires CyberArk version 12.1+.

For earlier versions, the Gen1 API switch must be specified.

## EXAMPLES

### EXAMPLE 1
```
Remove-PASSafe -SafeName OLD_Safe
```

Deletes "OLD_Safe"

### EXAMPLE 2
```
Remove-PASSafe -SafeName OLD_Safe -UseGen1API
```

Deletes "OLD_Safe" using the Gen1 API

## PARAMETERS

### -SafeName
The name of the safe to delete.

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

### -UseGen1API
Forces use of the Gen1 API endpoint

Should be specified for PAS versions earlier than 12.1

```yaml
Type: SwitchParameter
Parameter Sets: Gen1
Aliases:

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

[https://pspas.pspete.dev/commands/Remove-PASSafe](https://pspas.pspete.dev/commands/Remove-PASSafe)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20Safe.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20Safe.htm)
