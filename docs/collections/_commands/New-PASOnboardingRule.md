---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/New-PASOnboardingRule
schema: 2.0.0
title: New-PASOnboardingRule
---

# New-PASOnboardingRule

## SYNOPSIS
Adds a new on-boarding rule to the Vault

## SYNTAX

### Gen2 (Default)
```
New-PASOnboardingRule -TargetPlatformId <String> -TargetSafeName <String> [-IsAdminIDFilter <Boolean>]
 [-MachineTypeFilter <String>] -SystemTypeFilter <String> [-UserNameFilter <String>] [-UserNameMethod <String>]
 [-AddressFilter <String>] [-AddressMethod <String>] [-AccountCategoryFilter <String>] [-RuleName <String>]
 [-RuleDescription <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Gen1
```
New-PASOnboardingRule -DecisionSafeName <String> -DecisionPlatformId <String> [-IsAdminUIDFilter <String>]
 [-MachineTypeFilter <String>] -SystemTypeFilter <String> [-UserNameFilter <String>] [-AddressFilter <String>]
 [-RuleName <String>] [-RuleDescription <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds a new on-boarding rule to the Vault, that filters discovered local privileged pending accounts.

When a discovered pending account matches a rule, it will be automatically on-boarded to the safe that
is defined in the rule and the password will be reconciled.

If a newly discovered account does not match any rule, it will be added to the PendingAccounts list.

This function must be run with a Vault Admin account.

## EXAMPLES

### EXAMPLE 1
```
New-PASOnboardingRule -DecisionPlatformId DecisionPlatform -DecisionSafeName DecisionSafe -SystemTypeFilter Windows
```

Adds Onboarding Rule for Windows Accounts

## PARAMETERS

### -DecisionPlatformId
The ID of the platform that will be associated to the on-boarded account.

For Versions 9.8 to 10.1

```yaml
Type: String
Parameter Sets: Gen1
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TargetPlatformId
The ID of the platform that will be associated to the on-boarded account.

For Version 10.2 onwards

```yaml
Type: String
Parameter Sets: Gen2
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DecisionSafeName
The name of the Safe where the on-boarded account will be stored.

For Versions 9.8 to 10.1

```yaml
Type: String
Parameter Sets: Gen1
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TargetSafeName
The name of the Safe where the on-boarded account will be stored.

For Version 10.2 onwards

```yaml
Type: String
Parameter Sets: Gen2
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -IsAdminUIDFilter
Whether or not only pending accounts whose UID is set to will be on-boarded
automatically according to this rule.

For Versions 9.8 to 10.1

```yaml
Type: String
Parameter Sets: Gen1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -IsAdminIDFilter
Whether or not UNIX accounts with UID=0 or Windows accounts with SID ending in 500 will be onboarded automatically using this rule.

If set to false, all accounts matching the rule will be onboarded.

For Version 10.2 onwards

```yaml
Type: Boolean
Parameter Sets: Gen2
Aliases:

Required: False
Position: Named
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
Position: Named
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

Required: True
Position: Named
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
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UserNameMethod
The method to use when applying the user name filter (Equals / Begins with/ Ends with).

This parameter is ignored if UserNameFilter is not specified.

For Version 10.2 onwards

```yaml
Type: String
Parameter Sets: Gen2
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AddressFilter
IP Address or DNS name of the machine by which to filter.

For Version 10.2 onwards

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

### -AddressMethod
The method to use when applying the address filter (Equals / Begins with/ Ends with).

This parameter is ignored if AddressFilter is not specified.

For Version 10.2 onwards

```yaml
Type: String
Parameter Sets: Gen2
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AccountCategoryFilter
Filter for Privileged or Non-Privileged accounts.

For Version 10.2 onwards

```yaml
Type: String
Parameter Sets: Gen2
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RuleName
Name of the rule

If left blank, a name will be generated automatically.

For Version 10.2 onwards

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

### -RuleDescription
A description of the rule.

For Version 10.2 onwards

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
Before running:
Create the Safe and the reconcile account according to the rule's definition.
Associate the reconcile account with the platform that is defined in the rule.
Make sure that the user whose credentials will be used for this session is a member of
the Safe specified in the TargetSafeName parameter with the Add accounts permission.

## RELATED LINKS

[https://pspas.pspete.dev/commands/New-PASOnboardingRule](https://pspas.pspete.dev/commands/New-PASOnboardingRule)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/AddAutomaticOnboardingRule.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/AddAutomaticOnboardingRule.htm)
