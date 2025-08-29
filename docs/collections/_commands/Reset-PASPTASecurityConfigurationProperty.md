---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Reset-PASPTASecurityConfigurationProperty
schema: 2.0.0
title: Reset-PASPTASecurityConfigurationProperty
---

# Reset-PASPTASecurityConfigurationProperty

## SYNOPSIS
Resets PTA security configuration property to default value

## SYNTAX

```
Reset-PASPTASecurityConfigurationProperty [-propertyKey] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Resets PTA security configuration property to default value

Minimum required version 14.2

## EXAMPLES

### EXAMPLE 1
```
Reset-PASPTASecurityConfigurationProperty -propertyKey "ActiveDormantUserDays"
```

Resets the ActiveDormantUserDays property to its default value

### EXAMPLE 2
```
Reset-PASPTASecurityConfigurationProperty -propertyKey "FailedVaultLogonAttemptsThreshold"
```

Resets the FailedVaultLogonAttemptsThreshold property to its default value

## PARAMETERS

### -propertyKey
The key of the PTA security configuration property to reset

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
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
Minimum Version CyberArk 14.2

## RELATED LINKS

[https://pspas.pspete.dev/commands/Reset-PASPTASecurityConfigurationProperty](https://pspas.pspete.dev/commands/Reset-PASPTASecurityConfigurationProperty)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/resetsecurityproperty.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/resetsecurityproperty.htm)
