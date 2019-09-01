---
title: Add-PASPolicyACL
---

## SYNOPSIS

Adds a new privileged command rule

## SYNTAX

    Add-PASPolicyACL [-Command] <String> [-CommandGroup] <Boolean> [-PermissionType] <String>
    [-PolicyId] <String> [[-Restrictions] <String>] [-UserName] <String [<CommonParameters>]

## DESCRIPTION

Adds a new privileged command rule to a policy.

## PARAMETERS

    -Command <String>
        The Command to Add

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -CommandGroup <Boolean>
        Boolean to define if commandgroup

        Required?                    true
        Position?                    2
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -PermissionType <String>
        Allow or Deny Permission

        Required?                    true
        Position?                    3
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -PolicyId <String>
        String value of Policy ID

        Required?                    true
        Position?                    4
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Restrictions <String>
        A restrictions string

        Required?                    false
        Position?                    5
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UserName <String>
        The user this rule applies to.
        Specify "*" for all users

        Required?                    true
        Position?                    6
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Add-PASPolicyACL -Command "chmod" -CommandGroup $false -PermissionType Allow
    -PolicyId UNIXSSH -UserName user1

    Adds Rule to UNIXSSH platform
