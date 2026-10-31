---
external help file: psPAS-help.xml
Module Name: psPAS
online version:
schema: 2.0.0
title: Get-PASDirectoryGroup
---

# Get-PASDirectoryGroup

## SYNOPSIS
Gets groups from an LDAP directory

## SYNTAX

```
Get-PASDirectoryGroup -DirectoryName <String> [-Contains <String>] [-Context <String>] [-Limit <Int32>] [-IsSSLConnection <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
Gets groups from an LDAP directory integrated with the vault.

Requires CyberArk Version 15.2 or higher.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-PASDirectoryGroup -DirectoryName domain.com -Contains Admins
```

Gets groups with names containing Admins from the domain.com directory

### EXAMPLE 2
```powershell
Get-PASDirectoryGroup -DirectoryName domain.com -Context 'OU=Groups,DC=domain,DC=com'
```

Gets groups from the Groups OU of the domain.com directory

## PARAMETERS

### -DirectoryName
The name of the LDAP directory

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

### -Contains
Text which the group name must contain

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Context
The distinguished name of the directory container to search for groups

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Limit
The maximum number of groups to return

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -IsSSLConnection
Specify whether the directory is queried over an SSL connection

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

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

[https://pspas.pspete.dev/commands/Get-PASDirectoryGroup](https://pspas.pspete.dev/commands/Get-PASDirectoryGroup)
