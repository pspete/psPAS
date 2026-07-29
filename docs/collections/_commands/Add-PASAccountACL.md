---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Add-PASAccountACL
schema: 2.0.0
title: Add-PASAccountACL
---

# Add-PASAccountACL

## SYNOPSIS
Adds a new privileged command rule to an account.

## SYNTAX

```
Add-PASAccountACL [-AccountPolicyId] <String> [-AccountAddress] <String> [-AccountUserName] <String>
 [-Command] <String> [-CommandGroup] <Boolean> [-PermissionType] <String> [[-Restrictions] <String>]
 [-UserName] <String> [<CommonParameters>]
```

## DESCRIPTION
Adds a new privileged command rule to an account.

Not supported in Privilege Cloud

## EXAMPLES

### EXAMPLE 1
```
Add-PASAccountACL -AccountPolicyID UNIXSSH -AccountAddress ServerA.domain.com -AccountUserName root `
-Command 'for /l %a in (0,0,0) do xyz' -CommandGroup $false -PermissionType Deny -UserName TestUser
```

This will add a new Privileged Command Rule to root for user TestUser

### EXAMPLE 2
```
Add-PASAccountACL -AccountPolicyID UNIXSSH -AccountAddress ServerB.domain.com -AccountUserName oracle `
-Command "/usr/local/bin/backup.sh" -CommandGroup $false -PermissionType Allow -Restrictions "*" -UserName dba_user
```

Allows dba_user to run the backup.sh command against the oracle account on ServerB.domain.com, with no additional restrictions.

### EXAMPLE 3
```
Add-PASAccountACL -AccountPolicyID UNIXSSH -AccountAddress ServerA.domain.com -AccountUserName root `
-Command NetworkCommands -CommandGroup $true -PermissionType Allow -UserName TestUser
```

Adds a rule allowing TestUser to run all commands in the NetworkCommands command group against the root account on ServerA.domain.com.

### EXAMPLE 4
```
Get-PASAccount -Keywords root -Safe UnixSafe | Add-PASAccountACL -AccountUserName root -Command reboot -CommandGroup $false -PermissionType Deny -UserName TestUser
```

Denies TestUser from running the reboot command against the root account found by Get-PASAccount, using the account's PolicyID and Address values passed down the pipeline.

## PARAMETERS

### -AccountPolicyId
The PolicyID associated with account.

```yaml
Type: String
Parameter Sets: (All)
Aliases: PlatformID, PolicyID

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AccountAddress
The address of the account whose privileged commands will be listed.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Address

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AccountUserName
The name of the account's user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Command
The Command

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CommandGroup
Boolean for Command Group

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PermissionType
Allow or Deny permission

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Restrictions
A restriction string

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserName
The user this rule applies to

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 8
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

[https://pspas.pspete.dev/commands/Add-PASAccountACL](https://pspas.pspete.dev/commands/Add-PASAccountACL)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add%20Account%20ACL.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add%20Account%20ACL.htm)
