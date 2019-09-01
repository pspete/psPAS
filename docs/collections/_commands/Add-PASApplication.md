---
title: Add-PASApplication
---

## SYNOPSIS

Adds a new application to the Vault

## SYNTAX

    Add-PASApplication [-AppID] <String> [[-Description] <String>] [-Location] <String>
    [[-AccessPermittedFrom] <Int32>] [[-AccessPermittedTo] <Int32>] [[-ExpirationDate] <DateTime>]
    [[-Disabled] <Boolean>] [[-BusinessOwnerFName] <String>] [[-BusinessOwnerLName] <String>]
    [[-BusinessOwnerEmail] <String>] [[-BusinessOwnerPhone] <String>] [<CommonParameters>]

## DESCRIPTION

Adds a new application to the Vault.

Manage Users permission is required.

## PARAMETERS

    -AppID <String>
        The application name.
        Must be fewer than 128 characters.
        Cannot include ampersand ("&") character.
        Can include "@" character, but any searches for applications cannot include
        this character.

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Description <String>
        Description of the application, no longer than 99 characters.

        Required?                    false
        Position?                    2
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Location <String>
        The location of the application in the vault hierarchy.
        Note: to insert a backslash in the location path, use a double backslash.

        Required?                    true
        Position?                    3
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AccessPermittedFrom <Int32>
        The start hour that access is permitted to the application.
        Valid values are 0-23.

        Required?                    false
        Position?                    4
        Default value                0
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AccessPermittedTo <Int32>
        The end hour that access to the application is permitted.
        Valid values are 0-23.

        Required?                    false
        Position?                    5
        Default value                0
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ExpirationDate <DateTime>
        The date when the application expires.

        Required?                    false
        Position?                    6
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Disabled <Boolean>
        Boolean value, denoting if the application is disabled or not.

        Required?                    false
        Position?                    7
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -BusinessOwnerFName <String>
        The first name of the business owner.
        Specify up to 29 characters.

        Required?                    false
        Position?                    8
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -BusinessOwnerLName <String>
        The last name of the business owner.

        Required?                    false
        Position?                    9
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -BusinessOwnerEmail <String>
        The email address of the business owner

        Required?                    false
        Position?                    10
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -BusinessOwnerPhone <String>
        The phone number of the business owner.
        Specify up to 24 characters.

        Required?                    false
        Position?                    11
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

    PS C:\>Add-PASApplication -AppID NewApp -Description "A new application" -Location "\" `

    -AccessPermittedFrom 9 -AccessPermittedTo 17 -BusinessOwnerEmail 'appowner@company.com'

    Will add a new application called "NewApp", in the root location, accessible from 9am to 5pm
