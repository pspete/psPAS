---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASUserLicenseReport
schema: 2.0.0
title: Get-PASUserLicenseReport
---

# Get-PASUserLicenseReport

## SYNOPSIS
Returns information about usage of the Privilege Cloud user licenses defined in your system

## SYNTAX

```
Get-PASUserLicenseReport [<CommonParameters>]
```

## DESCRIPTION
Returns information about usage of the Privilege Cloud user licenses

A license is in use in one of the following scenarios:
- A user is connected using a license
- A user is added to a Safe using a license

User license types
- Privileged Basic User
- Privileged Standard Lite User
- Privileged Standard User
- Privileged External User
- Credential Providers (CPs/CCPs)
- Total Applications

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-PASUserLicenseReport
```

Returns information about usage of the Privilege Cloud user licenses

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASUserLicenseReport](https://pspas.pspete.dev/commands/Get-PASUserLicenseReport)

[https://docs.cyberark.com/privilege-cloud-shared-services/latest/en/content/privilegecloudapis/privcloud-user-licenses-report.htm](https://docs.cyberark.com/privilege-cloud-shared-services/latest/en/content/privilegecloudapis/privcloud-user-licenses-report.htm)