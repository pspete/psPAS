---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASAllowedReferrer
schema: 2.0.0
title: Get-PASAllowedReferrer
---

# Get-PASAllowedReferrer

## SYNOPSIS
Gets the allowed referrer list

## SYNTAX

```
Get-PASAllowedReferrer [<CommonParameters>]
```

## DESCRIPTION
Returns details of all configured entries from the allowed referrer list.

Vault admins group membership required

## EXAMPLES

### EXAMPLE 1
```
Get-PASAllowedReferrer
```

Returns referrer list

### EXAMPLE 2
```
Get-PASAllowedReferrer | Where-Object referrerURL -like '*.company.com*'
```

Returns only the allowed referrer entries whose URL matches "*.company.com*".

### EXAMPLE 3
```
Get-PASAllowedReferrer | Format-List *
```

Displays full details of every configured allowed referrer entry.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASAllowedReferrer](https://pspas.pspete.dev/commands/Get-PASAllowedReferrer)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Get_Allowed_Referrer.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Get_Allowed_Referrer.htm)
