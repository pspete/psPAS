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
Gets and displays status for incoming, outgoing or bulk action requests

Getting bulk action requests requires Add accounts, Update account content, and Update account properties authorization on at least one Safe.

## SYNTAX

### Requests
```
Get-PASRequest [-RequestType] <String> [-OnlyWaiting] <Boolean> [-Expired] <Boolean> [<CommonParameters>]
```

### bulkactions
```
Get-PASRequest -id <Int32> [-DisplayExtendedItems <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
Check the status of the bulk account access, incoming or outgoing request

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

### EXAMPLE 3
```
Get-PASRequest -id 1234 -DisplayExtendedItems $true
```

Gets status of bulk action request

## PARAMETERS

### -RequestType
Specify whether outgoing or incoming requests will be searched for

```yaml
Type: String
Parameter Sets: Requests
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
Parameter Sets: Requests
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
Parameter Sets: Requests
Aliases:

Required: True
Position: 3
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DisplayExtendedItems
Determines whether the succeededItems or failedItems parameters return data for the items, in addition to the index.

When this parameter is set to True, the API throughput may be higher.

Requires minimum version of 13.2

```yaml
Type: Boolean
Parameter Sets: bulkactions
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -id
The id of a bulk action request.

Requires minimum version of 13.2

```yaml
Type: Int32
Parameter Sets: bulkactions
Aliases:

Required: True
Position: Named
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

[https://pspas.pspete.dev/commands/Get-PASRequest](https://pspas.pspete.dev/commands/Get-PASRequest)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetMyRequests.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetMyRequests.htm)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetIncomingRequestList.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetIncomingRequestList.htm)
