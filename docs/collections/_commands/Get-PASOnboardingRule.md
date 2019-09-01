---
title: Get-PASOnboardingRule
---

## SYNOPSIS

Gets all automatic on-boarding rules

## SYNTAX

    Get-PASOnboardingRule [-Names <String>] [<CommonParameters>]

## DESCRIPTION

Returns information on defined on-boarding rules.

Vault Admin membership required.

## PARAMETERS

    -Names <String>
        A filter that specifies the rule name.
        Separate a list of rules with commas.
        If not specified, all rules will be returned.
        For version 10.2 onwards (not a supported parameter on earlier versions)

        Required?                    false
        Position?                    named
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

    PS C:\>Get-PASOnboardingRule

    List information on all On-boarding rules




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Get-PASOnboardingRule -Names Rule1,Rule2

    List information on On-boarding rules "Rule1" & "Rule2"
