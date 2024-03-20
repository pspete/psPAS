---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Set-PASOnboardingRule
schema: 2.0.0
title: Set-PASOnboardingRule
---

# Set-PASOnboardingRule

## SYNOPSIS
Updates an automatic onboarding rule.

## SYNTAX

```
Set-PASOnboardingRule [-Id] <Int32> [[-TargetPlatformId] <String>] [[-TargetSafeName] <String>]
 [[-IsAdminIDFilter] <Boolean>] [[-MachineTypeFilter] <String>] [[-SystemTypeFilter] <String>]
 [[-UserNameFilter] <String>] [[-UserNameMethod] <String>] [[-AddressFilter] <String>]
 [[-AddressMethod] <String>] [[-AccountCategoryFilter] <String>] [[-RuleName] <String>]
 [[-RuleDescription] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates an existing automatic onboarding rule.

## EXAMPLES

### EXAMPLE 1
```
Set-PASOnboardingRule -Id 1 -TargetPlatformId WINDOMAIN -TargetSafeName SafeName -SystemTypeFilter Windows
```

Updates Onboarding Rule with ID 1

## PARAMETERS

### -Id
The ID of the rule to update.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TargetPlatformId
The ID of the platform that will be associated to the on-boarded account.

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

### -TargetSafeName
The name of the Safe where the on-boarded account will be stored.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -IsAdminIDFilter
Whether or not UNIX accounts with UID=0 or Windows accounts with SID ending in 500 will be onboarded automatically
using this rule.

If set to false, all accounts matching the rule will be onboarded.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MachineTypeFilter
The Machine Type by which to filter.

Leave blank for "Any"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SystemTypeFilter
The System Type by which to filter.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UserNameFilter
The name of the user by which to filter.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UserNameMethod
The method to use when applying the user name filter (Equals / Begins with/ Ends with).

This parameter is ignored if UserNameFilter is not specified.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AddressFilter
IP Address or DNS name of the machine by which to filter.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AddressMethod
The method to use when applying the address filter (Equals / Begins with/ Ends with).

This parameter is ignored if AddressFilter is not specified.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AccountCategoryFilter
Filter for Privileged or Non-Privileged accounts.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RuleName
Name of the rule

If left blank, a name will be generated automatically.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RuleDescription
A description of the rule.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
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
Minimum Version: 10.5

## RELATED LINKS

[https://pspas.pspete.dev/commands/Set-PASOnboardingRule](https://pspas.pspete.dev/commands/Set-PASOnboardingRule)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/EditAutomaticOnboardingRule.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/EditAutomaticOnboardingRule.htm)
