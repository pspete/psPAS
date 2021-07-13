---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Approve-PASRequest
schema: 2.0.0
title: Approve-PASRequest
---

# Approve-PASRequest

## SYNOPSIS
Confirm a single request

## SYNTAX

```
Approve-PASRequest [-RequestId] <String> [[-Reason] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Enables a request confirmer to confirm a single request, identified by its requestID.

Officially supported from version 9.10.

Reports received that function works in 9.9 also.

## EXAMPLES

### EXAMPLE 1
```
Approve-PASRequest -RequestID <ID> -Reason "<Reason>"
```

Confirms request \<ID\>

## PARAMETERS

### -RequestId
The ID of the request to confirm

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

### -Reason
The reason why the request is approved

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Minimum CyberArk Version 9.10

## RELATED LINKS

[https://pspas.pspete.dev/commands/Approve-PASRequest](https://pspas.pspete.dev/commands/Approve-PASRequest)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/ConfirmRequest.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/ConfirmRequest.htm)
