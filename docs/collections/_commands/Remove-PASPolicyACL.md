---
title: Remove-PASPolicyACL
---

## SYNOPSIS

Delete all privileged commands on policy

## SYNTAX

    Remove-PASPolicyACL [-PolicyID] <String> [-Id] <String>

## DESCRIPTION

Deletes all privileged command rules associated with the policy

## PARAMETERS

    -PolicyID <String>
        String value of Policy ID

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Id <String>
        The Rule Id that will be deleted

        Required?                    true
        Position?                    2
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

    PS C:\>Remove-PASPolicyACL -PolicyID UNIXSSH -Id 13

    Deletes Rule with ID of 13 from UNIXSSH platform.
