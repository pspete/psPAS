---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASPTAGlobalCatalog
schema: 2.0.0
title: Get-PASPTAGlobalCatalog
---

# Get-PASPTAGlobalCatalog

## SYNOPSIS
Get Global Catalog connectivity details from PTA.

## SYNTAX

```
Get-PASPTAGlobalCatalog [<CommonParameters>]
```

## DESCRIPTION
Returns the Global Catalog connectivity details as set in PTA Administration.
Membership of either Vault Admins or Security Admins group is required.
Requires minimum version of 13.0.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-PASPTAGlobalCatalog
```

Returns Global Catalog configuration details from PTA

### EXAMPLE 2
```powershell
(Get-PASPTAGlobalCatalog).ldap_server
```

Returns just the configured Global Catalog server address

### EXAMPLE 3
```powershell
Get-PASPTAGlobalCatalog | Select-Object ldap_server, ldap_port, ssl
```

Returns only the connectivity-related properties of the Global Catalog configuration

### EXAMPLE 4
```powershell
if ((Get-PASPTAGlobalCatalog).ssl) { 'Global Catalog connection is encrypted' } else { 'Global Catalog connection is not encrypted' }
```

Returns a message indicating whether the Global Catalog connection is configured to use SSL

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASPTAGlobalCatalog](https://pspas.pspete.dev/commands/Get-PASPTAGlobalCatalog)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Get-Global-Catalog.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Get-Global-Catalog.htm)