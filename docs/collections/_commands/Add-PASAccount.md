---
title: Add-PASAccount
---

## SYNOPSIS

Adds a new privileged account to the Vault.

Uses either the API present from 10.4 onwards, or the version 9 (Classic API) endpoint.

## SYNTAX

    Add-PASAccount [-name <String>] [-address <String>] [-userName <String>] -platformID <String>
    -SafeName <String> [-secretType <String>] [-secret <SecureString>]
    [-platformAccountProperties <Hashtable>] [-automaticManagementEnabled <Boolean>]
    [-manualManagementReason <String>] [-remoteMachines <String>]
    [-accessRestrictedToRemoteMachines <Boolean>] [<CommonParameters>]

    Add-PASAccount [-address <String>] -userName <String> -platformID <String> -SafeName <String>
    [-accountName <String>] -password <SecureString> [-disableAutoMgmt <Boolean>]
    [-disableAutoMgmtReason <String>] [-groupName <String>] [-groupPlatformID <String>] [-Port <Int32>]
    [-ExtraPass1Name <String>] [-ExtraPass1Folder <String>] [-ExtraPass1Safe <String>]
    [-ExtraPass3Name <String>] [-ExtraPass3Folder <String>] [-ExtraPass3Safe <String>]
    [-DynamicProperties <Hashtable>] [<CommonParameters>]

## DESCRIPTION

Adds a new privileged account to the Vault.

Parameters are processed to create request object in the required format.

## PARAMETERS

    -name <String>
        The name of the account.
        A version 10.4 onward specific parameter

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -address <String>
        The Address of the machine where the account will be used

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -userName <String>
        Username on the target machine

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -platformID <String>
        The CyberArk platform to assign to the account

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -SafeName <String>
        The safe where the account will be created

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -secretType <String>
        The type of password.
        A version 10.4 onward specific parameter

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -secret <SecureString>
        The password value
        A version 10.4 onward specific parameter

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -platformAccountProperties <Hashtable>
        key-value pairs to associate with the account, as defined by the account platform.
        These properties are validated against the mandatory and optional properties of
        the specified platform's definition.

        A version 10.4 onward specific parameter

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -automaticManagementEnabled <Boolean>
        Whether CPM Password Management should be enabled
        A version 10.4 onward specific parameter

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -manualManagementReason <String>
        A reason for disabling CPM Password Management
        A version 10.4 onward specific parameter

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -remoteMachines <String>
        For supported platforms, a list of remote machines the account can connect to.
        A version 10.4 onward specific parameter

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -accessRestrictedToRemoteMachines <Boolean>
        Whether access is restricted to the defined remote machines.
        A version 10.4 onward specific parameter

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -accountName <String>
        The name of the account
        Relevant for CyberArk versions earlier than 10.4

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -password <SecureString>
        The password value as a secure string
        Relevant for CyberArk versions earlier than 10.4

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -disableAutoMgmt <Boolean>
        Whether or not automatic management wll be disabled for the account
        Relevant for CyberArk versions earlier than 10.4

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -disableAutoMgmtReason <String>
        The reason why automatic management wll be disabled for the account
        Relevant for CyberArk versions earlier than 10.4

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -groupName <String>
        A groupname with which the account will be associated
        Relevant for CyberArk versions earlier than 10.4

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -groupPlatformID <String>
        Group platform to base created group ID on, if ID doesn't exist
        Relevant for CyberArk versions earlier than 10.4

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Port <Int32>
        Port number over which the account will be used
        Relevant for CyberArk versions earlier than 10.4

        Required?                    false
        Position?                    named
        Default value                0
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ExtraPass1Name <String>
        Logon account name
        Relevant for CyberArk versions earlier than 10.4

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ExtraPass1Folder <String>
        Folder where logon account is stored
        Relevant for CyberArk versions earlier than 10.4

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ExtraPass1Safe <String>
        Safe where logon account is stored
        Relevant for CyberArk versions earlier than 10.4

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ExtraPass3Name <String>
        Reconcile account name
        Relevant for CyberArk versions earlier than 10.4

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ExtraPass3Folder <String>
        Folder where reconcile account is stored
        Relevant for CyberArk versions earlier than 10.4

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ExtraPass3Safe <String>
        Safe where reconcile account is stored
        Relevant for CyberArk versions earlier than 10.4

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -DynamicProperties <Hashtable>
        Hashtable of name=value pairs
        Relevant for CyberArk versions earlier than 10.4

        Required?                    false
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

    PS C:\>Add-PASAccount -address ThisServer -userName ThisUser -platformID UNIXSSH
    -SafeName UNIXSafe -automaticManagementEnabled $false

    Using the version 10 API, adds an account which is disabled for automatic password management




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Add-PASAccount -safe Prod_Access -PlatformID WINDOMAIN -Address domain.com
    -Password $secureString -username domainUser

    Using the "version 9" API, adds account domain.com\domainuser to the Prod_Access Safe using the
    WINDOMAIN platform.

    The contents of $secureString will be set as the password value.
