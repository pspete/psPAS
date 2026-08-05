---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Remove-PASRequest
schema: 2.0.0
title: Remove-PASRequest
---

# Remove-PASRequest

## SYNOPSIS
Deletes a request from the Vault

## SYNTAX

```
Remove-PASRequest [-RequestID] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes a request from the Vault.

The "Manage" Safe vault permission is required.

Officially supported from version 9.10.

Reports received that function works in 9.9 also.

## EXAMPLES

### EXAMPLE 1
```
Remove-PASRequest -RequestID TargetSafe_15
```

Deletes request TargetSafe_15 from the Vault.

### EXAMPLE 2
```
Remove-PASRequest -RequestID TargetSafe_15 -WhatIf
```

Shows what would happen if the request was deleted, without actually deleting it.

### EXAMPLE 3
```
'TargetSafe_15', 'TargetSafe_16' | ForEach-Object { [PSCustomObject]@{RequestID = $_ } } | Remove-PASRequest
```

Deletes multiple requests by passing each RequestID down the pipeline.

## PARAMETERS

### -RequestID
The ID (composed of the Safe Name and internal RequestID) of the request to delete.

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

[https://pspas.pspete.dev/commands/Remove-PASRequest](https://pspas.pspete.dev/commands/Remove-PASRequest)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/DeleteMyRequest.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/DeleteMyRequest.htm)
