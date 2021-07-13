---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASApplicationAuthenticationMethod
schema: 2.0.0
title: Get-PASApplicationAuthenticationMethod
---

# Get-PASApplicationAuthenticationMethod

## SYNOPSIS
Returns information about all of the authentication methods of a specific application.

## SYNTAX

```
Get-PASApplicationAuthenticationMethod [-AppID] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns information about all of the authentication methods of a specific application.

The user authenticated to the vault running the command must have the "Audit Users" permission.

## EXAMPLES

### EXAMPLE 1
```
Get-PASApplicationAuthenticationMethod -AppID NewApp
```

Gets all authentication methods of application NewApp

## PARAMETERS

### -AppID
The name of the application for which information about authentication methods will be returned.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASApplicationAuthenticationMethod](https://pspas.pspete.dev/commands/Get-PASApplicationAuthenticationMethod)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/List%20all%20Authentication%20Methods%20of%20a%20Specific%20Application.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/List%20all%20Authentication%20Methods%20of%20a%20Specific%20Application.htm)
