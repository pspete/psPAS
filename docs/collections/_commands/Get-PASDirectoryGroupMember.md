---
external help file: psPAS-help.xml
Module Name: psPAS
online version:
schema: 2.0.0
title: Get-PASDirectoryGroupMember
---

# Get-PASDirectoryGroupMember

## SYNOPSIS
Gets members of an LDAP directory group

## SYNTAX

```
Get-PASDirectoryGroupMember -DirectoryName <String> -Groups <String> [-Limit <Int32>] [-IsSSLConnection <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
Gets the members of a group in an LDAP directory integrated with the vault.

Requires CyberArk Version 15.2 or higher.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-PASDirectoryGroupMember -DirectoryName domain.com -Groups "CN=Admins,OU=Groups,DC=domain,DC=com"
```

Gets the members of the Admins group in the domain.com directory

### EXAMPLE 2
```powershell
Get-PASDirectoryGroup -DirectoryName domain.com -Contains Admins | Get-PASDirectoryGroupMember -DirectoryName domain.com
```

Gets the members of each group with a name containing Admins

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

### -Groups
The distinguished name of the group

```yaml
Type: String
Parameter Sets: (All)
Aliases: DistinguishedName

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Limit
The maximum number of members to return

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

[https://pspas.pspete.dev/commands/Get-PASDirectoryGroupMember](https://pspas.pspete.dev/commands/Get-PASDirectoryGroupMember)
