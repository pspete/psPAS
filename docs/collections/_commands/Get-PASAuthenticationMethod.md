---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version:
schema: 2.0.0
title: Get-PASAuthenticationMethod
---

# Get-PASAuthenticationMethod

## SYNOPSIS
List authentication methods

## SYNTAX

```
Get-PASAuthenticationMethod [[-ID] <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns a list of all existing authentication methods.

Membership of Vault admins group required

## EXAMPLES

### EXAMPLE 1
```
Get-PASAuthenticationMethod
```

Returns list of all authentication methods.

## PARAMETERS

### -ID
The ID of a specific authentication method to return details of

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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
