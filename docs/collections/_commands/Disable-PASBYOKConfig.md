---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Disable-PASBYOKConfig
schema: 2.0.0
title: Disable-PASBYOKConfig
---

# Disable-PASBYOKConfig

## SYNOPSIS
Disables BYOK for the Privilege Cloud environment.

## SYNTAX

```
Disable-PASBYOKConfig [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Stops data encryption within CyberArk using your AWS key, switching back to the CyberArk-managed encryption key. Deactivates BYOK, resetting the system's encryption/decryption mechanisms to use the CyberArk key.

This takes about 15 minutes to complete. During this time, the BYOK status indicates the key is being replaced and no BYOK-related action can be performed; system functionality pauses temporarily and resumes shortly after. Do not modify or move the encryption key while this is in progress.

Requires one of the following roles:
- System Administrator (Identity Administration)
- Privilege Cloud Administrator
- Privilege Cloud Administrator Basic
- Privilege Cloud Administrator Lite

## EXAMPLES

### EXAMPLE 1
```powershell
Disable-PASBYOKConfig
```

Disables BYOK encryption.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Disable-PASBYOKConfig](https://pspas.pspete.dev/commands/Disable-PASBYOKConfig)

[https://docs.cyberark.com/snapshot/ispss-deployment/en/content/privilege%20cloud/privcloud-byok-api-disable.htm](https://docs.cyberark.com/snapshot/ispss-deployment/en/content/privilege%20cloud/privcloud-byok-api-disable.htm)
