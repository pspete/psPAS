---
title: Remove-PASDirectoryMapping
---

## SYNOPSIS

    Removes a configured directory mapping from the Vault

## SYNTAX

    Remove-PASDirectoryMapping [-DirectoryName] <String> [-MappingID] <String> [-WhatIf] [-Confirm] [<CommonParameters>]

## DESCRIPTION

    Removes a directory mapping configuration from the vault.
    Membership of the Vault Admins group required.

## PARAMETERS

    -DirectoryName <String>
        The Name of the directory containing the mapping.

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -MappingID <String>
        The id of the directory mapping to delete.

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

    PS C:\>Remove-PASDirectoryMapping -DirectoryName SomeDir -MappingID 66

    Removes the  directory mapping with id 66 for the SomeDir directory
