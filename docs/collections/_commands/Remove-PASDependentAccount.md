---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Remove-PASDependentAccount
schema: 2.0.0
title: Remove-PASDependentAccount
---

# Remove-PASDependentAccount

## SYNOPSIS
This deletes an existing dependent account.

## SYNTAX

```
Remove-PASDependentAccount [-AccountID] <String> [-dependentAccountId] <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Removes the association between a main privileged account and the dependent account. 

Requires CyberArk version 14.6 or later.

## EXAMPLES

### Example 1
```powershell
PS C:\> Remove-PASDependentAccount -AccountID "123_456" -dependentAccountId "22_2"
```

Removes the dependent account with ID "789_012" from the main account "123_456". 
The system will prompt for confirmation before performing the removal.

### Example 2
```powershell
PS C:\> Get-PASAccount -id "123_456" | Remove-PASDependentAccount -dependentAccountId "22_2" -WhatIf
```

Shows what would happen if the dependent account were removed, but does not actually perform the removal.
Uses pipeline input from Get-PASAccount for the main account ID.

## PARAMETERS

### -AccountID
The unique ID of the main privileged account that has the dependent account associated with it.
This parameter accepts pipeline input and can be aliased as 'id'.

```yaml
Type: String
Parameter Sets: (All)
Aliases: id

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -dependentAccountId
The unique ID of the dependent account that should be removed from the main account association.
This parameter accepts pipeline input and can be aliased as 'dependentid'.

```yaml
Type: String
Parameter Sets: (All)
Aliases: dependentid

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
