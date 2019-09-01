---
title: Add-PASAccountACL
---

## SYNOPSIS

Adds a new privileged command rule to an account.

## SYNTAX

    Add-PASAccountACL [-AccountPolicyId] <String> [-AccountAddress] <String> [-AccountUserName] <String>
    [-Command] <String> [-CommandGroup] <Boolean> [-PermissionType] <String> [[-Restrictions] <String>]
    [-UserName] <String> [<CommonParameters>]

## DESCRIPTION

Adds a new privileged command rule to an account.

## PARAMETERS

    -AccountPolicyId <String>
        The PolicyID associated with account.

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AccountAddress <String>
        The address of the account whose privileged commands will be listed.

        Required?                    true
        Position?                    2
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AccountUserName <String>
        The name of the account's user.

        Required?                    true
        Position?                    3
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -Command <String>
        The Command

        Required?                    true
        Position?                    4
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -CommandGroup <Boolean>
        Boolean for Command Group

        Required?                    true
        Position?                    5
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -PermissionType <String>
        Allow or Deny permission

        Required?                    true
        Position?                    6
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -Restrictions <String>
        A restriction string

        Required?                    false
        Position?                    7
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -UserName <String>
        The user this rule applies to

        Required?                    true
        Position?                    8
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

    PS C:\>Add-PASAccountACL -AccountPolicyID UNIXSSH -AccountAddress ServerA.domain.com
    -AccountUserName root -Command 'for /l %a in (0,0,0) do xyz' -CommandGroup $false
    -PermissionType Deny -UserName TestUser

    This will add a new Privileged Command Rule to root for user TestUser
