---
title: Add-PASGroupMember
---

## SYNOPSIS

Adds a vault user as a group member

## SYNTAX

    Add-PASGroupMember -groupId <Int32> -memberId <String> [-memberType <String>]
    [-domainName <String>] [<CommonParameters>]

    Add-PASGroupMember -GroupName <String> -UserName <String> [<CommonParameters>]

## DESCRIPTION

Adds an existing user to an existing group in the vault

## PARAMETERS

    -groupId <Int32>
        The unique ID of the group to add the member to.

        Required?                    true
        Position?                    named
        Default value                0
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -memberId <String>
        The name of the user or group to add as a member.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -memberType <String>
        The type of user being added to the Vault group.
        Valid values: domain/vault

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -domainName <String>
        If memberType=domain, dns address of the domain

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -GroupName <String>
        The name of the user

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UserName <String>
        The name of the user

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

    PS C:\>Add-PASGroupMember -GroupName PVWAMonitor -UserName TargetUser

    Adds TargetUser to PVWAMonitor group




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Add-PASGroupMember -GroupName PVWAMonitor -UserName TargetUser

    Adds TargetUser to PVWAMonitor group
