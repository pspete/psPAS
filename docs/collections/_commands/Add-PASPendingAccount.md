---
title: Add-PASPendingAccount
---

## SYNOPSIS

Adds discovered account or SSH key as a pending account in the accounts feed.

## SYNTAX

    Add-PASPendingAccount [-UserName] <String> [-Address] <String> [-AccountDiscoveryDate] <DateTime>
    [[-OSType] <String>] [-AccountEnabled] <String> [[-AccountOSGroups] <String>]
    [[-AccountType] <String>] [[-DiscoveryPlatformType] <String>] [[-Domain] <String>]
    [[-LastLogonDate] <String>] [[-LastPasswordSet] <String>] [[-PasswordNeverExpires] <Boolean>]
    [[-OSVersion] <String>] [[-OU] <String>] [[-AccountCategory] <String>]
    [[-AccountCategoryCriteria] <String>] [[-UserDisplayName] <String>]
    [[-AccountDescription] <String>] [[-AccountExpirationDate] <String>] [[-UID] <String>]
    [[-GID] <String>] [[-MachineOSFamily] <String>] [<CommonParameters>]

## DESCRIPTION

Enables an account or SSH key that is discovered by an external scanner to be added
as a pending account to the Accounts Feed.

Users can identify privileged accounts and determine which are on-boarded to the vault.

## PARAMETERS

    -UserName <String>
        The name of the account user

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Address <String>
        The name or address of the machine where the account is used.

        Required?                    true
        Position?                    2
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AccountDiscoveryDate <DateTime>
        The date when the account was discovered.

        Required?                    true
        Position?                    3
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -OSType <String>
        The OS where the password was discovered.
        Windows or Unix

        Required?                    false
        Position?                    4
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AccountEnabled <String>
        The account status in the discovery source.

        Required?                    true
        Position?                    5
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AccountOSGroups <String>
        The name of the group that the account belongs to

        Required?                    false
        Position?                    6
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AccountType <String>
        Account Type

        Required?                    false
        Position?                    7
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -DiscoveryPlatformType <String>
        Platform where discovered account is used

        Required?                    false
        Position?                    8
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Domain <String>
        The domain of the account.

        Required?                    false
        Position?                    9
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -LastLogonDate <String>
        Date, according to discovery source, when the account was last used to logon.

        Required?                    false
        Position?                    10
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -LastPasswordSet <String>
        Date, according to discovery source, when the password for the account was last set

        Required?                    false
        Position?                    11
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -PasswordNeverExpires <Boolean>
        If the password will ever expire in the discovery source

        Required?                    false
        Position?                    12
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -OSVersion <String>
        OS Version where the account was discovered

        Required?                    false
        Position?                    13
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -OU <String>
        OU of the account

        Required?                    false
        Position?                    14
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AccountCategory <String>
        Whether the discovered account is privileged or non-privileged.

        Required?                    false
        Position?                    15
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AccountCategoryCriteria <String>
        Criteria that determines whether or not the discovered account is privileged.
        For example, the user or groupname, etc.
        Separate multiple strings with ";".

        Required?                    false
        Position?                    16
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UserDisplayName <String>
        User's display name

        Required?                    false
        Position?                    17
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AccountDescription <String>
        A description of the user, as defined in the discovery source.
        This will be saved as an account after it is added to the pending accounts.

        Required?                    false
        Position?                    18
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AccountExpirationDate <String>
        The account expiration date defined in the discovery source.

        Required?                    false
        Position?                    19
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UID <String>
        The unique User ID

        Required?                    false
        Position?                    20
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -GID <String>
        The Unique Group ID

        Required?                    false
        Position?                    21
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -MachineOSFamily <String>
        The type of machine where the account was discovered.

        Required?                    false
        Position?                    22
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

    PS C:\>Add-PASPendingAccount -UserName Administrator -Address ServerA.domain.com
    -AccountDiscoveryDate 2017-01-01T00:00:00Z -AccountEnabled enabled

    Adds matching discovered account as pending account.
