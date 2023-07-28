---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASUser
schema: 2.0.0
title: Get-PASUser
---

# Get-PASUser

## SYNOPSIS
Returns details of vault users

## SYNTAX

### Gen2 (Default)
```
Get-PASUser [-Search <String>] [-UserType <String>] [-UserStatus <String>] [-source <String>]
 [-ComponentUser <Boolean>] [-sort <String[]>] [-UserName <String>] [<CommonParameters>]
```

### Gen2ID
```
Get-PASUser -id <Int32> [<CommonParameters>]
```

### Gen2-ExtendedDetails
```
Get-PASUser [-Search <String>] [-UserType <String>] [-UserStatus <String>] [-source <String>]
 [-ComponentUser <Boolean>] [-sort <String[]>] [-ExtendedDetails <Boolean>] [-UserName <String>]
 [<CommonParameters>]
```

### Gen1
```
Get-PASUser -UserName <String> [-UseGen1API] [<CommonParameters>]
```

## DESCRIPTION
Returns information on queried vault users

Default operation using the Gen2 API requires minimum version of 10.9

## EXAMPLES

### EXAMPLE 1
```
Get-PASUser
```

Returns information for all found Users

Minimum required version 10.9

### EXAMPLE 2
```
Get-PASUser -id 123
```

Returns information on User with id 123

Minimum required version 10.10

### EXAMPLE 3
```
Get-PASUser -search SearchTerm -ComponentUser $False
```

Returns information for all matching Users

Minimum required version 10.9

### EXAMPLE 4
```
Get-PASUser -UserName Target_User
```

Displays information on Target_User

### EXAMPLE 5
```
Get-PASUser -ExtendedDetails $true -Search SomeSearchTerm
```

Returns extended information for all matching Users

Minimum required version 12.1

### EXAMPLE 6
```
Get-PASUser -UserStatus Suspended -source LDAP
```

Returns all currently suspended LDAP users

Minimum required version 13.2

## PARAMETERS

### -id
The numeric id of the user to return details of.

Minimum required version 10.10

```yaml
Type: Int32
Parameter Sets: Gen2ID
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Search
Search string.

Minimum required version 10.9

```yaml
Type: String
Parameter Sets: Gen2, Gen2-ExtendedDetails
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UserType
The type of the user.

Minimum required version 10.9

```yaml
Type: String
Parameter Sets: Gen2, Gen2-ExtendedDetails
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ComponentUser
Whether the user is a known component or not.

Minimum required version 10.9

```yaml
Type: Boolean
Parameter Sets: Gen2, Gen2-ExtendedDetails
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UserName
The user's name

Default operation targets the Gen2 API & requires minimum version of 12.2.

For operation against versions earlier than 12.2, the `UseGen1API` parameter should also be specified.

```yaml
Type: String
Parameter Sets: Gen2, Gen2-ExtendedDetails
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

### -ExtendedDetails
Returns user groups and userDN for LDAP users.

Minimum required version 12.1

```yaml
Type: Boolean
Parameter Sets: Gen2-ExtendedDetails
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -sort
Property or properties by which to sort returned accounts,
followed by asc (default) or desc to control sort direction.

Cannot sort by a property other than `username`, `usertype`, `firstname`, `lastname`, `location`, `middlename` or `source`.

Separate multiple properties with commas, up to a maximum of three properties.

Requires minimum version of 12.2

```yaml
Type: String[]
Parameter Sets: Gen2, Gen2-ExtendedDetails
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UseGen1API
Forces use of the Gen1 API endpoint

```yaml
Type: SwitchParameter
Parameter Sets: Gen1
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -source
Specify "CyberArk" to return local CyberArk users, or "LDAP" to return users from an integrated directory.

Requires minimum version of 13.2

```yaml
Type: String
Parameter Sets: Gen2, Gen2-ExtendedDetails
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UserStatus
Accepts "Active", "Disabled" or "Suspended" as possible filter values.

Requires minimum version of 13.2

```yaml
Type: String
Parameter Sets: Gen2, Gen2-ExtendedDetails
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

[https://pspas.pspete.dev/commands/Get-PASUser](https://pspas.pspete.dev/commands/Get-PASUser)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/get-users-api.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/get-users-api.htm)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/get-user-details-v10.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/get-user-details-v10.htm)
