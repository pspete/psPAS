---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASRequestDetail
schema: 2.0.0
title: Get-PASRequestDetail
---

# Get-PASRequestDetail

## SYNOPSIS
Gets requests

## SYNTAX

```
Get-PASRequestDetail [-RequestType] <String> [-RequestID] <String> [<CommonParameters>]
```

## DESCRIPTION
Gets Requests

Officially supported from version 9.10.

Reports received that function works in 9.9 also.

## EXAMPLES

### EXAMPLE 1
```
Get-PASRequestDetail -RequestType IncomingRequests -RequestID $ID
```

Gets details of request with ID held in $ID

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

### -RequestID
The request's uniqueID, composed of the Safe Name and internal RequestID.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
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

[https://pspas.pspete.dev/commands/Get-PASRequestDetail](https://pspas.pspete.dev/commands/Get-PASRequestDetail)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetDetailsMyRequest.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetDetailsMyRequest.htm)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetDetailsRequestConfirmation.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetDetailsRequestConfirmation.htm)
