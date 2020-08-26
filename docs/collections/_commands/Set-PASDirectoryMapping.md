---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Set-PASDirectoryMapping
schema: 2.0.0
title: Set-PASDirectoryMapping
---

# Set-PASDirectoryMapping

## SYNOPSIS
Updates an existing Directory Mapping for a directory

## SYNTAX

```
Set-PASDirectoryMapping [-DirectoryName] <String> [-MappingID] <String> [-MappingName] <String>
 [-LDAPBranch] <String> [[-DomainGroups] <String[]>] [[-VaultGroups] <String[]>] [[-Location] <String>]
 [[-LDAPQuery] <String>] [[-MappingAuthorizations] <Authorizations>] [[-UserActivityLogPeriod] <Int32>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a  directory mapping.
Membership of the Vault Admins group required.

## EXAMPLES

### EXAMPLE 1
```
Get-PASDirectoryMapping -DirectoryName $Directory -MappingID $ID |
```

Set-PASDirectoryMapping -DirectoryName $Directory -MappingAuthorizations AddUpdateUsers, AuditUsers

Configures the AddUpdateUsers & AuditUsers authorisations on the mapping.

### EXAMPLE 2
```
Set-PASDirectoryMapping -DirectoryName $DirectoryName -MappingID $MappingID -MappingName $MappingName -LDAPBranch $LDAPBranch `
```

-MappingAuthorizations AddUpdateUsers, ActivateUsers & ResetUsersPasswords

Sets AddUpdateUsers, ActivateUsers & ResetUsersPasswords authorisations on the directory mapping

### EXAMPLE 3
```
Set-PASDirectoryMapping -DirectoryName $DirectoryName -MappingID $MappingID -MappingName $MappingName -LDAPBranch $LDAPBranch `
```

-UserActivityLogPeriod 365

Sets UserActivityLogPeriod for the mapping to 365

## PARAMETERS

### -DirectoryName
The name of the directory the mapping is for.

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

### -MappingID
The ID of the Directory Mapping to Update

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

### -MappingName
The name of the PAS role that will be created.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -LDAPBranch
The LDAP branch that will be used for external directory queries

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DomainGroups
Users who belong to these LDAP groups will be automatically assigned to the relevant roles in the PAS system.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -VaultGroups
A list of Vault groups that a mapped user will be added to.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Location
The path of the Vault location that mapped users are added under.
This value cannot be updated.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -LDAPQuery
Match LDAP query results to mapping

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MappingAuthorizations
Specify authorizations that will be applied when an LDAP User Account is created in the Vault.
To apply specific authorizations to a mapping, the user must have the same authorizations.
Possible authorizations: AddSafes, AuditUsers, AddUpdateUsers, ResetUsersPasswords, ActivateUsers,
AddNetworkAreas, ManageServerFileCategories, BackupAllSafes, RestoreAllSafes.

```yaml
Type: Authorizations
Parameter Sets: (All)
Aliases:
Accepted values: AddUpdateUsers, AddSafes, AddNetworkAreas, ManageServerFileCategories, AuditUsers, BackupAllSafes, RestoreAllSafes, ResetUsersPasswords, ActivateUsers

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserActivityLogPeriod
Retention period in days for user activity logs
Requires CyberArk version 10.10+

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: 0
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

[https://pspas.pspete.dev/commands/Set-PASDirectoryMapping](https://pspas.pspete.dev/commands/Set-PASDirectoryMapping)

