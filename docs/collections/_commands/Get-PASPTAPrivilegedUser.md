---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASPTAPrivilegedUser
schema: 2.0.0
title: Get-PASPTAPrivilegedUser
---

# Get-PASPTAPrivilegedUser

## SYNOPSIS
Get PTA PrivilegedUsersList

## SYNTAX

```
Get-PASPTAPrivilegedUser [[-ValueType] <String>] [<CommonParameters>]
```

## DESCRIPTION
Return PrivilegedUsersList from PTA

## EXAMPLES

### EXAMPLE 1
```powershell
Get-PASPTAPrivilegedUser
```

Return PrivilegedUsersList PTA security configuration

## PARAMETERS

### -ValueType
Specify to return ActualValue or DefaultValue.
ActualValue is returned by default.

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

[https://pspas.pspete.dev/commands/Get-PASPTAPrivilegedUser](https://pspas.pspete.dev/commands/Get-PASPTAPrivilegedUser)

[https://docs.cyberark.com/PAS/Latest/en/Content/WebServices/GetSecurity.htm](https://docs.cyberark.com/PAS/Latest/en/Content/WebServices/GetSecurity.htm)
