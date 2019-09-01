---
title: Add-PASSafe
---

## SYNOPSIS

Adds a new safe to the Vault

## SYNTAX

    Add-PASSafe -SafeName <String> [-Description <String>] [-OLACEnabled <Boolean>]
    [-ManagingCPM <String>] -NumberOfVersionsRetention <Int32> [<CommonParameters>]

    Add-PASSafe -SafeName <String> [-Description <String>] [-OLACEnabled <Boolean>]
    [-ManagingCPM <String>] -NumberOfDaysRetention <Int32> [<CommonParameters>]

## DESCRIPTION

Adds a new safe to the Vault.

The "Add Safes" permission is required in the vault.

## PARAMETERS

    -SafeName <String>
        The name of the safe to create.
        Max Length 28 characters.
        Cannot start with a space.
        Cannot contain: '\','/',':','*','<','>','"','.' or '|'

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Description <String>
        Description of the new safe.
        Max 100 characters.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -OLACEnabled <Boolean>
        Boolean value, dictating whether or not to enable Object Level Access Control
        on the safe.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ManagingCPM <String>
        The Name of the CPM user to manage the safe.
        Specify "" to prevent CPM management.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -NumberOfVersionsRetention <Int32>
        The number of retained versions of every password that is stored in the Safe.
        Max value = 999
        Specify either this parameter or NumberOfDaysRetention.

        Required?                    true
        Position?                    named
        Default value                0
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -NumberOfDaysRetention <Int32>
        The number of days for which password versions are saved in the Safe.
        Minimum Value: 1
        Maximum Value 3650
        Specify either this parameter or NumberOfVersionsRetention

        Required?                    true
        Position?                    named
        Default value                0
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Add-PASSafe -SafeName Oracle -Description "Oracle Safe"
    -ManagingCPM PasswordManager -NumberOfVersionsRetention 7

    Creates a new safe named Oracle with a 7 version retention.




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Add-PASSafe -SafeName Dev_Team -Description "Dev Safe" -ManagingCPM DEV_CPM
    -NumberOfDaysRetention 7

    Creates a new safe named Dev_Team, assigned to CPM DEV_CPM, with a 7 day retention period.
