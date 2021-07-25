---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/New-PASAccountGroup
schema: 2.0.0
title: New-PASAccountGroup
---

# New-PASAccountGroup

## SYNOPSIS
Adds a new account group to the Vault

## SYNTAX

```
New-PASAccountGroup [-GroupName] <String> [-GroupPlatformID] <String> [-Safe] <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Defines a new account group in the vault.

The following permissions are required on the safe where the account group will be created:
 - Add Accounts
 - Update Account Content
 - Update Account Properties
  -Create Folders

## EXAMPLES

### EXAMPLE 1
```
New-PASAccountGroup -GroupName UATGroup -GroupPlatform UnixGroup-NonProd -Safe UAT-Team
```

Creates new account group named UATGroup and assigns to platform in the UAT-Team Safe.

## PARAMETERS

### -GroupName
The name of the group to create

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

### -GroupPlatformID
The name of the platform for the group.

The associated platform must be set to "PolicyType=Group" or "PolicyType=RotationalGroup"

To add Account Group with Policy Type of Rotational Group requires minimum version of 12.2

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

### -Safe
The Safe where the group will be created

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
Minimum version 9.9.5

## RELATED LINKS

[https://pspas.pspete.dev/commands/New-PASAccountGroup](https://pspas.pspete.dev/commands/New-PASAccountGroup)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add-account-group.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add-account-group.htm)
