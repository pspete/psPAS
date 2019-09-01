---
title: New-PASOnboardingRule
---

## SYNOPSIS

Adds a new on-boarding rule to the Vault

## SYNTAX

    New-PASOnboardingRule -TargetPlatformId <String> -TargetSafeName <String>
    [-IsAdminIDFilter <Boolean>] [-MachineTypeFilter <String>] -SystemTypeFilter <String>
    [-UserNameFilter <String>] [-UserNameMethod <String>] [-AddressFilter <String>]
    [-AddressMethod <String>] [-AccountCategoryFilter <String>] [-RuleName <String>]
    [-RuleDescription <String>]

    New-PASOnboardingRule -DecisionPlatformId <String> -DecisionSafeName <String>
    [-IsAdminUIDFilter <String>] [-MachineTypeFilter <String>] -SystemTypeFilter <String>
    [-UserNameFilter <String>] [-AddressFilter <String>] [-RuleName <String>]
    [-RuleDescription <String>]

## DESCRIPTION

Adds a new on-boarding rule to the Vault, that filters discovered local privileged pending accounts.

When a discovered pending account matches a rule, it will be automatically on-boarded to the safe that is defined in the rule and the password will be reconciled.

If a newly discovered account does not match any rule, it will be added to the PendingAccounts list.

This function must be run with a Vault Admin account.

## PARAMETERS

    -DecisionPlatformId <String>
        The ID of the platform that will be associated to the on-boarded account.
        For Versions 9.8 to 10.1

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -TargetPlatformId <String>
        The ID of the platform that will be associated to the on-boarded account.
        For Version 10.2 onwards

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -DecisionSafeName <String>
        The name of the Safe where the on-boarded account will be stored.
        For Versions 9.8 to 10.1

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -TargetSafeName <String>
        The name of the Safe where the on-boarded account will be stored.
        For Version 10.2 onwards

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -IsAdminUIDFilter <String>
        Whether or not only pending accounts whose UID is set to will be on-boarded
        automatically according to this rule.
        For Versions 9.8 to 10.1

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -IsAdminIDFilter <Boolean>
        Whether or not UNIX accounts with UID=0 or Windows accounts with SID ending in 500 will be
        onboarded automatically using this rule.
        If set to false, all accounts matching the rule will be onboarded.
        For Version 10.2 onwards

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -MachineTypeFilter <String>
        The Machine Type by which to filter.
        Leave blank for "Any"

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -SystemTypeFilter <String>
        The System Type by which to filter.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UserNameFilter <String>
        The name of the user by which to filter.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UserNameMethod <String>
        The method to use when applying the user name filter (Equals / Begins with/ Ends with).
        This parameter is ignored if UserNameFilter is not specified.
        For Version 10.2 onwards

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AddressFilter <String>
        IP Address or DNS name of the machine by which to filter.
        For Version 10.2 onwards

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AddressMethod <String>
        The method to use when applying the address filter (Equals / Begins with/ Ends with).
        This parameter is ignored if AddressFilter is not specified.
        For Version 10.2 onwards

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AccountCategoryFilter <String>
        Filter for Privileged or Non-Privileged accounts.
        For Version 10.2 onwards

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -RuleName <String>
        Name of the rule
        If left blank, a name will be generated automatically.
        For Version 10.2 onwards

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -RuleDescription <String>
        A description of the rule.
        For Version 10.2 onwards

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -WhatIf [<SwitchParameter>]

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -Confirm [<SwitchParameter>]

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>New-PASOnboardingRule -DecisionPlatformId DecisionPlatform -DecisionSafeName DecisionSafe
    -SystemTypeFilter Windows

    Adds Onboarding Rule for Windows Accounts
