---
title: Add-PASAccountGroupMember
---

## SYNOPSIS

Adds an account as a member of an account group.

## SYNTAX

    Add-PASAccountGroupMember [-GroupID] <String> [-AccountID] <String> [<CommonParameters>]

## DESCRIPTION

Adds an account as a member of an account group.

The account can contain either password or SSH key.

The account must be stored in the same safe as the account group.

The following permissions are required on the safe where the account group will be created:

- Add Accounts
- Update Account Content
- Update Account Properties

## PARAMETERS

    -GroupID <String>
        The unique ID of the account group

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AccountID <String>
        The ID of the account to add as a member

        Required?                    true
        Position?                    2
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

    PS C:\>Add-PASAccountGroupMember -GroupID $groupID -AccountID $accID

    Adds account with ID held in $accID to group with ID held in $groupID
