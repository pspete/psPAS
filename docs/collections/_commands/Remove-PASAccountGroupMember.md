---
title: Remove-PASAccountGroupMember
---

## SYNOPSIS

Deletes a member of an account group.

## SYNTAX

    Remove-PASAccountGroupMember [-AccountID] <String> [-GroupID] <String>

## DESCRIPTION

Removes an account member from an account group.

This account can be either a password account or an SSH Key account.

The following permissions are required on the safe:

- Add Accounts
- Update Account Content
- Update Account Properties
- Create Folders

## PARAMETERS

    -AccountID <String>
        The unique ID of the account group.

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -GroupID <String>
        The unique ID of the account group.

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

    PS C:\>Remove-PASAccountGroupMember -AccountID 21_7 -GroupID 21_9

    Removes member with ID of 21_& from account group with ID of 21_9
