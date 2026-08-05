---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASDiscoveryScan
schema: 2.0.0
title: Get-PASDiscoveryScan
---

# Get-PASDiscoveryScan

## SYNOPSIS
Returns configured discovery scans.

## SYNTAX

### byQuery (Default)
```
Get-PASDiscoveryScan [<CommonParameters>]
```

### byID
```
Get-PASDiscoveryScan -taskId <Int32> [<CommonParameters>]
```

## DESCRIPTION
Returns discovery scans configured in the Vault.

Specify a taskId to return details of a single discovery scan.

Membership of Vault admins or PVWAAccountsFeedAdmins group required.

## EXAMPLES

### EXAMPLE 1
```
Get-PASDiscoveryScan
```

Returns all configured discovery scans.

### EXAMPLE 2
```
Get-PASDiscoveryScan -taskId 1
```

Returns details of the discovery scan with taskId 1.

## PARAMETERS

### -taskId
The unique ID of the discovery scan to return details of.

```yaml
Type: Int32
Parameter Sets: byID
Aliases: id

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASDiscoveryScan](https://pspas.pspete.dev/commands/Get-PASDiscoveryScan)
