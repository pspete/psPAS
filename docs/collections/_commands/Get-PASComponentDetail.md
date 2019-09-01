---
title: Get-PASComponentDetail
---

## SYNOPSIS

Returns details & health information about CyberArk component instances.

## SYNTAX

    Get-PASComponentDetail [-ComponentID] <String> [<CommonParameters>]

## DESCRIPTION

Returns details about specific components and all their installed instances, as well as system
health information for each one.

## PARAMETERS

    -ComponentID <String>
        Specify component type to return information on (PVWA, SessionManagement, CPM or AIM)

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

    PS C:\>Get-PASComponentDetail -ComponentID CPM

    Displays CPM Component information




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Get-PASComponentDetail -ComponentID PVWA

    Displays PVWA Component information




    -------------------------- EXAMPLE 3 --------------------------

    PS C:\>Get-PASComponentDetail -ComponentID SessionManagement

    Displays PSM Component information
