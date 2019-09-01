---
title: Set-PASOnboardingRule
---

## SYNOPSIS

Updates an automatic onboarding rule.

## SYNTAX

    Set-PASOnboardingRule [-Id] <Int32> [-TargetPlatformId] <String> [-TargetSafeName] <String>
    [[-IsAdminIDFilter] <Boolean>] [[-MachineTypeFilter] <String>] [-SystemTypeFilter] <String>
    [[-UserNameFilter] <String>] [[-UserNameMethod] <String>] [[-AddressFilter] <String>]
    [[-AddressMethod] <String>] [[-AccountCategoryFilter] <String>] [[-RuleName] <String>]
    [[-RuleDescription] <String>]

## DESCRIPTION

Updates an existing automatic onboarding rule.

## PARAMETERS

    -Id <Int32>
        The ID of the rule to update.

        Required?                    true
        Position?                    1
        Default value                0
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -TargetPlatformId <String>
        The ID of the platform that will be associated to the on-boarded account.

        Required?                    true
        Position?                    2
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -TargetSafeName <String>
        The name of the Safe where the on-boarded account will be stored.

        Required?                    true
        Position?                    3
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -IsAdminIDFilter <Boolean>
        Whether or not UNIX accounts with UID=0 or Windows accounts with SID ending in 500 will be
        onboarded automatically using this rule.

        If set to false, all accounts matching the rule will be onboarded.

        Required?                    false
        Position?                    4
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -MachineTypeFilter <String>
        The Machine Type by which to filter.
        Leave blank for "Any"

        Required?                    false
        Position?                    5
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -SystemTypeFilter <String>
        The System Type by which to filter.

        Required?                    true
        Position?                    6
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UserNameFilter <String>
        The name of the user by which to filter.

        Required?                    false
        Position?                    7
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UserNameMethod <String>
        The method to use when applying the user name filter (Equals / Begins with/ Ends with).
        This parameter is ignored if UserNameFilter is not specified.

        Required?                    false
        Position?                    8
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AddressFilter <String>
        IP Address or DNS name of the machine by which to filter.

        Required?                    false
        Position?                    9
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AddressMethod <String>
        The method to use when applying the address filter (Equals / Begins with/ Ends with).
        This parameter is ignored if AddressFilter is not specified.

        Required?                    false
        Position?                    10
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AccountCategoryFilter <String>
        Filter for Privileged or Non-Privileged accounts.

        Required?                    false
        Position?                    11
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -RuleName <String>
        Name of the rule
        If left blank, a name will be generated automatically.

        Required?                    false
        Position?                    12
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -RuleDescription <String>
        A description of the rule.

        Required?                    false
        Position?                    13
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

    PS C:\>Set-PASOnboardingRule -Id 1 -TargetPlatformId WINDOMAIN -TargetSafeName SafeName
    -SystemTypeFilter Windows

    Updates Onboarding Rule with ID 1
