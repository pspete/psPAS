---
title: Remove-PASAccountACL
---

## SYNOPSIS

Deletes privileged commands rule from an account

## SYNTAX

    Remove-PASAccountACL [-AccountPolicyId] <String> [-AccountAddress] <String>
    [-AccountUserName] <String> [-Id] <String>

## DESCRIPTION

Deletes privileged commands rule associated with account

## PARAMETERS

    -AccountPolicyId <String>
        ID of account from which the commands will be deleted

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AccountAddress <String>
        The address of the account for which the privileged command will be deleted.

        Required?                    true
        Position?                    2
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AccountUserName <String>
        The name of the account's user.

        Required?                    true
        Position?                    3
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Id <String>
        The ID of the command that will be deleted

        Required?                    true
        Position?                    4
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


    Should accept pipeline objects from Get-PASAccountACL functio.

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Remove-PASAccountACL -AccountPolicyId UNIXSSH -AccountAddress machine
    -AccountUserName root -Id 12

    Removes matching Privileged Account Rule from the account root




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Get-PASAccount root | Get-PASAccountACL | Where-Object{$_.Command -eq "ifconfig"} |
        Remove-PASAccountACL

    Removes matching Privileged Account Rule from account.
