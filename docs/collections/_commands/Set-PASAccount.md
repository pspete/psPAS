---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Set-PASAccount
schema: 2.0.0
title: Set-PASAccount
---

# Set-PASAccount

## SYNOPSIS
Updates an existing accounts details.

## SYNTAX

### Gen2SingleOp (Default)
```
Set-PASAccount -AccountID <String> -op <String> -path <String> [-value <String>] [-InputObject <PSObject>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Gen2MultiOp
```
Set-PASAccount -AccountID <String> -operations <Hashtable[]> [-InputObject <PSObject>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### Gen1
```
Set-PASAccount -AccountID <String> -Folder <String> -AccountName <String> [-DeviceType <String>]
 [-PlatformID <String>] [-Address <String>] [-UserName <String>] [-GroupName <String>]
 [-GroupPlatformID <String>] [-Properties <Hashtable>] [-InputObject <PSObject>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Updates an existing accounts details.

Default operation using the Gen2 API requires minimum version fo 10.4

When using the Gen1 API:

- It is not supported in Privilege Cloud
- All of the account's property details MUST be passed to the function.
- Any current properties of the account not sent as part of the request will be removed
from the account.
- To change a property value not exposed via a named parameter,
pass the property name and updated value to the function via the Properties parameter.
- If changing the name or folder of a service account that has multiple dependencies (usages),
the connection between it and its dependencies will be automatically maintained.
- If changing the name or folder of an account that is linked to another account (whether logon,
reconciliation or verification), the links will be automatically updated.

## EXAMPLES

### EXAMPLE 1
```
Set-PASAccount -AccountID 27_4 -op replace -path "/address" -value "NewAddress"
```

Replaces the current address value with NewAddress

Requires minimum version of 10.4

### EXAMPLE 2
```
Set-PASAccount -AccountID 27_4 -op remove -path "/platformAccountProperties/UserDN"
```

Removes UserDN property set on account

Requires minimum version of 10.4

### EXAMPLE 3
```
$actions += @{"op"="Add";"path"="/platformAccountProperties/UserDN";"value"="SomeDN"}

$actions += @{"op"="Replace";"path"="/Name";"value"="SomeName"}

Set-PASAccount -AccountID 27_4 -operations $actions
```

Performs the update operations contained in the $actions array against the account

Requires minimum version of 10.4

### EXAMPLE 4
```
Get-PASAccount DBUser | Set-PASAccount -Properties @{"DSN"="myDSN"}
```

Sets DSN value on matched account dbUser

Requires minimum version of 10.4

### EXAMPLE 5
```
Set-PASAccount -AccountID 21_3 -Folder Root -AccountName NewName `
-DeviceType Database -PlatformID Oracle -Address dbServer.domain.com -UserName DBUser
```

Will set the AccountName of account with AccountID of 21_3 to "NewName".

**Any/All additional properties of the account which are not specified via parameters will be cleared**

Not supported in Privilege Cloud

### EXAMPLE 6

```
$actions = @()
$props = @{"port"="5022";"UserDN"="SomeDN";"LogonDomain"="SomeDomain"}
$actions += @{"op"="add";"path"="/platformAccountProperties";"value"=$props}
Set-PASAccount -AccountID 29_3 -operations $actions
```

Adds multiple values to categories under the platformAccountProperties path.

Requires minimum version of 10.4

## PARAMETERS

### -AccountID
The unique ID of the account to update.

As returned by by Get-PASAccount

```yaml
Type: String
Parameter Sets: (All)
Aliases: id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -op
The operation to perform (add, remove, replace).

Requires minimum version of 10.4

```yaml
Type: String
Parameter Sets: Gen2SingleOp
Aliases: Operation

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -path
The path of the property to update, for instance /address or /name.

Requires minimum version of 10.4

```yaml
Type: String
Parameter Sets: Gen2SingleOp
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -value
The new property value for add or replace operations.

Requires minimum version of 10.4

```yaml
Type: String
Parameter Sets: Gen2SingleOp
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -operations
A collection of update actions to perform, must include op, path & value (except where action is remove).

Requires minimum version of 10.4

```yaml
Type: Hashtable[]
Parameter Sets: Gen2MultiOp
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Folder
The folder where the account is stored.

```yaml
Type: String
Parameter Sets: Gen1
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AccountName
The name of the account

```yaml
Type: String
Parameter Sets: Gen1
Aliases: Name

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DeviceType
The devicetype assigned to the account.

Ensure all required parameters are specified.

Different device types require different parameters

```yaml
Type: String
Parameter Sets: Gen1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PlatformID
The CyberArk platform assigned to the account

Ensure all required parameters are specified.

Different platforms require different parameters

```yaml
Type: String
Parameter Sets: Gen1
Aliases: PolicyID

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Address
The Name or Address of the machine where the account will be used

```yaml
Type: String
Parameter Sets: Gen1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UserName
The Username on the target machine

```yaml
Type: String
Parameter Sets: Gen1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -GroupName
A groupname with which the account will be associated

The name of the group with which the account is associated.

To create a new group, specify the group platform ID in the GroupPlatformID property,
then specify the group name.

The group will then be created automatically.

```yaml
Type: String
Parameter Sets: Gen1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -GroupPlatformID
GroupPlatformID is required if account is to be moved to a new group.

```yaml
Type: String
Parameter Sets: Gen1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Properties
Hashtable of name=value pairs.

Specify properties to update.

```yaml
Type: Hashtable
Parameter Sets: Gen1
Aliases:

Required: False
Position: Named
Default value: @{ }
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Receives object from pipeline.

```yaml
Type: PSObject
Parameter Sets: Gen2SingleOp, Gen2MultiOp
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: PSObject
Parameter Sets: Gen1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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
Dependencies (usages) cannot be updated.
Accounts that do not have a policy ID cannot be updated.

To update account properties, "Update password properties" permission is required.
To rename accounts, "Rename accounts" permission is required.
To move accounts to a different folder, Move accounts/folders permission is required.

## RELATED LINKS

[https://pspas.pspete.dev/commands/Set-PASAccount](https://pspas.pspete.dev/commands/Set-PASAccount)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/UpdateAccount%20v10.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/UpdateAccount%20v10.htm)
