---
title: Get-PASPlatform
---

## SYNOPSIS

Retrieves details of Vault platforms.

## SYNTAX

    Get-PASPlatform [-Active <Boolean>] [-SystemType <String>] [-PeriodicVerify <Boolean>] [-ManualVerify <Boolean>] [-PeriodicChange <Boolean>] [-ManualChange <Boolean>] [-AutomaticReconcile <Boolean>] [-ManualReconcile <Boolean>] [<CommonParameters>]

    Get-PASPlatform [-Active <Boolean>] [-PlatformType <String>] [-Search <String>] [<CommonParameters>]

    Get-PASPlatform -PlatformID <String> [<CommonParameters>]

    Get-PASPlatform [-DependentPlatform] [<CommonParameters>]

    Get-PASPlatform [-GroupPlatform] [<CommonParameters>]

    Get-PASPlatform [-RotationalGroup] [<CommonParameters>]

## DESCRIPTION

Request platform configuration information from the Vault.

    11.4+ can return detials of target, dependent, group & rotational group platforms,
    with additional filters available for target group queries.
    11.1+ can return details of all target platforms.
    Limited filters can be used to retrieve a subset of the platforms

    For 9.10+, the "PlatformID" parameter must be used to retrieve details of a single
    specified platform from the Vault.

    The output contained under the "Details" property differs depending
    on which method (9.10+,11.1+ or 11.4) is used, and which platform type is queried.

## PARAMETERS

    -Active <Boolean>
        Filter active/inactive platforms

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -PlatformType <String>
        Filter regular/group platforms

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Search <String>
        Filter platform by search pattern

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -PlatformID <String>
        The unique ID/Name of the platform.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -DependentPlatform [<SwitchParameter>]
        Specify to return details of dependent platforms

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -GroupPlatform [<SwitchParameter>]
        Specify to return details of group platforms

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -RotationalGroup [<SwitchParameter>]
        Specify to return details of rotational group platforms

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -SystemType <String>
        Filter target platforms for specific system type

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -PeriodicVerify <Boolean>
        Filter target platforms by periodic verification configuration

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ManualVerify <Boolean>
        Filter target platforms by manual verification configuration

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -PeriodicChange <Boolean>
        Filter target platforms by periodic change configuration

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ManualChange <Boolean>
        Filter target platforms by manual change configuration

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AutomaticReconcile <Boolean>
        Filter target platforms by automatic reconciliation configuration

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ManualReconcile <Boolean>
        Filter target platforms by manual reconciliation configuration

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## NOTES

        Minimum CyberArk version 9.10
        CyberArk version 11.1 required for Active, PlatformType & Search paramters.
        CyberArk version 11.4 required for extended filters for target platforms,
        and requests for  dependent, group & rotational group platforms

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS > Get-PASPlatform

    Return details of all platforms




    -------------------------- EXAMPLE 2 --------------------------

    PS > Get-PASPlatform -Active $true

    Get all active platforms




    -------------------------- EXAMPLE 3 --------------------------

    PS > Get-PASPlatform -Active $true -Search "WIN_"

    Get active platforms matching search string "WIN_"




    -------------------------- EXAMPLE 4 --------------------------

    PS > Get-PASPlatform -PlatformID "CyberArk"

    Get details of specific platform CyberArk




    -------------------------- EXAMPLE 5 --------------------------

    PS > Get-PASPlatform -GroupPlatform

    Get details of all group platfoms




    -------------------------- EXAMPLE 6 --------------------------

    PS > Get-PASPlatform -RotationalGroup

    Get details of all rotational group platforms




    -------------------------- EXAMPLE 7 --------------------------

    PS > Get-PASPlatform -DependentPlatform

    Get details of all dependent platforms




    -------------------------- EXAMPLE 8 --------------------------

    PS > Get-PASPlatform -Active $false -SystemType Windows

    Get details of all deactivated Windows platforms




    -------------------------- EXAMPLE 9 --------------------------

    PS > Get-PASPlatform -Active $true -SystemType '*NIX' -AutomaticReconcile $true

    Get details of all active Unix platforms configured for automatic reconciliation.
