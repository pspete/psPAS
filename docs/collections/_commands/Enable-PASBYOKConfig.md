---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Enable-PASBYOKConfig
schema: 2.0.0
title: Enable-PASBYOKConfig
---

# Enable-PASBYOKConfig

## SYNOPSIS
Enables BYOK for the Privilege Cloud environment.

## SYNTAX

```
Enable-PASBYOKConfig [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Starts data encryption within CyberArk using your previously configured KMS key. Activates BYOK, resetting the system's encryption/decryption mechanisms to use your key.

This takes about 20 minutes to complete. During this time, the BYOK status indicates the key is being replaced, and no BYOK-related action can be performed except Get-PASBYOKConfig. Do not modify or move the encryption key while this is in progress. Run Get-PASBYOKConfig afterwards to confirm the status is 'BYOK ON'.

When using BYOK, you are solely responsible for safeguarding the encryption key. If CyberArk loses access to your key (deletion, loss, or alteration), your encrypted data cannot be recovered - CyberArk does not retain a copy of the key or any alternate means of accessing the data.

Requires one of the following roles:
- System Administrator (Identity Administration)
- Privilege Cloud Administrator
- Privilege Cloud Administrator Basic
- Privilege Cloud Administrator Lite

## EXAMPLES

### EXAMPLE 1
```powershell
Enable-PASBYOKConfig
```

Enables BYOK encryption.

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

[https://pspas.pspete.dev/commands/Enable-PASBYOKConfig](https://pspas.pspete.dev/commands/Enable-PASBYOKConfig)

[https://docs.cyberark.com/snapshot/ispss-deployment/en/content/privilege%20cloud/privcloud-byok-api-enable.htm](https://docs.cyberark.com/snapshot/ispss-deployment/en/content/privilege%20cloud/privcloud-byok-api-enable.htm)
