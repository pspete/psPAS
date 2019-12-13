---
title: Enable-PASCPMAutoManagement
---

## SYNOPSIS

Enables an account for Automatic CPM Management.

## SYNTAX

    Enable-PASCPMAutoManagement [-AccountID] <String> [<CommonParameters>]

## DESCRIPTION

Enables an account for CPM management by setting automaticManagementEnabled to $true,
and clearing any value set for manualManagementReason.

Attempting to set automaticManagementEnabled to $true without clearing manualManagementReason
at the same time results in an error.

This function requests the API to perform both operations with a single command.

## PARAMETERS

    -AccountID <String>
        The ID of the account to enable for automatic management by CPM.

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

## NOTES

        Applicable to and requires 10.4+

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Enable-PASCPMAutoManagement -AccountID 543_2

    Sets automaticManagementEnabled to $true & clears any value set for manualManagementReason
    on account with ID 543_2
