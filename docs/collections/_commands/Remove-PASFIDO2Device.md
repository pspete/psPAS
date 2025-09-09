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
Removes a FIDO2 device from a user's authentication methods.

## SYNTAX

### Default (Default)
```
Remove-PASFIDO2Device [-id] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### OwnDevice
```
Remove-PASFIDO2Device [-id] <String> [-OwnDevice] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Removes a FIDO2 device from either a user's authentication methods or from the current user's own authentication methods.

Requires CyberArk version 14.6 or later.

## EXAMPLES

### Example 1
```powershell
PS C:\> Remove-PASFIDO2Device -id "device123"
```

Removes the FIDO2 device with ID "device123" from a user's registered authentication methods.
This requires administrative privileges.

### Example 2
```powershell
PS C:\> Remove-PASFIDO2Device -id "device123" -OwnDevice
```

Removes the FIDO2 device with ID "device123" from the current user's own registered
authentication methods. This allows users to self-manage their FIDO2 devices.

## PARAMETERS

### -id
The unique identifier of the FIDO2 device to be removed from a user's authentication methods.

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

### -OwnDevice
When specified, removes the FIDO2 device from the current user's own authentication methods.
Without this parameter, the device is removed from the user that it belongs do in their authentication methods.

```yaml
Type: SwitchParameter
Parameter Sets: OwnDevice
Aliases:

Required: False
Position: Named
Default value: False
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

[https://pspas.pspete.dev/commands/Remove-PASFIDO2Device](https://pspas.pspete.dev/commands/Remove-PASFIDO2Device)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/fido2-remove.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/fido2-remove.htm)

[\[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/fido2-remove.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/fido2-selfremove.htm)