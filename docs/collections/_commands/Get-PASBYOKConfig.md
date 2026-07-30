---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASBYOKConfig
schema: 2.0.0
title: Get-PASBYOKConfig
---

# Get-PASBYOKConfig

## SYNOPSIS
Get the BYOK status.

## SYNTAX

```
Get-PASBYOKConfig [<CommonParameters>]
```

## DESCRIPTION
Get the BYOK status of the system, access policy, current key in use, and customer details.

Requires one of the following roles:
- System Administrator (Identity Administration)
- Privilege Cloud Administrator
- Privilege Cloud Administrator Basic
- Privilege Cloud Administrator Lite

## EXAMPLES

### EXAMPLE 1
```powershell
Get-PASBYOKConfig
```

Get the BYOK status

### EXAMPLE 2
```powershell
Get-PASBYOKConfig | Format-List *
```

Displays full details of the BYOK configuration, including the current status, access policy, current key in use, and customer details.

### EXAMPLE 3
```powershell
Get-PASBYOKConfig | Export-Csv -Path .\BYOKConfig.csv -NoTypeInformation
```

Exports the current BYOK configuration details to a CSV file for reporting purposes.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASBYOKConfig](https://pspas.pspete.dev/commands/Get-PASBYOKConfig)

[https://docs.cyberark.com/snapshot/ispss-deployment/en/content/privilege%20cloud/privcloud-byok-api-status.htm](https://docs.cyberark.com/snapshot/ispss-deployment/en/content/privilege%20cloud/privcloud-byok-api-status.htm)
