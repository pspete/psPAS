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
Get-PASUser [-Search <String>] [-UserType <String>] [-ComponentUser <Boolean>] [<CommonParameters>]
```

### Gen2ID
```
Get-PASUser -id <Int32> [<CommonParameters>]
```

### Gen2-ExtendedDetails
```
Get-PASUser [-Search <String>] [-UserType <String>] [-ComponentUser <Boolean>] [-ExtendedDetails <Boolean>]
 [<CommonParameters>]
```

### Gen1
```
Get-PASUser -UserName <String> [<CommonParameters>]
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASUser](https://pspas.pspete.dev/commands/Get-PASUser)

