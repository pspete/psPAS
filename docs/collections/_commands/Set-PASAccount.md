---
title: Set-PASAccount
---

## SYNOPSIS

Updates an existing accounts details.

## SYNTAX

    Set-PASAccount -AccountID <String> -op <String> -path <String> [-value <String>]
    [-InputObject <PSObject>]


    Set-PASAccount -AccountID <String> -operations <Hashtable[]> [-InputObject <PSObject>]
    [-WhatIf] [-Confirm] [<CommonParameters>]

    Set-PASAccount -AccountID <String> -Folder <String> -AccountName <String>
    [-DeviceType <String>] [-PlatformID <String>] [-Address <String>] [-UserName <String>]
    [-GroupName <String>] [-GroupPlatformID <String>] [-Properties <Hashtable>]
    [-InputObject <PSObject>]

## DESCRIPTION

Updates an existing accounts details.

For CyberArk version prior to 10.4:

- All of the account's property details MUST be passed to the function.
- Any current properties of the account not sent as part of the request will be removed from the account.
- To change a property value not exposed via a named parameter, pass the property name and updated value to the function via the Properties parameter.
- If changing the name or folder of a service account that has multiple dependencies (usages), the connection between it and its dependencies will be automatically maintained.
- If changing the name or folder of an account that is linked to another account (whether logon, reconciliation or verification), the links will be automatically updated.

## PARAMETERS

    -AccountID <String>
        The unique ID of the account to update.
        Retrieved by Get-PASAccount

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -op <String>
        The operation to perform (add, remove, replace).
        Requires CyberArk version 10.4+

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -path <String>
        The path of the property to update, for instance /address or /name.
        Requires CyberArk version 10.4+

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -value <String>
        The new property value for add or replace operations.
        Requires CyberArk version 10.4+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -operations <Hashtable[]>
        A collection of update actions to perform, must include op, path & value (except where
        action is remove).
        Requires CyberArk version 10.4+

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Folder <String>
        The folder where the account is stored.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AccountName <String>
        The name of the account

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -DeviceType <String>
        The devicetype assigned to the account.
        Ensure all required parameters are specified.
        Different device types require different parameters

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -PlatformID <String>
        The CyberArk platform assigned to the account
        Ensure all required parameters are specified.
        Different platforms require different parameters

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Address <String>
        The Name or Address of the machine where the account will be used

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UserName <String>
        The Username on the target machine

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -GroupName <String>
        A groupname with which the account will be associated
        The name of the group with which the account is associated.
        To create a new group, specify the group platform ID in the GroupPlatformID property,
        then specify the group name. The group will then be created automatically.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -GroupPlatformID <String>
        GroupPlatformID is required if account is to be moved to a new group.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Properties <Hashtable>
        Hashtable of name=value pairs.
        Specify properties to update.

        Required?                    false
        Position?                    named
        Default value                @{ }
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -InputObject <PSObject>
        Receives object from pipeline.

        Required?                    false
        Position?                    named
        Default value
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

    PS C:\>Set-PASAccount -AccountID 27_4 -op replace -path "/address" -value "NewAddress"

    Replaces the current address value with NewAddress




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Set-PASAccount -AccountID 27_4 -op remove -path "/platformAccountProperties/UserDN"

    Removes UserDN property set on account




    -------------------------- EXAMPLE 3 --------------------------

    PS C:\>$actions += @{"op"="Add";"path"="/platformAccountProperties/UserDN";"value"="SomeDN"}

    $actions += @{"op"="Replace";"path"="/Name";"value"="SomeName"}

    Set-PASAccount -AccountID 27_4 -operations $actions

    Performs the update operations contained in the $actions array against the account




    -------------------------- EXAMPLE 4 --------------------------

    PS C:\>Get-PASAccount dbuser | Set-PASAccount -Properties @{"DSN"="myDSN"}

    Sets DSN value on matched account dbUser




    -------------------------- EXAMPLE 5 --------------------------

    PS C:\>Set-PASAccount -AccountID 21_3 -Folder Root -AccountName NewName `

    -DeviceType Database -PlatformID Oracle -Address dbServer.domain.com -UserName dbuser

    Will set the AccountName of account with AccountID of 21_3 to "NewName".
    **Any/All additional properties of the account which are not specified via parameters will
    be cleared**
