---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Remove-PASDiscoveryScan
schema: 2.0.0
title: Remove-PASDiscoveryScan
---

# Remove-PASDiscoveryScan

## SYNOPSIS

Deletes a single discovery scan that is configured in the Vault.

## SYNTAX

```
Remove-PASDiscoveryScan [-taskId] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Deletes a single discovery scan that is configured in the Vault.

Requires CyberArk Self-Hosted version 12.2 or higher.

## EXAMPLES

### Example 1

```powershell
Remove-PASDiscoveryScan -taskId 12345
```

Removes the discovery scan with the specified task ID.

### Example 2

```powershell
Remove-PASDiscoveryScan -taskId 12345 -WhatIf
```

Shows what would happen if the discovery scan was removed, without actually removing it.

## PARAMETERS

### -taskId

The unique ID of the discovery scan to remove.

```yaml
Type: String
Parameter Sets: (All)
Aliases: id

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

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

### System.String

You can pipe objects with a `taskId` or `id` property to this command.

## OUTPUTS

### None

## NOTES

Requires CyberArk Self-Hosted version 12.2 or higher.

## RELATED LINKS

[Remove-PASDiscoveryScan](https://pspas.pspete.dev/commands/Remove-PASDiscoveryScan)
