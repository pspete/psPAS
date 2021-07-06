---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASAccountGroupMember
schema: 2.0.0
title: Get-PASAccountGroupMember
---

# Get-PASAccountGroupMember

## SYNOPSIS
Returns all the members of a specific account group.

## SYNTAX

```
Get-PASAccountGroupMember [-GroupID] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns all the members of a specific account group.

These accounts can be either password accounts or SSH Key accounts.

The following permissions are required on the safe:
 - Add Accounts
 - Update Account Content
 - Update Account Properties
  -Create Folders

## EXAMPLES

### EXAMPLE 1
```
Get-PASAccountGroupMember -GroupID 21_9
```

List all members of account group with ID of 21_9

## PARAMETERS

### -GroupID
The unique ID of the account groups.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Minimum CyberArk version 9.10

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASAccountGroupMember](https://pspas.pspete.dev/commands/Get-PASAccountGroupMember)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetAccountGroupMembers.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetAccountGroupMembers.htm)
