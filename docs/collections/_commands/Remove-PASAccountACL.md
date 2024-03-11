---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Remove-PASAccountACL
schema: 2.0.0
title: Remove-PASAccountACL
---

# Remove-PASAccountACL

## SYNOPSIS
Deletes privileged commands rule from an account

## SYNTAX

```
Remove-PASAccountACL [-AccountPolicyId] <String> [-AccountAddress] <String> [-AccountUserName] <String>
 [-Id] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes privileged commands rule associated with account

Not supported in Privilege Cloud

## EXAMPLES

### EXAMPLE 1
```
Remove-PASAccountACL -AccountPolicyId UNIXSSH -AccountAddress machine -AccountUserName root -Id 12
```

Removes matching Privileged Account Rule from the account root

### EXAMPLE 2
```
Get-PASAccount root | Get-PASAccountACL | Where-Object{$_.Command -eq "ifconfig"} | Remove-PASAccountACL
```

Removes matching Privileged Account Rule from account.

## PARAMETERS

### -AccountPolicyId
ID of account from which the commands will be deleted

```yaml
Type: String
Parameter Sets: (All)
Aliases: PolicyID

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AccountAddress
The address of the account for which the privileged command will be deleted.

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

### -AccountUserName
The name of the account's user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Id
The ID of the command that will be deleted

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
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

[https://pspas.pspete.dev/commands/Remove-PASAccountACL](https://pspas.pspete.dev/commands/Remove-PASAccountACL)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20Account%20ACL.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20Account%20ACL.htm)
