---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASPTASecurityConfigurationCategory
schema: 2.0.0
title: Get-PASPTASecurityConfigurationCategory
---

# Get-PASPTASecurityConfigurationCategory

## SYNOPSIS
Returns PTA security configuration categories

## SYNTAX

```
Get-PASPTASecurityConfigurationCategory [-categoryKey <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns PTA security configuration categories

## EXAMPLES

### EXAMPLE 1
```
Get-PASPTASecurityConfigurationCategory
```

Returns all PTA security configuration categories

### EXAMPLE 2
```
Get-PASPTASecurityConfigurationCategory -categoryKey PrivilegedUsersAndGroups
```

Returns PTA security configuration details for the PrivilegedUsersAndGroups category.

### EXAMPLE 3
```
Get-PASPTASecurityConfigurationCategory -Category SuspectedCredentialsTheft
```

Returns PTA security configuration details for the SuspectedCredentialsTheft category, using the Category alias.

### EXAMPLE 4
```
'IrregularHoursUser', 'IrregularDaysUser' | ForEach-Object { Get-PASPTASecurityConfigurationCategory -categoryKey $_ }
```

Returns PTA security configuration details for both the IrregularHoursUser and IrregularDaysUser categories.

## PARAMETERS

### -categoryKey
The PTA category to return information on

```yaml
Type: String
Parameter Sets: (All)
Aliases: Category

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

[https://pspas.pspete.dev/commands/Get-PASPTASecurityConfigurationCategory](https://pspas.pspete.dev/commands/Get-PASPTASecurityConfigurationCategory)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/getsecuritycategories.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/getsecuritycategories.htm)
