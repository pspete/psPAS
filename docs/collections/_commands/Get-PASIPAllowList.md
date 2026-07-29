---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASIPAllowList
schema: 2.0.0
title: Get-PASIPAllowList
---

# Get-PASIPAllowList

## SYNOPSIS
List allowed IP addresses that are enabled for communication with the Privilege Cloud SaaS environment.

## SYNTAX

```
Get-PASIPAllowList [<CommonParameters>]
```

## DESCRIPTION
Requires one of the following roles:
- Privilege Cloud Administrator
- Privilege Cloud Administrator Basic
- Privilege Cloud Administrator Lite

## EXAMPLES

### EXAMPLE 1
```powershell
Get-PASIPAllowList
```

List the current IP Allow List configuration

### EXAMPLE 2
```powershell
(Get-PASIPAllowList).customerPublicIPs
```

Returns just the list of IP addresses and subnets currently permitted to communicate with the Privilege Cloud SaaS environment.

### EXAMPLE 3
```powershell
if (-not (Get-PASIPAllowList).updateInProgress) {
    Set-PASIPAllowList -customerPublicIPs '10.0.0.0/24','192.168.1.0/28'
}
```

Checks that no IP Allow List update is already in progress before applying a new configuration.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASIPAllowList](https://pspas.pspete.dev/commands/Get-PASIPAllowList)

[https://docs.cyberark.com/privilege-cloud-shared-services/latest/en/Content/PrivilegeCloudAPIs/PrivCloud-IP-allowlist-Get-API.htm](https://docs.cyberark.com/privilege-cloud-shared-services/latest/en/Content/PrivilegeCloudAPIs/PrivCloud-IP-allowlist-Get-API.htm)
