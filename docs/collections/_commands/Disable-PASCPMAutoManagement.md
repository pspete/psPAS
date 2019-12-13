---
title: Disable-PASCPMAutoManagement
---

## SYNOPSIS

Disables an account for Automatic CPM Management.

## SYNTAX

    Disable-PASCPMAutoManagement -AccountID <String> [-Reason <String>] [<CommonParameters>]

## DESCRIPTION

Disables an account for CPM management by setting automaticManagementEnabled to $false,
and optionally sets a value for manualManagementReason.

## PARAMETERS

    -AccountID <String>
        The ID of the account to disable automaic CPM management.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Reason <String>
        The value to set for manualManagementReason

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

NOTES

        Applicable to and requires 10.4+

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Disables-PASCPMAutoManagement -AccountID 543_2

    Sets automaticManagementEnabled to $false on account with ID 543_2




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Disables-PASCPMAutoManagement -AccountID 543_2 -Reason "Some Reason"

    Sets automaticManagementEnabled to $false & sets manualManagementReason on account with ID 543_2
