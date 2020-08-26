---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASRequest
schema: 2.0.0
title: Get-PASRequest
---

# Get-PASRequest

## SYNOPSIS
Gets requests

## SYNTAX

```
Get-PASRequest [-RequestType] <String> [-OnlyWaiting] <Boolean> [-Expired] <Boolean> [<CommonParameters>]
```

## DESCRIPTION
Gets Requests
Officially supported from version 9.10.
Reports received that function works in 9.9 also.

## EXAMPLES

### EXAMPLE 1
```
Get-PASRequest -RequestType IncomingRequests -OnlyWaiting $true
```

Lists waiting incoming requests

### EXAMPLE 2
```
Get-PASRequest -RequestType MyRequests -Expired $false
```

Lists your none expired (outgoing) requests.

## PARAMETERS

### -RequestType
Specify whether outgoing or incoming requests will be searched for

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -OnlyWaiting
Only requests waiting for approval will be listed

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Expired
Expired requests will be included in the list

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Minimum CyberArk Version 9.10

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASRequest](https://pspas.pspete.dev/commands/Get-PASRequest)

