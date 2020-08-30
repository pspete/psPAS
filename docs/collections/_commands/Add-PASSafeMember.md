---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Add-PASSafeMember
schema: 2.0.0
title: Add-PASSafeMember
---

# Add-PASSafeMember

## SYNOPSIS
Adds a Safe Member to safe

## SYNTAX

```
Add-PASSafeMember -SafeName <String> -MemberName <String> [-SearchIn <String>]
 [-MembershipExpirationDate <DateTime>] [-UseAccounts <Boolean>] [-RetrieveAccounts <Boolean>]
 [-ListAccounts <Boolean>] [-AddAccounts <Boolean>] [-UpdateAccountContent <Boolean>]
 [-UpdateAccountProperties <Boolean>] [-InitiateCPMAccountManagementOperations <Boolean>]
 [-SpecifyNextAccountContent <Boolean>] [-RenameAccounts <Boolean>] [-DeleteAccounts <Boolean>]
 [-UnlockAccounts <Boolean>] [-ManageSafe <Boolean>] [-ManageSafeMembers <Boolean>] [-BackupSafe <Boolean>]
 [-ViewAuditLog <Boolean>] [-ViewSafeMembers <Boolean>] [-RequestsAuthorizationLevel <Int32>]
 [-AccessWithoutConfirmation <Boolean>] [-CreateFolders <Boolean>] [-DeleteFolders <Boolean>]
 [-MoveAccountsAndFolders <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
Adds an existing user as a Safe member.
"Manage Safe Members" permission is required by the authenticated user account sending request.

Unless otherwise specified, the default permissions applied to a safe member will include:
- ListAccounts, RetrieveAccounts, UseAccounts, ViewAuditLog & ViewSafeMembers.

If these permissions should not be granted to the safe member, they must be explicitly set to $false in the request.

## EXAMPLES

### EXAMPLE 1
```
Add-PASSafeMember -SafeName Windows_Safe -MemberName winUser -SearchIn Vault -UseAccounts $true `

-RetrieveAccounts $true -ListAccounts $true
```

Adds winUser to Windows_Safe with Use, Retrieve & List permissions

### EXAMPLE 2
```
$Role = [PSCustomObject]@{

  UseAccounts                  = $true
  ListAccounts                 = $true
  RetrieveAccounts						 = $true
  ViewAuditLog                 = $false
  ViewSafeMembers              = $false
}

PS > $Role | Add-PASSafeMember -SafeName NewSafe -MemberName User23 -SearchIn Vault
```

Grant User23 UseAccounts, RetrieveAccounts & ListAccounts only

## PARAMETERS

### -SafeName
The name of the safe to add the member to

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MemberName
Vault or Domain User, or Group, to add as member.

Must not contain '&' (ampersand).

```yaml
Type: String
Parameter Sets: (All)
Aliases: UserName

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SearchIn
The Vault or Domain, defined in the vault,

in which to search for the member to add to the safe.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MembershipExpirationDate
Defines when the user's Safe membership expires.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UseAccounts
Boolean value defining if UseAccounts permission will be granted to
safe member on safe.

Get-PASSafeMember returns the name of this permission as: RestrictedRetrieve

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: RestrictedRetrieve

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RetrieveAccounts
Boolean value defining if RetrieveAccounts permission will be granted
to safe member on safe.

Get-PASSafeMember returns the name of this permission as: Retrieve

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: Retrieve

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ListAccounts
Boolean value defining if ListAccounts permission will be granted to
safe member on safe.

Get-PASSafeMember returns the name of this permission as: ListContent

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: ListContent

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AddAccounts
Boolean value defining if permission will be granted to safe member
on safe.

Includes UpdateAccountProperties (when adding or removing permission).

Get-PASSafeMember returns the name of this permission as: Add

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: Add

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UpdateAccountContent
Boolean value defining if AddAccounts permission will be granted to safe
member on safe.

Get-PASSafeMember returns the name of this permission as: Update

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: Update

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UpdateAccountProperties
Boolean value defining if UpdateAccountProperties permission will be granted
to safe member on safe.

Get-PASSafeMember returns the name of this permission as: UpdateMetadata

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: UpdateMetadata

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InitiateCPMAccountManagementOperations
Boolean value defining if InitiateCPMAccountManagementOperations permission
will be granted to safe member on safe.

Get-PASSafeMember may not return details of this permission

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SpecifyNextAccountContent
Boolean value defining if SpecifyNextAccountContent permission will be granted
to safe member on safe.

Get-PASSafeMember may not return details of this permission

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RenameAccounts
Boolean value defining if RenameAccounts permission will be granted to safe
member on safe.

Get-PASSafeMember returns the name of this permission as: Rename

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: Rename

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DeleteAccounts
Boolean value defining if DeleteAccounts permission will be granted to safe
member on safe.

Get-PASSafeMember returns the name of this permission as: Delete

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: Delete

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UnlockAccounts
Boolean value defining if UnlockAccounts permission will be granted to safe
member on safe.

Get-PASSafeMember returns the name of this permission as: Unlock

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: Unlock

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ManageSafe
Boolean value defining if ManageSafe permission will be granted to safe member
on safe.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ManageSafeMembers
Boolean value defining if ManageSafeMembers permission will be granted to safe
member on safe.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -BackupSafe
Boolean value defining if BackupSafe permission will be granted to safe member
on safe.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ViewAuditLog
Boolean value defining if ViewAuditLog permission will be granted to safe member
on safe.

Get-PASSafeMember returns the name of this permission as: ViewAudit

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: ViewAudit

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ViewSafeMembers
Boolean value defining if ViewSafeMembers permission will be granted to safe member
on safe.

Get-PASSafeMember returns the name of this permission as: ViewMembers

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: ViewMembers

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RequestsAuthorizationLevel
Integer value defining level assigned to RequestsAuthorizationLevel for safe member.
Valid Values: 0, 1 or 2

Get-PASSafeMember may not return details of this permission

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AccessWithoutConfirmation
Boolean value defining if AccessWithoutConfirmation permission will be granted to
safe member on safe.

Get-PASSafeMember may not return details of this permission

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -CreateFolders
Boolean value defining if CreateFolders permission will be granted to safe member
on safe.

Get-PASSafeMember returns the name of this permission as: AddRenameFolder

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: AddRenameFolder

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DeleteFolders
Boolean value defining if DeleteFolders permission will be granted to safe member
on safe.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MoveAccountsAndFolders
Boolean value defining if MoveAccountsAndFolders permission will be granted to safe
member on safe.

Get-PASSafeMember returns the name of this permission as: MoveFilesAndFolders

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: MoveFilesAndFolders

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Add-PASSafeMember](https://pspas.pspete.dev/commands/Add-PASSafeMember)

