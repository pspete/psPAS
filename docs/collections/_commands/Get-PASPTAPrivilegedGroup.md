---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASPTAPrivilegedGroup
schema: 2.0.0
title: Get-PASPTAPrivilegedGroup
---

# Get-PASPTAPrivilegedGroup

## SYNOPSIS
Get configured PTA PrivilegedDomainGroupsList

## SYNTAX

```
Get-PASPTAPrivilegedGroup [<CommonParameters>]
```

## DESCRIPTION
Return PrivilegedDomainGroupsList from PTA

## EXAMPLES

### EXAMPLE 1
```powershell
Get-PASPTAPrivilegedGroup
```

Return PrivilegedDomainGroupsList from PTA

### EXAMPLE 2
```powershell
Get-PASPTAPrivilegedGroup | Where-Object { $_.domain -eq 'cyberark.local' }
```

Returns only the configured privileged domain groups for the cyberark.local domain.

### EXAMPLE 3
```powershell
Get-PASPTAPrivilegedGroup | Where-Object { $_.group -eq 'Domain Admins' } | Remove-PASPTAPrivilegedGroup
```

Finds the Domain Admins group configuration and removes it from PTA.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASPTAPrivilegedGroup](https://pspas.pspete.dev/commands/Get-PASPTAPrivilegedGroup)

[https://docs.cyberark.com/PAS/Latest/en/Content/WebServices/GetSecurity.htm](https://docs.cyberark.com/PAS/Latest/en/Content/WebServices/GetSecurity.htm)
