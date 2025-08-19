---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Remove-PASFIDO2Device
schema: 2.0.0
title: Remove-PASFIDO2Device
---

# Remove-PASFIDO2Device

## SYNOPSIS
This removes a FIDO2 device from a user.

## SYNTAX

```
Remove-PASFIDO2Device [[-id] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Removes a FIDO2 device from any user's authentication methods. 

Requires CyberArk version 14.6 or later.

## EXAMPLES

### Example 1
```powershell
PS C:\> Remove-PASFIDO2Device -id "device123"
```

Removes the FIDO2 device with ID "device123" from a user's registered authentication methods.


## PARAMETERS

### -id
The unique identifier of the FIDO2 device to be removed from any user's authentication methods.

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
