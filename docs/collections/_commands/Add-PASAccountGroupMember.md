---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Add-PASAccountGroupMember
schema: 2.0.0
title: Add-PASAccountGroupMember
---

# Add-PASAccountGroupMember

## SYNOPSIS
Adds an account as a member of an account group.

## SYNTAX

```
Add-PASAccountGroupMember [-GroupID] <String> [-AccountID] <String> [<CommonParameters>]
```

## DESCRIPTION
Adds an account as a member of an account group.

The account can contain either password or SSH key.

The account must be stored in the same safe as the account group.

The following permissions are required on the safe where the account group will be created:
- Add Accounts
- Update Account Content
- Update Account Properties

## EXAMPLES

### EXAMPLE 1
```
Add-PASAccountGroupMember -GroupID $groupID -AccountID $accID
```

Adds account with ID held in $accID to group with ID held in $groupID

## PARAMETERS

### -GroupID
The unique ID of the account group

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AccountID
The ID of the account to add as a member

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Add-PASAccountGroupMember](https://pspas.pspete.dev/commands/Add-PASAccountGroupMember)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add-account-to-account-group.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add-account-to-account-group.htm)
