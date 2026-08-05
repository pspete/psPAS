---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Invoke-PASBYOKRotation
schema: 2.0.0
title: Invoke-PASBYOKRotation
---

# Invoke-PASBYOKRotation

## SYNOPSIS
Rotates the customer-managed AWS KMS key used for BYOK.

## SYNTAX

```
Invoke-PASBYOKRotation [-kms_arn] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Replaces the KMS key currently used by CyberArk BYOK with a new KMS key. BYOK-supported services are updated to use the new key to encrypt/decrypt both existing and new data; the previous key is no longer used.

BYOK encryption must already be enabled before running this function, and no key change may currently be in progress (i.e. Enable-PASBYOKConfig or Disable-PASBYOKConfig must not have run in the last 20 minutes). Before calling this function, create the new key in AWS KMS and add the CyberArk policy to it (see Get-PASBYOKPolicyStatement).

Rotation takes about 20 minutes to complete. During this time, do not modify the encryption policy of either key, and do not delete, move, or otherwise edit the previous or new KMS keys. Run Get-PASBYOKConfig afterwards to confirm the status is 'BYOK ON'.

Requires one of the following roles:
- System Administrator (Identity Administration)
- Privilege Cloud Administrator
- Privilege Cloud Administrator Basic
- Privilege Cloud Administrator Lite

## EXAMPLES

### EXAMPLE 1
```powershell
Invoke-PASBYOKRotation -kms_arn 'arn:aws:kms:us-east-1:1234567890:key/new-hex-key-goes-here'
```

Rotates the BYOK encryption key to the specified new AWS KMS key.

### EXAMPLE 2
```powershell
Invoke-PASBYOKRotation -kms_arn 'arn:aws:kms:us-east-1:1234567890:key/new-hex-key-goes-here' -WhatIf
```

Shows what would happen if the BYOK encryption key was rotated to the specified new AWS KMS key, without actually rotating it.

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
The ARN of the new AWS KMS key to rotate to, as copied from AWS KMS.

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

[https://pspas.pspete.dev/commands/Invoke-PASBYOKRotation](https://pspas.pspete.dev/commands/Invoke-PASBYOKRotation)

[https://docs.cyberark.com/snapshot/ispss-deployment/en/content/privilege%20cloud/privcloud-byok-api-rotation.htm](https://docs.cyberark.com/snapshot/ispss-deployment/en/content/privilege%20cloud/privcloud-byok-api-rotation.htm)
