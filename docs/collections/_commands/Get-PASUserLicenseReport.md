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

### Example 2
```powershell
PS C:\> $LicenseReport = Get-PASUserLicenseReport
PS C:\> $LicenseReport | Format-List *
```

Retrieves the Privilege Cloud user license usage report and displays all returned properties.

### Example 3
```powershell
PS C:\> Get-PASUserLicenseReport | Export-Csv -Path C:\Reports\UserLicenseReport.csv -NoTypeInformation
```

Exports the Privilege Cloud user license usage report to a CSV file for offline reporting.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASUserLicenseReport](https://pspas.pspete.dev/commands/Get-PASUserLicenseReport)

[https://docs.cyberark.com/privilege-cloud-shared-services/latest/en/content/privilegecloudapis/privcloud-user-licenses-report.htm](https://docs.cyberark.com/privilege-cloud-shared-services/latest/en/content/privilegecloudapis/privcloud-user-licenses-report.htm)