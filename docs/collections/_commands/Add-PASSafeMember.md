---
title: Add-PASSafeMember
---

## SYNOPSIS

Adds a Safe Member to safe

## SYNTAX

    Add-PASSafeMember -SafeName <String> -MemberName <String> [-SearchIn <String>]
    [-MembershipExpirationDate <DateTime>] [-UseAccounts <Boolean>] [-RetrieveAccounts <Boolean>]
    [-ListAccounts <Boolean>] [-AddAccounts <Boolean>] [-UpdateAccountContent <Boolean>]
    [-UpdateAccountProperties <Boolean>] [-InitiateCPMAccountManagementOperations <Boolean>]
    [-SpecifyNextAccountContent <Boolean>] [-RenameAccounts <Boolean>] [-DeleteAccounts <Boolean>]
    [-UnlockAccounts <Boolean>] [-ManageSafe <Boolean>] [-ManageSafeMembers <Boolean>]
    [-BackupSafe <Boolean>] [-ViewAuditLog <Boolean>] [-ViewSafeMembers <Boolean>]
    [-RequestsAuthorizationLevel <Int32>] [-AccessWithoutConfirmation <Boolean>]
    [-CreateFolders <Boolean>] [-DeleteFolders <Boolean>] [-MoveAccountsAndFolders <Boolean>]
    [<CommonParameters>]

## DESCRIPTION

Adds an existing user as a Safe member.

"Manage Safe Members" permission is required by the authenticated user account sending request.

Unless otherwise specified, the default permissions applied to a safe member will include:

- ListAccounts
- RetrieveAccounts
- UseAccounts
- ViewAuditLog
- ViewSafeMembers.

If these permissions should not be granted to the safe member, they must be explicitly set to
$false in the request.

## PARAMETERS

    -SafeName <String>
        The name of the safe to add the member to

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -MemberName <String>
        Vault or Domain User, or Group, to add as member.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -SearchIn <String>
        The Vault or Domain, defined in the vault,
        in which to search for the member to add to the safe.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -MembershipExpirationDate <DateTime>
        Defines when the user's Safe membership expires.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UseAccounts <Boolean>
        Boolean value defining if UseAccounts permission will be granted to
        safe member on safe.
        Get-PASSafeMember returns the name of this permission as: RestrictedRetrieve

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -RetrieveAccounts <Boolean>
        Boolean value defining if RetrieveAccounts permission will be granted
        to safe member on safe.
        Get-PASSafeMember returns the name of this permission as: Retrieve

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ListAccounts <Boolean>
        Boolean value defining if ListAccounts permission will be granted to
        safe member on safe.
        Get-PASSafeMember returns the name of this permission as: ListContent

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AddAccounts <Boolean>
        Boolean value defining if permission will be granted to safe member
        on safe.
        Includes UpdateAccountProperties (when adding or removing permission).
        Get-PASSafeMember returns the name of this permission as: Add

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UpdateAccountContent <Boolean>
        Boolean value defining if AddAccounts permission will be granted to safe
        member on safe.
        Get-PASSafeMember returns the name of this permission as: Update

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UpdateAccountProperties <Boolean>
        Boolean value defining if UpdateAccountProperties permission will be granted
        to safe member on safe.
        Get-PASSafeMember returns the name of this permission as: UpdateMetadata

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -InitiateCPMAccountManagementOperations <Boolean>
        Boolean value defining if InitiateCPMAccountManagementOperations permission
        will be granted to safe member on safe.
        Get-PASSafeMember may not return details of this permission

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -SpecifyNextAccountContent <Boolean>
        Boolean value defining if SpecifyNextAccountContent permission will be granted
        to safe member on safe.
        Get-PASSafeMember may not return details of this permission

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -RenameAccounts <Boolean>
        Boolean value defining if RenameAccounts permission will be granted to safe
        member on safe.
        Get-PASSafeMember returns the name of this permission as: Rename

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -DeleteAccounts <Boolean>
        Boolean value defining if DeleteAccounts permission will be granted to safe
        member on safe.
        Get-PASSafeMember returns the name of this permission as: Delete

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UnlockAccounts <Boolean>
        Boolean value defining if UnlockAccounts permission will be granted to safe
        member on safe.
        Get-PASSafeMember returns the name of this permission as: Unlock

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
        Get-PASSafeMember returns the name of this permission as: ViewAudit

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ViewSafeMembers <Boolean>
        Boolean value defining if ViewSafeMembers permission will be granted to safe member
        on safe.
        Get-PASSafeMember returns the name of this permission as: ViewMembers

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -RequestsAuthorizationLevel <Int32>
        Integer value defining level assigned to RequestsAuthorizationLevel for safe member.
        Valid Values: 0, 1 or 2
        Get-PASSafeMember may not return details of this permission

        Required?                    false
        Position?                    named
        Default value                0
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AccessWithoutConfirmation <Boolean>
        Boolean value defining if AccessWithoutConfirmation permission will be granted to
        safe member on safe.
        Get-PASSafeMember may not return details of this permission

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -CreateFolders <Boolean>
        Boolean value defining if CreateFolders permission will be granted to safe member
        on safe.
        Get-PASSafeMember returns the name of this permission as: AddRenameFolder

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
        Get-PASSafeMember returns the name of this permission as: MoveFilesAndFolders

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Add-PASSafeMember -SafeName Windows_Safe -MemberName winUser -SearchIn Vault
    -UseAccounts $true -RetrieveAccounts $true -ListAccounts $true

    Adds winUser to Windows_Safe with Use, Retrieve & List permissions




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>$Role = [PSCustomObject]@{

      UseAccounts      = $true
      ListAccounts     = $true
      RetrieveAccounts = $true
      ViewAuditLog     = $false
      ViewSafeMembers  = $false
    }

    PS > $Role | Add-PASSafeMember -SafeName NewSafe -MemberName User23 -SearchIn Vault

    Grant User23 UseAccounts, RetrieveAccounts & ListAccounts only
