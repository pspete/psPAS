---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASDirectory
schema: 2.0.0
title: Get-PASDirectory
---

# Get-PASDirectory

## SYNOPSIS
Get LDAP directories configured in the Vault

## SYNTAX

```
Get-PASDirectory [-id <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns a list of existing directories in the Vault.

Each directory will be returned with its own data.

Membership of the Vault Admins group required.

Minimum required version 10.4

## EXAMPLES

### EXAMPLE 1
```
Get-PASDirectory
```

Returns LDAP directories configured in the Vault

### EXAMPLE 2
```
Get-PASDirectory -id SomeDirectory
```

Returns details of "SomeDirectory" LDAP directory configured in the Vault

Minimum required version 10.5

## PARAMETERS

### -id
The ID or Name of the directory to return information on.

Minimum required version 10.5

```yaml
Type: String
Parameter Sets: (All)
Aliases: DomainName

Required: False
Position: Named
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

[https://pspas.pspete.dev/commands/Get-PASDirectory](https://pspas.pspete.dev/commands/Get-PASDirectory)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/LDAP_Get_Directories.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/LDAP_Get_Directories.htm)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/LDAP_Get_directory_details.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/LDAP_Get_directory_details.htm)
