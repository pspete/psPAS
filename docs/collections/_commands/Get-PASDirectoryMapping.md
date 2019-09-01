---
title: Get-PASDirectoryMapping
---

## SYNOPSIS

Get directory mappings configured for a directory

## SYNTAX

    Get-PASDirectoryMapping -DirectoryName <String> [<CommonParameters>]

    Get-PASDirectoryMapping -DirectoryName <String> -MappingID <String> [<CommonParameters>]

## DESCRIPTION

Returns a list of existing directory mappings in the Vault.

Membership of the Vault Admins group required.

## PARAMETERS

    -DirectoryName <String>
        The ID or Name of the directory to return data on.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -MappingID <String>
        The ID or Name of the directory mapping to return information on.

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

    PS C:\>Get-PASDirectory |  Get-PASDirectoryMapping

    Returns LDAP directory mappings configured for each directory.




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Get-PASDirectoryMapping -DirectoryName SomeDir -MappingID "User_Mapping"

    Returns information on the User_Mapping for SomeDir
