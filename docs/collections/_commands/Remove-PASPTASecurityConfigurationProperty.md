---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Remove-PASPTASecurityConfigurationProperty
schema: 2.0.0
title: Remove-PASPTASecurityConfigurationProperty
---

# Remove-PASPTASecurityConfigurationProperty

## SYNOPSIS
Removes PTA security configuration property

## SYNTAX

```
Remove-PASPTASecurityConfigurationProperty [-propertyKey] <String> [-id] <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
This deletes a specific PTA security configuration property

## EXAMPLES

### EXAMPLE 1
```
Remove-PASPTASecurityConfigurationProperty -propertyKey "PrivilegedUsersList" -id "someid"
```

Removes the specified id from the PrivilegedUsersList property

### EXAMPLE 2
```
Remove-PASPTASecurityConfigurationProperty -propertyKey "SCTExcludedAccountsList" -id "someid"
```

Removes the specified id from the SCTExcludedAccountsList property

## PARAMETERS

### -propertyKey
The key of the PTA security configuration property

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

### -id
The ID of the item to remove from the property

```yaml
Type: String
Parameter Sets: (All)
Aliases:

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
Minimum Version CyberArk 14.2

## RELATED LINKS

[https://pspas.pspete.dev/commands/Remove-PASPTASecurityConfigurationProperty](https://pspas.pspete.dev/commands/Remove-PASPTASecurityConfigurationProperty)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/deletesecurity.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/deletesecurity.htm)
