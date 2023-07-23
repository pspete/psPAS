---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/New-PASUser
schema: 2.0.0
title: New-PASUser
---

# New-PASUser

## SYNOPSIS
Creates a new vault user

## SYNTAX

### Gen2 (Default)
```
New-PASUser -UserName <String> [-InitialPassword <SecureString>] [-userType <String>]
 [-unAuthorizedInterfaces <String[]>] [-enableUser <Boolean>] [-authenticationMethod <String[]>]
 [-ChangePassOnNextLogon <Boolean>] [-passwordNeverExpires <Boolean>] [-distinguishedName <String>]
 [-vaultAuthorization <String[]>] [-ExpiryDate <DateTime>] [-Location <String>]
 [-userActivityLogRetentionDays <Int32>] [-loginFromHour <Int32>] [-loginToHour <Int32>] [-workStreet <String>]
 [-workCity <String>] [-workState <String>] [-workZip <String>] [-workCountry <String>] [-homePage <String>]
 [-homeEmail <String>] [-businessEmail <String>] [-otherEmail <String>] [-homeNumber <String>]
 [-businessNumber <String>] [-cellularNumber <String>] [-faxNumber <String>] [-pagerNumber <String>]
 [-description <String>] [-FirstName <String>] [-MiddleName <String>] [-LastName <String>] [-street <String>]
 [-city <String>] [-state <String>] [-zip <String>] [-country <String>] [-title <String>]
 [-organization <String>] [-department <String>] [-profession <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### Gen1
```
New-PASUser -UserName <String> -InitialPassword <SecureString> [-Email <String>]
 [-ChangePasswordOnTheNextLogon <Boolean>] [-ExpiryDate <DateTime>] [-UserTypeName <String>]
 [-Disabled <Boolean>] [-Location <String>] [-FirstName <String>] [-LastName <String>] [-UseGen1API] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds a new user to the vault

Default operation using the Gen2 API requires minimum version of 10.9

## EXAMPLES

### EXAMPLE 1
```
New-PASUser -UserName NewUser -InitialPassword $securePWD -UseGen1API
```

Creates a Vault user named NewUser, with password set to securestring value from $securePWD, using the Gen1 API

### EXAMPLE 2
```
New-PASUser -UserName NewUser -InitialPassword $securePWD
```

Creates a Vault user named NewUser, with password set to securestring value from $securePWD

Minimum required version 10.9

### EXAMPLE 3
```
New-PASUser -UserName NewUser -InitialPassword $securePWD -unAuthorizedInterfaces "PACLI" -vaultAuthorization ManageDirectoryMapping
```

Creates a Vault user as per the provided parameter values

Minimum required version 10.9

## PARAMETERS

### -UserName
The name of the user to create in the vault

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InitialPassword
The password to set on the account, as a Secure String

Must meet the password complexity requirements

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

### -userType
The user type

Minimum required version 10.9

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

### -unAuthorizedInterfaces
The CyberArk interfaces that this user is not authorized to use.

Minimum required version 10.9

```yaml
Type: String[]
Parameter Sets: Gen2
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -enableUser
Whether the user will be enabled upon creation.

Minimum required version 10.9

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

### -authenticationMethod
The authentication method that the user will use to log on.

Valid Values:
- "AuthTypePass", for CyberArk Authentication (default)
- "AuthTypeLDAP", for LDAP authentication
- "AuthTypeRADIUS", for RADIUS authentication

Minimum required version 10.9

```yaml
Type: String[]
Parameter Sets: Gen2
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Email
The user's email address

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

### -ChangePassOnNextLogon
Whether or not user will be forced to change password on first logon

Minimum required version 10.9

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

### -ChangePasswordOnTheNextLogon
Whether or not user will be forced to change password on first logon

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

### -passwordNeverExpires
Whether or not the user's password will expire

Minimum required version 10.9

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

### -distinguishedName
The distinguished name of the user.

Minimum required version 10.9

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

### -vaultAuthorization
The user permissions in the vault.

To grant authorization to a user, the same authorization must be held by the account logged on to the API.

Valid values:
-  AddSafes
-  AuditUsers
-  AddUpdateUsers
-  ResetUsersPasswords
-  ActivateUsers
-  AddNetworkAreas
-  ManageDirectoryMapping
-  ManageServerFileCategories
-  BackupAllSafes
-  RestoreAllSafes

Minimum required version 10.9

```yaml
Type: String[]
Parameter Sets: Gen2
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ExpiryDate
Expiry Date to set on account.

Default is Never

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UserTypeName
The Type of User to create.

EPVUser type will be created by default.

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

### -Disabled
Whether or not the user will be created as a disabled user

Default is Enabled

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

### -Location
The Vault Location where the user will be created

Default location is "Root"

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

### -workStreet
Business Address detail for the user

Minimum required version 10.9

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

### -workCity
Business Address detail for the user

Minimum required version 10.9

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

### -workState
Business Address detail for the user

Minimum required version 10.9

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

### -workZip
Business Address detail for the user

Minimum required version 10.9

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

### -workCountry
Business Address detail for the user

Minimum required version 10.9

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

### -homePage
The user's email address

Minimum required version 10.9

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

### -homeEmail
The user's email address

Minimum required version 10.9

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

### -businessEmail
The user's email address

Minimum required version 10.9

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

### -otherEmail
The user's email address

Minimum required version 10.9

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

### -homeNumber
The user's phone number

Minimum required version 10.9

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

### -businessNumber
The user's phone number

Minimum required version 10.9

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

### -cellularNumber
The user's phone number

Minimum required version 10.9

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

### -faxNumber
The user's phone number

Minimum required version 10.9

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

### -pagerNumber
The user's phone number

Minimum required version 10.9

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

### -description
Description Text

Minimum required version 10.9

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

### -FirstName
The user's first name

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

### -MiddleName
The User's Middle Name

Minimum required version 10.9

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

### -LastName
The user's last name

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

### -street
Address detail for the user

Minimum required version 10.9

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

### -city
Address detail for the user

Minimum required version 10.9

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

### -state
Address detail for the user

Minimum required version 10.9

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

### -zip
Address detail for the user

Minimum required version 10.9

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

### -country
Address detail for the user

Minimum required version 10.9

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

### -title
Personal detail for the user

Minimum required version 10.9

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

### -organization
Personal detail for the user

Minimum required version 10.9

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

### -department
Personal detail for the user

Minimum required version 10.9

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

### -profession
Personal detail for the user

Minimum required version 10.9

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

### -UseGen1API
Specify to force usage the Gen1 API endpoint.

Should be specified for versions earlier than 10.9

```yaml
Type: SwitchParameter
Parameter Sets: Gen1
Aliases: UseClassicAPI

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -loginFromHour
The start of the timeframe the user account is permitted to authenticate.

Provide an hour of the day in 24-hour format (0-23)

Minimum required version 13.2


```yaml
Type: Int32
Parameter Sets: Gen2
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -loginToHour
The end of the timeframe the user account is permitted to authenticate.

Provide an hour of the day in 24-hour format (0-23)

Minimum required version 13.2


```yaml
Type: Int32
Parameter Sets: Gen2
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -userActivityLogRetentionDays
The number of days that a user's account activity records are stored before being deleted.
These activity records includes logon, logoff, and user management.

If this parameter is set to zero, user activities in the Vault will not be written in the audit log.

Default value: 90 days

Minimum required version 13.2


```yaml
Type: Int32
Parameter Sets: Gen2
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

[https://pspas.pspete.dev/commands/New-PASUser](https://pspas.pspete.dev/commands/New-PASUser)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/API-AddUser-v10.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/API-AddUser-v10.htm)
