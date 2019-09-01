---
title: Get-PASPolicyACL
---

## SYNOPSIS

Lists OPM Rules for a policy

## SYNTAX

    Get-PASPolicyACL [-PolicyID] <String> [<CommonParameters>]

## DESCRIPTION

Gets a list of the privileged commands (OPM Rules) associated with this policy

## PARAMETERS

    -PolicyID <String>
        The ID of the Policy for which the privileged commands will be listed.

        Required?                    true
        Position?                    1
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

    PS C:\>Get-PASPolicyACL -PolicyID unixssh

    Lists rules for UNIXSSH platform.
