---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Add-PASPolicyACL
schema: 2.0.0
title: Add-PASPolicyACL
---

# Add-PASPolicyACL

## SYNOPSIS
Adds a new privileged command rule

## SYNTAX

```
Add-PASPolicyACL [-Command] <String> [-CommandGroup] <Boolean> [-PermissionType] <String> [-PolicyId] <String>
 [[-Restrictions] <String>] [-UserName] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds a new privileged command rule to a policy.

Not supported in Privilege Cloud

## EXAMPLES

### EXAMPLE 1
```
Add-PASPolicyACL -Command "chmod" -CommandGroup $false -PermissionType Allow -PolicyId UNIXSSH -UserName user1
```

Adds Rule to UNIXSSH platform

### EXAMPLE 2
```
Add-PASPolicyACL -Command "rm -rf /" -CommandGroup $false -PermissionType Deny -PolicyId UNIXSSH -Restrictions "*" -UserName "*"
```

Denies all users from running the "rm -rf /" command on any account under the UNIXSSH platform.

### EXAMPLE 3
```
Add-PASPolicyACL -Command NetworkCommands -CommandGroup $true -PermissionType Allow -PolicyId UNIXSSH -UserName opsteam
```

Allows opsteam to run all commands in the NetworkCommands command group on accounts under the UNIXSSH platform.

### EXAMPLE 4
```
[PSCustomObject]@{PolicyId = 'UNIXSSH'; Command = 'shutdown'; CommandGroup = $false; PermissionType = 'Deny'; UserName = 'user1' } | Add-PASPolicyACL
```

Adds the same rule using pipeline input, since every parameter accepts values by property name.

## PARAMETERS

### -Command
The Command to Add

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

### -CommandGroup
Boolean to define if commandgroup

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PermissionType
Allow or Deny Permission

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

### -PolicyId
String value of Policy ID

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

### -Restrictions
A restrictions string

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UserName
The user this rule applies to.

Specify "*" for all users

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### -WhatIf
Shows what would happen if the cmdlet runs. The cmdlet is not run.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Add-PASPolicyACL](https://pspas.pspete.dev/commands/Add-PASPolicyACL)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add%20Policy%20ACL.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add%20Policy%20ACL.htm)
