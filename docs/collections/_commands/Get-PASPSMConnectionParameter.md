---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/New-PASPSMSession
schema: 2.0.0
title: Get-PASPSMConnectionParameter
---

# Get-PASPSMConnectionParameter

## SYNOPSIS
Get required parameters to connect through PSM

## SYNTAX

## DESCRIPTION
This method enables you to connect to an account through PSM (PSMConnect).
The function returns either an RDP file or URL for PSM connections.
It requires the PVWA and PSM to be configured for either transparent connections through PSM with RDP files
or the HTML5 Gateway.

## EXAMPLES

### EXAMPLE 1
```
New-PASPSMSession -AccountID $ID -ConnectionComponent PSM-SSH -reason "Fix XYZ"
```

Outputs RDP file for Direct Connection via PSM using account with ID in $ID

### EXAMPLE 2
```
New-PASPSMSession -AccountID $id -ConnectionComponent PSM-RDP -AllowMappingLocalDrives No -PSMRemoteMachine ServerName
```

Provide connection parameters for the new PSM connection

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Minimum CyberArk Version 9.10
PSMGW connections require 10.2
Ad-Hoc connections require 10.5

## RELATED LINKS

[https://pspas.pspete.dev/commands/New-PASPSMSession](https://pspas.pspete.dev/commands/New-PASPSMSession)

