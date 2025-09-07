---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Deny-PASRequest
schema: 2.0.0
title: Deny-PASRequest
---

# Deny-PASRequest

## SYNOPSIS
Reject a single request

## SYNTAX

```
Deny-PASRequest [-RequestId] <String[]> [[-Reason] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Enables a request confirmer to reject requests identified by their requestID.

Officially supported from version 9.10.

Bulk rejection of requests using a single command invocation is supported from version 14.6

## EXAMPLES

### EXAMPLE 1
```
Deny-PASRequest -RequestID <ID> -Reason "<Reason>"
```

Denies request \<ID\>

### EXAMPLE 2
```
Deny-PASRequest -RequestID SomeSafe1_1, SomeSafe1_2, SomeSafe1_3 -Reason " Some Reason"
```

Denies requests SomeSafe1_1, SomeSafe1_2 & SomeSafe1_3


## PARAMETERS

### -RequestId
The ID of the request(s) to reject

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Reason
The reason why the request is rejected

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

[https://pspas.pspete.dev/commands/Deny-PASRequest](https://pspas.pspete.dev/commands/Deny-PASRequest)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/RejectRequest.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/RejectRequest.htm)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/bulkrejectrequest.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/bulkrejectrequest.htm)
