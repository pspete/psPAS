---
title: Get-PASUser
---

## SYNOPSIS

Returns details of a user

## SYNTAX

    Get-PASUser [-Search <String>] [-UserType <String>] [-ComponentUser <Boolean>] [<CommonParameters>]

    Get-PASUser -id <Int32> [<CommonParameters>]

    Get-PASUser -UserName <String> [<CommonParameters>]

## DESCRIPTION

Returns information on specific vault user.

## PARAMETERS

    -id <Int32>
        The numeric id of the user to return details of.
        Requires CyberArk version 10.10+

        Required?                    true
        Position?                    named
        Default value                0
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Search <String>
        Search string.
        Requires CyberArk version 10.9+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UserType <String>
        The type of the user.
        Requires CyberArk version 10.9+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ComponentUser <Boolean>
        Whether the user is a known component or not.
        Requires CyberArk version 10.9+

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UserName <String>
        The user's name

        Required?                    true
        Position?                    named
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

    PS C:\>Get-PASUser

    Returns information for all found Users




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Get-PASUser -id 123

    Returns information on User with id 123




    -------------------------- EXAMPLE 3 --------------------------

    PS C:\>Get-PASUser -search SearchTerm -ComponentUser $False

    Returns information for all matching Users




    -------------------------- EXAMPLE 4 --------------------------

    PS C:\>Get-PASUser -UserName Target_User

    Displays information on Target_User
