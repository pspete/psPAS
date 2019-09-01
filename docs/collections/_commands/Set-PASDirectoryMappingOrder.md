---
title: Set-PASDirectoryMappingOrder
---

## SYNOPSIS

Changes the order of directory mappings for a directory

## SYNTAX

    Set-PASDirectoryMappingOrder [-DirectoryName] <String> [-MappingsOrder] <Int32[]>
    [-WhatIf] [-Confirm] [<CommonParameters>]

## DESCRIPTION

Updates the order of all a directories mappings.

Requires membership of Vault Admins group  & "Audit users", "Add/Update users" & "Manage Directory mappings" authorizations.

Minimum version 10.10

## PARAMETERS

    -DirectoryName <String>
        The name of the directory

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -MappingsOrder <Int32[]>
        The MappingID of each directory mapping, in the order they should be applied.

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

    PS C:\>Set-PASDirectoryMappingOrder -DirectoryName "DOMAIN.COM"
    -MappingsOrder 39,43,41,669,668,667

    Sets the order of the directory mappings for directory "DOMAIN.COM"
