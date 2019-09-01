---
title: Remove-PASOnboardingRule
---

## SYNOPSIS

Deletes an automatic on-boarding rule

## SYNTAX

    Remove-PASOnboardingRule [-RuleID] <String>

## DESCRIPTION

Deletes an automatic on-boarding rulefrom the Vault.

Vault Admin membership required.

## PARAMETERS

    -RuleID <String>
        The unique ID of the rule to delete.

        Required?                    true
        Position?                    1
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

    PS C:\>Remove-PASOnboardingRule -RuleID 5

    Removes specified on-boarding rule.
