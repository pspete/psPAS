---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASDirectoryMapping
schema: 2.0.0
title: Get-PASDirectoryMapping
---

# Get-PASDirectoryMapping

## SYNOPSIS
Get directory mappings configured for a directory

## SYNTAX

### All (Default)
```
Get-PASDirectoryMapping -DirectoryName <String> [<CommonParameters>]
```

### Mapping
```
Get-PASDirectoryMapping -DirectoryName <String> -MappingID <String> [<CommonParameters>]
```

## DESCRIPTION
Returns a list of existing directory mappings in the Vault.

Membership of the Vault Admins group required.

## EXAMPLES

### EXAMPLE 1
```
Get-PASDirectory | Get-PASDirectoryMapping
```

Returns LDAP directory mappings configured for each directory.

### EXAMPLE 2
```
Get-PASDirectoryMapping -DirectoryName SomeDir -MappingID "User_Mapping"
```

Returns information on the User_Mapping for SomeDir

## PARAMETERS

### -DirectoryName
The ID or Name of the directory to return data on.

```yaml
Type: String
Parameter Sets: (All)
Aliases: DomainName

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MappingID
The ID or Name of the directory mapping to return information on.

```yaml
Type: String
Parameter Sets: Mapping
Aliases:

Required: True
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

[https://pspas.pspete.dev/commands/Get-PASDirectoryMapping](https://pspas.pspete.dev/commands/Get-PASDirectoryMapping)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetDirectoryMappingList.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetDirectoryMappingList.htm)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetMappingDetails.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetMappingDetails.htm)
