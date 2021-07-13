---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Remove-PASDirectory
schema: 2.0.0
title: Remove-PASDirectory
---

# Remove-PASDirectory

## SYNOPSIS
Removes an LDAP directory configured in the Vault

## SYNTAX

```
Remove-PASDirectory [-id] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Removes an LDAP directory configuration from the vault.

Membership of the Vault Admins group required.

## EXAMPLES

### EXAMPLE 1
```
Remove-PASDirectory -id LDAPDirectory
```

Removes LDAP directory configured in the Vault

## PARAMETERS

### -id
The ID or Name of the directory to return information on.

```yaml
Type: String
Parameter Sets: (All)
Aliases: DomainName

Required: True
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

[https://pspas.pspete.dev/commands/Remove-PASDirectory](https://pspas.pspete.dev/commands/Remove-PASDirectory)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/DeleteDirectory.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/DeleteDirectory.htm)
