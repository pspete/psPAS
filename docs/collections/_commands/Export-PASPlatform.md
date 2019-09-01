---
title: Export-PASPlatform
---

## SYNOPSIS

Export a platform

## SYNTAX

    Export-PASPlatform [-PlatformID] <String> [-path] <String>

## DESCRIPTION

Export a platform to a zip file in order to import it to a different Vault environment.

Vault Admin group membership required.

## PARAMETERS

    -PlatformID <String>
        The name of the platform.

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -path <String>
        The folder to export the platform configuration to.

        Required?                    true
        Position?                    2
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -WhatIf [<SwitchParameter>]

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -Confirm [<SwitchParameter>]

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Export-PASPlatform -PlatformID YourPlatform -Path C:\Platform.zip

    Exports UnixSSH to Platform.zip platform package.
