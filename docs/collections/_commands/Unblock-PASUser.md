---
title: Unblock-PASUser
---

## SYNOPSIS

Activates a suspended user

## SYNTAX

    Unblock-PASUser -id <Int32> [<CommonParameters>]

    Unblock-PASUser -UserName <String> -Suspended <Boolean> [<CommonParameters>]

## DESCRIPTION

Activates an existing vault user who was suspended due to password failures.

## PARAMETERS

    -id <Int32>
        The user's unique ID
        Requires CyberArk version 10.10+

        Required?                    true
        Position?                    named
        Default value                0
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UserName <String>
        The user's name

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Suspended <Boolean>
        Suspension status

        Required?                    true
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

    PS C:\>Unblock-PASUser -UserName MrFatFingers -Suspended $false

    Activates suspended vault user MrFatFingers using the Classic API




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Unblock-PASUser -id 666

    Activates suspended vault user with id 666, using the API from 10.10+
