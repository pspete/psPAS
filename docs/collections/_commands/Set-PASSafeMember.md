---
title: Set-PASSafeMember
---

## SYNOPSIS

Updates a Safe Member

## SYNTAX

    Set-PASSafeMember -SafeName <String> -MemberName <String> [-MembershipExpirationDate <DateTime>]
    [-UseAccounts <Boolean>] [-RetrieveAccounts <Boolean>] [-ListAccounts <Boolean>]
    [-AddAccounts <Boolean>] [-UpdateAccountContent <Boolean>] [-UpdateAccountProperties <Boolean>]
    [-InitiateCPMAccountManagementOperations <Boolean>] [-SpecifyNextAccountContent <Boolean>]
    [-RenameAccounts <Boolean>] [-DeleteAccounts <Boolean>] [-UnlockAccounts <Boolean>]
    [-ManageSafe <Boolean>] [-ManageSafeMembers <Boolean>] [-BackupSafe <Boolean>]
    [-ViewAuditLog <Boolean>] [-ViewSafeMembers <Boolean>] [-RequestsAuthorizationLevel <Int32>]
    [-AccessWithoutConfirmation <Boolean>] [-CreateFolders <Boolean>] [-DeleteFolders <Boolean>]
    [-MoveAccountsAndFolders <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]

## DESCRIPTION

Updates an existing Safe Member's permissions on a safe.

Manage Safe Members permission is required.

## PARAMETERS

    -SafeName <String>
        The name of the safe to which the safe member belong

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -MemberName <String>
        Vault or Domain User, or Group, safe member to update.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -MembershipExpirationDate <DateTime>
        Defines when the member's Safe membership expires.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UseAccounts <Boolean>
        Boolean value defining if UseAccounts permission will be granted to
        safe member on safe.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -RetrieveAccounts <Boolean>
        Boolean value defining if RetrieveAccounts permission will be granted
        to safe member on safe.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ListAccounts <Boolean>
        Boolean value defining if ListAccounts permission will be granted to
        safe member on safe.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AddAccounts <Boolean>
        Boolean value defining if permission will be granted to safe member
        on safe.
        Includes UpdateAccountProperties (when adding or removing permission).

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UpdateAccountContent <Boolean>
        Boolean value defining if AddAccounts permission will be granted to safe
        member on safe.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UpdateAccountProperties <Boolean>
        Boolean value defining if UpdateAccountProperties permission will be granted
        to safe member on safe.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -InitiateCPMAccountManagementOperations <Boolean>
        Boolean value defining if InitiateCPMAccountManagementOperations permission
        will be granted to safe member on safe.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -SpecifyNextAccountContent <Boolean>
        Boolean value defining if SpecifyNextAccountContent permission will be granted
        to safe member on safe.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -RenameAccounts <Boolean>
        Boolean value defining if RenameAccounts permission will be granted to safe
        member on safe.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -DeleteAccounts <Boolean>
        Boolean value defining if DeleteAccounts permission will be granted to safe
        member on safe.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UnlockAccounts <Boolean>
        Boolean value defining if UnlockAccounts permission will be granted to safe
        member on safe.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ManageSafe <Boolean>
        Boolean value defining if ManageSafe permission will be granted to safe member
        on safe.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ManageSafeMembers <Boolean>
        Boolean value defining if ManageSafeMembers permission will be granted to safe
        member on safe.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -BackupSafe <Boolean>
        Boolean value defining if BackupSafe permission will be granted to safe member
        on safe.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ViewAuditLog <Boolean>
        Boolean value defining if ViewAuditLog permission will be granted to safe member
        on safe.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ViewSafeMembers <Boolean>
        Boolean value defining if ViewSafeMembers permission will be granted to safe member
        on safe.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -RequestsAuthorizationLevel <Int32>
        Integer value defining level assigned to RequestsAuthorizationLevel for safe member.
        Valid Values: 0, 1 or 2

        Required?                    false
        Position?                    named
        Default value                0
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AccessWithoutConfirmation <Boolean>
        Boolean value defining if AccessWithoutConfirmation permission will be granted to
        safe member on safe.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -CreateFolders <Boolean>
        Boolean value defining if CreateFolders permission will be granted to safe member
        on safe.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -DeleteFolders <Boolean>
        Boolean value defining if DeleteFolders permission will be granted to safe member
        on safe.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -MoveAccountsAndFolders <Boolean>
        Boolean value defining if MoveAccountsAndFolders permission will be granted to safe
        member on safe.

        Required?                    false
        Position?                    named
        Default value                False
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

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Set-PASSafeMember -SafeName TargetSafe -MemberName TargetUser -AddAccounts $true

    Updates TargetUser's permissions as safe member on TargetSafe to include "Add Accounts"
