---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASComponentSummary
schema: 2.0.0
title: Get-PASComponentSummary
---

# Get-PASComponentSummary

## SYNOPSIS
Returns consolidated information about CyberArk Components.

## SYNTAX

```
Get-PASComponentSummary [<CommonParameters>]
```

## DESCRIPTION
Returns consolidated information about the Vault, PVWA, CPM, PSM/PSMP and AIM.

Includes all clients that are relevant to each specific component.

## EXAMPLES

### EXAMPLE 1
```
Get-PASComponentSummary
```

Displays CyberArk Component information

### EXAMPLE 2
```
Get-PASComponentSummary | Where-Object ComponentID -eq 'CPM'
```

Returns component summary information for the CPM component only.

### EXAMPLE 3
```
Get-PASComponentSummary | Where-Object Role -eq 'DR'
```

Returns information about any Disaster Recovery vault, including replication status details when connected to CyberArk version 14.6 or later.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Requires minimum version of CyberArk 10.1.

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASComponentSummary](https://pspas.pspete.dev/commands/Get-PASComponentSummary)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/SystemSummary.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/SystemSummary.htm)
