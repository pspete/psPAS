---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Set-PASBYOKConfig
schema: 2.0.0
title: Set-PASBYOKConfig
---

# Set-PASBYOKConfig

## SYNOPSIS
Configures BYOK for the Privilege Cloud environment.

## SYNTAX

```
Set-PASBYOKConfig [-kms_arn] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Configures your KMS key in the CyberArk BYOK service. In response, CyberArk verifies access to your key.

Do not run this function if a key change is already in progress (i.e. within 20 minutes of running Enable-PASBYOKConfig or Disable-PASBYOKConfig).

Requires one of the following roles:
- System Administrator (Identity Administration)
- Privilege Cloud Administrator
- Privilege Cloud Administrator Basic
- Privilege Cloud Administrator Lite

## EXAMPLES

### EXAMPLE 1
```powershell
Set-PASBYOKConfig -kms_arn 'arn:aws:kms:us-east-1:1234567890:key/hex-key-goes-here'
```

Configures BYOK to use the specified AWS KMS key.

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

### -kms_arn
The ARN of the AWS KMS key to use for BYOK encryption.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Set-PASBYOKConfig](https://pspas.pspete.dev/commands/Set-PASBYOKConfig)

[https://docs.cyberark.com/snapshot/ispss-deployment/en/content/privilege%20cloud/privcloud-byok-api-configure.htm](https://docs.cyberark.com/snapshot/ispss-deployment/en/content/privilege%20cloud/privcloud-byok-api-configure.htm)
