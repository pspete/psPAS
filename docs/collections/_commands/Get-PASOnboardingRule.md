---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASOnboardingRule
schema: 2.0.0
title: Get-PASOnboardingRule
---

# Get-PASOnboardingRule

## SYNOPSIS
Gets all automatic on-boarding rules

## SYNTAX

```
Get-PASOnboardingRule [-Names <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns information on defined on-boarding rules.

Vault Admin membership required.

## EXAMPLES

### EXAMPLE 1
```
Get-PASOnboardingRule
```

List information on all On-boarding rules

### EXAMPLE 2
```
Get-PASOnboardingRule -Names Rule1,Rule2
```

List information on On-boarding rules "Rule1" & "Rule2"

## PARAMETERS

### -Names
A filter that specifies the rule name.

Separate a list of rules with commas.

If not specified, all rules will be returned.

For version 10.2 onwards (not a supported parameter on earlier versions)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
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

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASOnboardingRule](https://pspas.pspete.dev/commands/Get-PASOnboardingRule)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetAutoOnboardingRules.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetAutoOnboardingRules.htm)
