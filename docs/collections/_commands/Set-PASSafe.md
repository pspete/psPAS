---
title: Set-PASSafe
---

## SYNOPSIS

Updates a safe in the Vault

## SYNTAX

    Set-PASSafe -SafeName <String> [-NewSafeName <String>] [-Description <String>]
    [-OLACEnabled <Boolean>] [-ManagingCPM <String>]

    Set-PASSafe -SafeName <String> [-NewSafeName <String>] [-Description <String>]
    [-OLACEnabled <Boolean>] [-ManagingCPM <String>] [-NumberOfVersionsRetention <Int32>]

    Set-PASSafe -SafeName <String> [-NewSafeName <String>] [-Description <String>]
    [-OLACEnabled <Boolean>] [-ManagingCPM <String>] [-NumberOfDaysRetention <Int32>]

## DESCRIPTION

Updates a single safe in the Vault.

Manage Safe permission is required.

## PARAMETERS

    -SafeName <String>
        The name of the safe to update.
        Max Length 28 characters.
        Cannot start with a space.
        Cannot contain: '\','/',':','*','<','>','"','.' or '|'

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -NewSafeName <String>
        A name to rename the safe to
        Max Length 28 characters.
        Cannot start with a space.
        Cannot contain: '\','/',':','*','<','>','"','.' or '|'

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Description <String>
        Updated Description for safe.
        Max 100 characters.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -OLACEnabled <Boolean>
        Boolean value, dictating whether or not to enable Object Level Access Control on the safe.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -ManagingCPM <String>
        The Name of the CPM user to manage the safe.
        Specify "" to prevent CPM management.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -NumberOfVersionsRetention <Int32>
        The number of retained versions of every password that is stored in the Safe.
        Max value = 999
        Specify either this parameter or NumberOfDaysRetention.

        Required?                    false
        Position?                    named
        Default value                0
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -NumberOfDaysRetention <Int32>
        The number of days for which password versions are saved in the Safe.
        Minimum Value: 1
        Maximum Value 3650
        Specify either this parameter or NumberOfVersionsRetention

        Required?                    false
        Position?                    named
        Default value                0
        Accept pipeline input?       false
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

    PS C:\>Set-PASSafe -SafeName SAFE -Description "New-Description" -NumberOfVersionsRetention 10

    Updates description and version retention on SAFE
