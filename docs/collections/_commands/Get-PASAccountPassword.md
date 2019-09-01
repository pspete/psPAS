---
title: Get-PASAccountPassword
---

## SYNOPSIS

Returns password for an account.

## SYNTAX

    Get-PASAccountPassword -AccountID <String> [-Reason <String>] [-TicketingSystem <String>]
    [-TicketId <String>] [-Version <Int32>] [-ActionType <String>] [-isUse <Boolean>] [-Machine]
    [<CommonParameters>]

    Get-PASAccountPassword -AccountID <String> [-UseClassicAPI] [<CommonParameters>]

## DESCRIPTION

Returns password for an account identified by its AccountID.

If using version 9.7+ of the API:

- Will not return SSH Keys.
- Cannot be used if a reason for password access must be specified.

If using version 10.1+ of the API:

- Will return SSH key of an existing account
- Can be used if a reason and/or ticket ID must be specified.

## PARAMETERS

    -AccountID <String>
        The ID of the account whose password will be retrieved.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UseClassicAPI [<SwitchParameter>]
        Specify the UseClassicAPI to force usage the Classic (v9) API endpoint.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -Reason <String>
        The reason that is required to be specified to retrieve the password/SSH key.
        Use of parameter requires version 10.1 at a minimum.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -TicketingSystem <String>
        The name of the Ticketing System.
        Use of parameter requires version 10.1 at a minimum.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -TicketId <String>
        The ticket ID of the ticketing system.
        Use of parameter requires version 10.1 at a minimum.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -Version <Int32>
        The version number of the required password.
        If there are no previous versions, the current password/key version is returned.
        Use of parameter requires version 10.1 at a minimum.

        Required?                    false
        Position?                    named
        Default value                0
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -ActionType <String>
        The action this password will be used for.
        Use of parameter requires version 10.1 at a minimum.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -isUse <Boolean>
        Internal parameter (for PSMP only).
        Use of parameter requires version 10.1 at a minimum.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -Machine [<SwitchParameter>]
        The address of the remote machine to connect to.
        Use of parameter requires version 10.1 at a minimum.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Get-PASAccount -Keywords root -Safe Prod_Safe | Get-PASAccountPassword

    Will return the password value of the account found by Get-PASAccount:

    Password
    --------
    Ra^D0MwM666*&U




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Get-PASAccount -Keywords root -Safe Prod_Safe | Get-PASAccountPassword -UseClassicAPI

    Will retrieve the password value of the account found by Get-PASAccount using the classic (v9)
    API:

    Password
    --------
    Ra^D0MwM666*&U




    -------------------------- EXAMPLE 3 --------------------------

    PS C:\>Get-PASAccount -Keywords root -Safe Prod_Safe | Get-PASAccountPassword
    -Reason "Incident Investigation"

    Will retrieve the password value of the account found by Get-PASAccount using the v10 API, and
    specify a reason for access.

    Password
    --------
    Ra^D0MwM666*&U
