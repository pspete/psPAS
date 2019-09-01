---
title: Get-PASAccountActivity
---

## SYNOPSIS

Returns activities for an account.

## SYNTAX

    Get-PASAccountActivity [-AccountID] <String> [<CommonParameters>]

## DESCRIPTION

Returns activities for a specific account identified by its AccountID.

## PARAMETERS

    -AccountID <String>
        The ID of the account whose activities will be retrieved.

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

    PS C:\>Get-PASAccount -Keywords root -Safe UNIXSafe | Get-PASAccountActivity

    Will return the account activity for the account output by Get-PASAccount:

    Time                Activity                  UserName      AccountName
    ----                --------                  --------      -----------
    08/07/2017 13:05:46 Delete Privileged Command Administrator root
    08/07/2017 13:02:54 Delete Privileged Command Administrator root
    07/30/2017 10:49:32 Add Privileged Command    Administrator root
    ...
    ...
    ...
