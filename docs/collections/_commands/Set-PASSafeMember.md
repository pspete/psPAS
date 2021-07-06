---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Set-PASSafeMember
schema: 2.0.0
title: Set-PASSafeMember
---

# Set-PASSafeMember

## SYNOPSIS
Updates a Safe Member

## SYNTAX

```
Set-PASSafeMember -SafeName <String> -MemberName <String> [-MembershipExpirationDate <DateTime>]
 [-UseAccounts <Boolean>] [-RetrieveAccounts <Boolean>] [-ListAccounts <Boolean>] [-AddAccounts <Boolean>]
 [-UpdateAccountContent <Boolean>] [-UpdateAccountProperties <Boolean>]
 [-InitiateCPMAccountManagementOperations <Boolean>] [-SpecifyNextAccountContent <Boolean>]
 [-RenameAccounts <Boolean>] [-DeleteAccounts <Boolean>] [-UnlockAccounts <Boolean>] [-ManageSafe <Boolean>]
 [-ManageSafeMembers <Boolean>] [-BackupSafe <Boolean>] [-ViewAuditLog <Boolean>] [-ViewSafeMembers <Boolean>]
 [-RequestsAuthorizationLevel <Int32>] [-AccessWithoutConfirmation <Boolean>] [-CreateFolders <Boolean>]
 [-DeleteFolders <Boolean>] [-MoveAccountsAndFolders <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates an existing Safe Member's permissions on a safe.

Manage Safe Members permission is required.

## EXAMPLES

### EXAMPLE 1
```
Set-PASSafeMember -SafeName TargetSafe -MemberName TargetUser -AddAccounts $true
```

Updates TargetUser's permissions as safe member on TargetSafe to include "Add Accounts"

## PARAMETERS

### -SafeName
The name of the safe to which the safe member belong

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
Vault or Domain User, or Group, safe member to update.

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

### -MembershipExpirationDate
Defines when the member's Safe membership expires.

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

### -RetrieveAccounts
Boolean value defining if RetrieveAccounts permission will be granted
to safe member on safe.

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

### -ListAccounts
Boolean value defining if ListAccounts permission will be granted to
safe member on safe.

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

### -AddAccounts
Boolean value defining if permission will be granted to safe member
on safe.

Includes UpdateAccountProperties (when adding or removing permission).

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

### -UpdateAccountContent
Boolean value defining if AddAccounts permission will be granted to safe
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

### -UpdateAccountProperties
Boolean value defining if UpdateAccountProperties permission will be granted
to safe member on safe.

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

### -InitiateCPMAccountManagementOperations
Boolean value defining if InitiateCPMAccountManagementOperations permission
will be granted to safe member on safe.

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

### -DeleteAccounts
Boolean value defining if DeleteAccounts permission will be granted to safe
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

### -UnlockAccounts
Boolean value defining if UnlockAccounts permission will be granted to safe
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

### -ViewSafeMembers
Boolean value defining if ViewSafeMembers permission will be granted to safe member
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

### -RequestsAuthorizationLevel
Integer value defining level assigned to RequestsAuthorizationLevel for safe member.

Valid Values: 0, 1 or 2

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Set-PASSafeMember](https://pspas.pspete.dev/commands/Set-PASSafeMember)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Update%20Safe%20Member.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Update%20Safe%20Member.htm)
