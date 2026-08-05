---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Add-PASGroupMember
schema: 2.0.0
title: Add-PASGroupMember
---

# Add-PASGroupMember

## SYNOPSIS
Adds a vault user as a group member

## SYNTAX

### Gen2 (Default)
```
Add-PASGroupMember -groupId <Int32> -memberId <String> [-memberType <String>] [-domainName <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### Gen1
```
Add-PASGroupMember -GroupName <String> -UserName <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds an existing user to an existing group in the vault

Default operation using the Gen2 API requires minimum version of 10.6

## EXAMPLES

### EXAMPLE 1
```
Add-PASGroupMember -GroupName PVWAMonitor -UserName TargetUser
```

Adds TargetUser to PVWAMonitor group

### EXAMPLE 2
```
Add-PASGroupMember -groupId 1234 -memberId "DOMAIN\TargetGroup" -memberType domain -domainName domain.com
```

Adds the domain group TargetGroup to group with id 1234

Minimum required version 10.6

### EXAMPLE 3
```
Add-PASGroupMember -groupId 1234 -memberId TargetUser
```

Adds TargetUser to group with id 1234

Minimum required version 10.6

## PARAMETERS

### -groupId
The unique ID of the group to add the member to.

Minimum required version 10.6

```yaml
Type: Int32
Parameter Sets: Gen2
Aliases: ID

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -memberId
The name of the user or group to add as a member.

Minimum required version 10.6

```yaml
Type: String
Parameter Sets: Gen2
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -memberType
The type of user being added to the Vault group.

Valid values: domain/vault

Minimum required version 10.6

```yaml
Type: String
Parameter Sets: Gen2
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -domainName
If memberType=domain, dns address of the domain

Minimum required version 10.6

```yaml
Type: String
Parameter Sets: Gen2
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -GroupName
The name of the user

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

### -UserName
The name of the user

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

### -WhatIf
Shows what would happen if the cmdlet runs. The cmdlet is not run.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Add-PASGroupMember](https://pspas.pspete.dev/commands/Add-PASGroupMember)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/AddMemberToGroup%20v10.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/AddMemberToGroup%20v10.htm)
