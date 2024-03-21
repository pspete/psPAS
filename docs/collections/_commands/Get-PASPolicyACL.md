---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASPolicyACL
schema: 2.0.0
title: Get-PASPolicyACL
---

# Get-PASPolicyACL

## SYNOPSIS
Lists OPM Rules for a policy

## SYNTAX

```
Get-PASPolicyACL [-PolicyID] <String> [<CommonParameters>]
```

## DESCRIPTION
Gets a list of the privileged commands (OPM Rules) associated with this policy

Not supported in Privilege Cloud

## EXAMPLES

### EXAMPLE 1
```
Get-PASPolicyACL -PolicyID unixssh
```

Lists rules for UNIXSSH platform.

## PARAMETERS

### -PolicyID
The ID of the Policy for which the privileged commands will be listed.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASPolicyACL](https://pspas.pspete.dev/commands/Get-PASPolicyACL)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/List%20Policy%20ACL.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/List%20Policy%20ACL.htm)
