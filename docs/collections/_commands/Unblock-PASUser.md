---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Unblock-PASUser
schema: 2.0.0
title: Unblock-PASUser
---

# Unblock-PASUser

## SYNOPSIS
Activates a suspended user

## SYNTAX

### 10.10 (Default)
```
Unblock-PASUser -id <Int32> [<CommonParameters>]
```

### ClassicAPI
```
Unblock-PASUser -UserName <String> -Suspended <Boolean> [<CommonParameters>]
```

## DESCRIPTION
Activates an existing vault user who was suspended due to password failures.

## EXAMPLES

### EXAMPLE 1
```
Unblock-PASUser -UserName MrFatFingers -Suspended $false
```

Activates suspended vault user MrFatFingers using the Classic API

### EXAMPLE 2
```
Unblock-PASUser -id 666
```

Activates suspended vault user with id 666, using the API from 10.10+

## PARAMETERS

### -id
The user's unique ID
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

### -UserName
The user's name

```yaml
Type: String
Parameter Sets: ClassicAPI
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Suspended
Suspension status

```yaml
Type: Boolean
Parameter Sets: ClassicAPI
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Unblock-PASUser](https://pspas.pspete.dev/commands/Unblock-PASUser)

