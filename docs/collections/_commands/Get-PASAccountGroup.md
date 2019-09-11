---
title: Get-PASAccountGroup
---

## SYNOPSIS

Returns all the account groups in a specific Safe.

## SYNTAX

    Get-PASAccountGroup -Safe <String> [-UseClassicAPI] [<CommonParameters>]

## DESCRIPTION

Returns all the account groups in a specific Safe.
The following permissions are required on the safe where the account group will be created:

- Add Accounts
- Update Account Content
- Update Account Properties
- Create Folders

## PARAMETERS

    -Safe <String>
        The Safe where the account groups are.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UseClassicAPI [<SwitchParameter>]
        Specify the UseClassicAPI to force usage the Classic (v9) API endpoint.
        Relevant for CyberArk versions earlier than 10.5

        Required?                    false
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

    PS C:\>Get-PASAccountGroup -Safe SafeName

    List all account groups in SafeName
