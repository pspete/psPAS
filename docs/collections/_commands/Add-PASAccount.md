---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Add-PASAccount
schema: 2.0.0
title: Add-PASAccount
---

# Add-PASAccount

## SYNOPSIS
Adds a new privileged account to the Vault

Can target either the Gen2 API present from 10.4 onwards, or the previous Gen1 API endpoint.

## SYNTAX

### Gen2
```
Add-PASAccount [-name <String>] [-address <String>] [-userName <String>] -platformID <String>
 -SafeName <String> [-secretType <String>] [-secret <SecureString>] [-platformAccountProperties <Hashtable>]
 [-automaticManagementEnabled <Boolean>] [-manualManagementReason <String>] [-remoteMachines <String>]
 [-accessRestrictedToRemoteMachines <Boolean>] [<CommonParameters>]
```

### Gen1
```
Add-PASAccount [-address <String>] -userName <String> -platformID <String> -SafeName <String>
 [-accountName <String>] -password <SecureString> [-disableAutoMgmt <Boolean>]
 [-disableAutoMgmtReason <String>] [-groupName <String>] [-groupPlatformID <String>] [-Port <Int32>]
 [-ExtraPass1Name <String>] [-ExtraPass1Folder <String>] [-ExtraPass1Safe <String>] [-ExtraPass3Name <String>]
 [-ExtraPass3Folder <String>] [-ExtraPass3Safe <String>] [-DynamicProperties <Hashtable>] [<CommonParameters>]
```

## DESCRIPTION
Adds a new privileged account to the Vault.

Parameters are processed to create request object from passed parameters in the required format.

## EXAMPLES

### EXAMPLE 1
```
Add-PASAccount -address ThisServer -userName ThisUser -platformID UNIXSSH -SafeName UNIXSafe -automaticManagementEnabled $false
```

Using the Gen2 API, adds an account which is disabled for automatic password management

Requires minimum version of 10.4

### EXAMPLE 2
```
Add-PASAccount -safe Prod_Access -PlatformID WINDOMAIN -Address domain.com -Password $secureString -username domainUser
```

Using the Gen1 API, adds account domain.com\domainuser to the Prod_Access Safe using the WINDOMAIN platform.

The contents of $secureString will be set as the password value.

### EXAMPLE 3
```
$props = @{SSHCertificate = "yes";}
Add-PASAccount -address domain -userName ThisUser -platformID UNIXVIASSHCERTIFICATE -SafeName UNIXSafe -secretType Key -secret $key -platformAccountProperties $props
```

Using the Gen2 API, adds an account configured for the Unix via SSH Certificate platform

Requires minimum version of 10.4
Unix via SSH Certificate platform is supported in versions 11.2 and above.

## PARAMETERS

### -name
The name of the account.

Requires minimum version of 10.4

```yaml
Type: String
Parameter Sets: Gen2
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
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -userName
Username on the target machine

```yaml
Type: String
Parameter Sets: Gen2
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: Gen1
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
Parameter Sets: (All)
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
Parameter Sets: (All)
Aliases: safe

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -secretType
The type of password.

Requires minimum version of 10.4

```yaml
Type: String
Parameter Sets: Gen2
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -secret
The password value

Requires minimum version of 10.4

```yaml
Type: SecureString
Parameter Sets: Gen2
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -platformAccountProperties
key-value pairs to associate with the account, as defined by the account platform.

These properties are validated against the mandatory and optional properties of the specified platform's definition.

Requires minimum version of 10.4

```yaml
Type: Hashtable
Parameter Sets: Gen2
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -automaticManagementEnabled
Whether CPM Password Management should be enabled

Requires minimum version of 10.4

```yaml
Type: Boolean
Parameter Sets: Gen2
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -manualManagementReason
A reason for disabling CPM Password Management

Requires minimum version of 10.4

```yaml
Type: String
Parameter Sets: Gen2
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -remoteMachines
For supported platforms, a list of remote machines the account can connect to.

Requires minimum version of 10.4

```yaml
Type: String
Parameter Sets: Gen2
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -accessRestrictedToRemoteMachines
Whether access is restricted to the defined remote machines.

Requires minimum version of 10.4

```yaml
Type: Boolean
Parameter Sets: Gen2
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -accountName
The name of the account

Relevant for CyberArk versions earlier than 10.4

```yaml
Type: String
Parameter Sets: Gen1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -password
The password value as a secure string

Relevant for CyberArk versions earlier than 10.4

```yaml
Type: SecureString
Parameter Sets: Gen1
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -disableAutoMgmt
Whether or not automatic management wll be disabled for the account

Relevant for CyberArk versions earlier than 10.4

```yaml
Type: Boolean
Parameter Sets: Gen1
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -disableAutoMgmtReason
The reason why automatic management wll be disabled for the account

Relevant for CyberArk versions earlier than 10.4

```yaml
Type: String
Parameter Sets: Gen1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -groupName
A groupname with which the account will be associated

Relevant for CyberArk versions earlier than 10.4

```yaml
Type: String
Parameter Sets: Gen1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -groupPlatformID
Group platform to base created group ID on, if ID doesn't exist

Relevant for CyberArk versions earlier than 10.4

```yaml
Type: String
Parameter Sets: Gen1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Port
Port number over which the account will be used

Relevant for CyberArk versions earlier than 10.4

```yaml
Type: Int32
Parameter Sets: Gen1
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ExtraPass1Name
Logon account name

Relevant for CyberArk versions earlier than 10.4

```yaml
Type: String
Parameter Sets: Gen1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ExtraPass1Folder
Folder where logon account is stored

Relevant for CyberArk versions earlier than 10.4

```yaml
Type: String
Parameter Sets: Gen1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ExtraPass1Safe
Safe where logon account is stored

Relevant for CyberArk versions earlier than 10.4

```yaml
Type: String
Parameter Sets: Gen1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ExtraPass3Name
Reconcile account name

Relevant for CyberArk versions earlier than 10.4

```yaml
Type: String
Parameter Sets: Gen1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ExtraPass3Folder
Folder where reconcile account is stored

Relevant for CyberArk versions earlier than 10.4

```yaml
Type: String
Parameter Sets: Gen1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ExtraPass3Safe
Safe where reconcile account is stored

Relevant for CyberArk versions earlier than 10.4

```yaml
Type: String
Parameter Sets: Gen1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DynamicProperties
Hashtable of name=value pairs

Relevant for CyberArk versions earlier than 10.4

```yaml
Type: Hashtable
Parameter Sets: Gen1
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

[https://pspas.pspete.dev/commands/Add-PASAccount](https://pspas.pspete.dev/commands/Add-PASAccount)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add%20Account%20v10.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add%20Account%20v10.htm)
