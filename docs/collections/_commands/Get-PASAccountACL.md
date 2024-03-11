---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASAccountACL
schema: 2.0.0
title: Get-PASAccountACL
---

# Get-PASAccountACL

## SYNOPSIS
Lists privileged commands rule for an account

## SYNTAX

```
Get-PASAccountACL [-AccountPolicyId] <String> [-AccountAddress] <String> [-AccountUserName] <String>
 [<CommonParameters>]
```

## DESCRIPTION
Gets list of all privileged commands associated with an account

Not supported in Privilege Cloud

## EXAMPLES

### EXAMPLE 1
```
Get-PASAccount root | Get-PASAccountACL
```

Returns Privileged Account Rules for the account root found by Get-PASAccount

## PARAMETERS

### -AccountPolicyId
The PolicyID associated with account.

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
The address of the account whose privileged commands will be listed.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Address

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
Aliases: UserName

Required: True
Position: 3
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

[https://pspas.pspete.dev/commands/Get-PASAccountACL](https://pspas.pspete.dev/commands/Get-PASAccountACL)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/List%20Account%20ACL.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/List%20Account%20ACL.htm)
