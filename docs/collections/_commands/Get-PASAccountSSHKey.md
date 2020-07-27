---
title: Get-PASAccountSSHKey
---

## SYNOPSIS

    Retrieves a private SSH key

## SYNTAX

    Get-PASAccountSSHKey [-AccountID] <String> [[-Reason] <String>] [[-TicketingSystem] <String>] [[-TicketId] <String>] [[-Version] <Int32>] [[-ActionType] <String>] [[-isUse] <Boolean>]
    [-Machine] [<CommonParameters>]

## DESCRIPTION

    Get the private SSH key value from an existing account

## PARAMETERS

    -AccountID <String>
        The ID of the account whose SSH Key will be retrieved.

    -Reason <String>
        The reason for retrieving the private SSH key.

    -TicketingSystem <String>
        The name of the ticketing system.

    -TicketId <String>
        The ticket ID defined in the ticketing system.

    -Version <Int32>
        The version number of the required SSH key.
        If the value is left empty or the value passed does not exist,
        then the current SSH key version is returned.

    -ActionType <String>
        The action this SSH key is used for

    -isUse <Boolean>
        Internal parameter (for use of PSMP only)

    -Machine [<SwitchParameter>]
        The address of the remote machine

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Get-PASAccountSSHKey -AccountId 12_3 -Reason "Some Reason"

    Returns Private SSH Key associated with account 12_3
