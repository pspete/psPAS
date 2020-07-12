---
title: Remove-PASGroup
---

## SYNOPSIS

    Deletes a user group

## SYNTAX

    Remove-PASGroup [-GroupID] <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]

## DESCRIPTION

    Deletes a user group.

    To delete a user group, the following authorizations are required:

    - Add/Update Users

## PARAMETERS

    -GroupID <Int32>
        The unique ID of the group to delete.

    -WhatIf [<SwitchParameter>]

    -Confirm [<SwitchParameter>]

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS > Delete-PASGroup -GroupID 3

    Deletes Group with ID of 3
