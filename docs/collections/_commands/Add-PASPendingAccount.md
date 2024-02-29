---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Add-PASPendingAccount
schema: 2.0.0
title: Add-PASPendingAccount
---

# Add-PASPendingAccount

## SYNOPSIS
Adds discovered account or SSH key as a pending account in the accounts feed.

## SYNTAX

```
Add-PASPendingAccount [-UserName] <String> [-Address] <String> [-AccountDiscoveryDate] <DateTime>
 [[-OSType] <String>] [-AccountEnabled] <String> [[-AccountOSGroups] <String>] [[-AccountType] <String>]
 [[-DiscoveryPlatformType] <String>] [[-Domain] <String>] [[-LastLogonDate] <String>]
 [[-LastPasswordSet] <String>] [[-PasswordNeverExpires] <Boolean>] [[-OSVersion] <String>] [[-OU] <String>]
 [[-AccountCategory] <String>] [[-AccountCategoryCriteria] <String>] [[-UserDisplayName] <String>]
 [[-AccountDescription] <String>] [[-AccountExpirationDate] <String>] [[-UID] <String>] [[-GID] <String>]
 [[-MachineOSFamily] <String>] [<CommonParameters>]
```

## DESCRIPTION
Enables an account or SSH key that is discovered by an external scanner to be added
as a pending account to the Accounts Feed.

Users can identify privileged accounts and determine which are on-boarded to the vault.

Deprecated from version 13.2

## EXAMPLES

### EXAMPLE 1
```
Add-PASPendingAccount -UserName Administrator -Address ServerA.domain.com -AccountDiscoveryDate 2017-01-01T00:00:00Z -AccountEnabled enabled
```

Adds matching discovered account as pending account.

## PARAMETERS

### -UserName
The name of the account user

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

### -Address
The name or address of the machine where the account is used.

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

### -AccountDiscoveryDate
The date when the account was discovered.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -OSType
The OS where the password was discovered.
Windows or Unix

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AccountEnabled
The account status in the discovery source.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AccountOSGroups
The name of the group that the account belongs to

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AccountType
Account Type

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

### -DiscoveryPlatformType
Platform where discovered account is used

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

### -Domain
The domain of the account.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -LastLogonDate
Date, according to discovery source, when the account was last used to logon.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -LastPasswordSet
Date, according to discovery source, when the password for the account was last set

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PasswordNeverExpires
If the password will ever expire in the discovery source

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -OSVersion
OS Version where the account was discovered

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -OU
OU of the account

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AccountCategory
Whether the discovered account is privileged or non-privileged.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AccountCategoryCriteria
Criteria that determines whether or not the discovered account is privileged.

For example, the user or groupname, etc.

Separate multiple strings with ";".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UserDisplayName
User's display name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AccountDescription
A description of the user, as defined in the discovery source.

This will be saved as an account after it is added to the pending accounts.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AccountExpirationDate
The account expiration date defined in the discovery source.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UID
The unique User ID

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 20
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GID
The Unique Group ID

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MachineOSFamily
The type of machine where the account was discovered.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 22
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

[https://pspas.pspete.dev/commands/Add-PASPendingAccount](https://pspas.pspete.dev/commands/Add-PASPendingAccount)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add%20Discovered%20Account%20v10.8.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add%20Discovered%20Account%20v10.8.htm)
