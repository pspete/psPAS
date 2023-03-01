---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/New-PASAccountObject
schema: 2.0.0
title: New-PASAccountObject
---

# New-PASAccountObject

## SYNOPSIS
Creates hashtable structured to be used as input for add account operations

## SYNTAX

### AccountObject (Default)
```
New-PASAccountObject [-uploadIndex <Int32>] [-userName <String>] [-name <String>] [-address <String>]
 -platformID <String> -SafeName <String> [-secretType <String>] [-secret <SecureString>]
 [-platformAccountProperties <Hashtable>] [-automaticManagementEnabled <Boolean>]
 [-manualManagementReason <String>] [-remoteMachines <String>] [-accessRestrictedToRemoteMachines <Boolean>]
 [-groupName <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### PersonalAdminAccount
```
New-PASAccountObject -userName <String> -address <String> -secret <SecureString> [-PersonalAdminAccount]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Provide parameter values to return hashtable structured to be used as input for add account operations.

## EXAMPLES

### EXAMPLE 1
```
New-PASAccountObject -userName SomeAccount1 -address domain.com -platformID WinDomain -SafeName SomeSafe
```

Returns hashtable structured to be used as input for add account operations

## PARAMETERS

### -uploadIndex
The numeric identifier for the account.

```yaml
Type: Int32
Parameter Sets: AccountObject
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -userName
Username on the target machine

```yaml
Type: String
Parameter Sets: AccountObject
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: PersonalAdminAccount
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -name
The name of the account.

```yaml
Type: String
Parameter Sets: AccountObject
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -address
The Address of the machine where the account will be used

```yaml
Type: String
Parameter Sets: AccountObject
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: PersonalAdminAccount
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -platformID
The CyberArk platform to assign to the account

```yaml
Type: String
Parameter Sets: AccountObject
Aliases: PolicyID

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SafeName
The safe where the account will be created

```yaml
Type: String
Parameter Sets: AccountObject
Aliases: safe

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -secretType
The type of password.

```yaml
Type: String
Parameter Sets: AccountObject
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -secret
The password value

```yaml
Type: SecureString
Parameter Sets: AccountObject
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

```yaml
Type: SecureString
Parameter Sets: PersonalAdminAccount
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -platformAccountProperties
key-value pairs to associate with the account, as defined by the account platform.

These properties are validated against the mandatory and optional properties of the specified platform's definition.

```yaml
Type: Hashtable
Parameter Sets: AccountObject
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -automaticManagementEnabled
Whether CPM Password Management should be enabled

```yaml
Type: Boolean
Parameter Sets: AccountObject
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -manualManagementReason
A reason for disabling CPM Password Management

```yaml
Type: String
Parameter Sets: AccountObject
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -remoteMachines
For supported platforms, a list of remote machines the account can connect to.

```yaml
Type: String
Parameter Sets: AccountObject
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -accessRestrictedToRemoteMachines
Whether access is restricted to the defined remote machines.

```yaml
Type: Boolean
Parameter Sets: AccountObject
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -groupName
Group to associate the account with

```yaml
Type: String
Parameter Sets: AccountObject
Aliases:

Required: False
Position: Named
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

### -PersonalAdminAccount
TBC

```yaml
Type: SwitchParameter
Parameter Sets: PersonalAdminAccount
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

[https://pspas.pspete.dev/commands/New-PASAccountObject](https://pspas.pspete.dev/commands/New-PASAccountObject)
