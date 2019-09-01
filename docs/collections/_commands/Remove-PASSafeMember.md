---
title: Remove-PASSafeMember
---

## SYNOPSIS

Removes a member from a safe

## SYNTAX

    Remove-PASSafeMember [-SafeName] <String> [-MemberName] <String>

## DESCRIPTION

Removes a specific member from a Safe.
The user who runs this function requires the ManageSafeMembers permission.

## PARAMETERS

    -SafeName <String>
        The name of the safe from which to remove the member.

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -MemberName <String>
        The name of the safe member to remove from the safes list of members.

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

    PS C:\>Remove-PASSafeMember -SafeName TargetSafe -MemberName TargetUser

    Removes TargetUser as safe member from TargetSafe
