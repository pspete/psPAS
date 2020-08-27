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
Returns details of a user

## SYNTAX

### 10.9 (Default)
```
Get-PASUser [-Search <String>] [-UserType <String>] [-ComponentUser <Boolean>] [<CommonParameters>]
```

### 10.10
```
Get-PASUser -id <Int32> [<CommonParameters>]
```

### legacy
```
Get-PASUser -UserName <String> [<CommonParameters>]
```

## DESCRIPTION
Returns information on specific vault user.

## EXAMPLES

### EXAMPLE 1
```
Get-PASUser
```

Returns information for all found Users

### EXAMPLE 2
```
Get-PASUser -id 123
```

Returns information on User with id 123

### EXAMPLE 3
```
Get-PASUser -search SearchTerm -ComponentUser $False
```

Returns information for all matching Users

### EXAMPLE 4
```
Get-PASUser -UserName Target_User
```

Displays information on Target_User

## PARAMETERS

### -id
The numeric id of the user to return details of.

Requires CyberArk version 10.10+

```yaml
Type: Int32
Parameter Sets: 10.10
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Search
Search string.

Requires CyberArk version 10.9+

```yaml
Type: String
Parameter Sets: 10.9
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UserType
The type of the user.

Requires CyberArk version 10.9+

```yaml
Type: String
Parameter Sets: 10.9
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ComponentUser
Whether the user is a known component or not.

Requires CyberArk version 10.9+

```yaml
Type: Boolean
Parameter Sets: 10.9
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
Parameter Sets: legacy
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

[https://pspas.pspete.dev/commands/Get-PASUser](https://pspas.pspete.dev/commands/Get-PASUser)

