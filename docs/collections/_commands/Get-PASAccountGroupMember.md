---
title: Get-PASAccountGroupMember
---

## SYNOPSIS

Returns all the members of a specific account group.

## SYNTAX

    Get-PASAccountGroupMember [-GroupID] <String> [<CommonParameters>]

## DESCRIPTION

Returns all the members of a specific account group.

These accounts can be either password accounts or SSH Key accounts.

The following permissions are required on the safe:

- Add Accounts
- Update Account Content
- Update Account Properties
- Create Folders

## PARAMETERS

    -GroupID <String>
        The unique ID of the account groups.

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

    PS C:\>Get-PASAccountGroupMember -GroupID 21_9

    List all members of account group with ID of 21_9
