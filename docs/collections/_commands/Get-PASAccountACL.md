---
title: Get-PASAccountACL
---

## SYNOPSIS

Lists privileged commands rule for an account

## SYNTAX

    Get-PASAccountACL [-AccountPolicyId] <String> [-AccountAddress] <String>
    [-AccountUserName] <String> [<CommonParameters>]

## DESCRIPTION

Gets list of all privileged commands associated with an account

## PARAMETERS

    -AccountPolicyId <String>
        The PolicyID associated with account.

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AccountAddress <String>
        The address of the account whose privileged commands will be listed.

        Required?                    true
        Position?                    2
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AccountUserName <String>
        The name of the account s user.

        Required?                    true
        Position?                    3
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

    PS C:\>Get-PASAccount root | Get-PASAccountACL

    Returns Privileged Account Rules for the account root found by Get-PASAccount:

    PolicyId Command                       PermissionType UserName Type    IsGroup
    -------- -------                       -------------- -------- ----    -------
    UNIXSSH  ifconfig                      Allow          TestUser Account False
    UNIXSSH  for /l %a in (0,0,0) do start Deny           TestUser Account False
    UNIXSSH  for /l %a in (0,0,0) do xyz   Allow          TestUser Account False
