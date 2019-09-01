---
title: Get-PASApplication
---

## SYNOPSIS

Returns details of applications in the Vault

## SYNTAX

    Get-PASApplication [-AppID <String>] [-Location <String>] [-IncludeSublocations <Boolean>]
    [<CommonParameters>]

    Get-PASApplication -AppID <String> [-ExactMatch] [<CommonParameters>]

## DESCRIPTION

Returns information on Applications from the Vault.

Results can be filtered by specifying additional parameters.

Applications can be found by name, or searched for.

Audit Users permission is required.

## PARAMETERS

    -AppID <String>
        Application Name

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ExactMatch [<SwitchParameter>]
        By Default, the function will search the vault.
        All found applications (based on parameters supplied) will be returned.
        When Specifying this parameter, the function will not search;
        data for the supplied AppID will be returned.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -Location <String>
        Location of the application in the Vault hierarchy.
        Default=\

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -IncludeSublocations <Boolean>
        Will search be carried out in sublocations of specified location?
        Boolean

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Get-PASApplication

    Returns information on all defined applications




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Get-PASApplication NewApp -ExactMatch

    Gets details of the application "NewApp":

    AppID  Description       Location Disabled
    -----  -----------       -------- --------
    NewApp A new application \        False




    -------------------------- EXAMPLE 3 --------------------------

    PS C:\>Get-PASApplication NewApp

    Gets details of all application matching "NewApp":

    AppID   Description       Location Disabled
    -----   -----------       -------- --------
    NewApp  A new application \        False
    NewApp1 A new application \        False
    NewApp7 A new application \        False
