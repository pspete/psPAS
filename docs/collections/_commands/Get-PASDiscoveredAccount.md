---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASDiscoveredAccount
schema: 2.0.0
title: Get-PASDiscoveredAccount
---

# Get-PASDiscoveredAccount

## SYNOPSIS
Returns discovered accounts from the Pending Accounts list.

## SYNTAX

### byQuery (Default)
```
Get-PASDiscoveredAccount [-platformType <String>] [-privileged <Boolean>] [-AccountEnabled <Boolean>]
 [-search <String>] [-searchType <String>] [-limit <Int32>] [<CommonParameters>]
```

### byID
```
Get-PASDiscoveredAccount [-id <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns discovered accounts from the Pending Accounts list.

Filters can be specified to limit the results.

ID can be specified to focus in single account.

Membership of Vault admins group required.

## EXAMPLES

### EXAMPLE 1
```
Get-PASDiscoveredAccount
```

Returns all discovered accounts

### EXAMPLE 2
```
Get-PASDiscoveredAccount -id 18_88
```

Returns discovered account with id 18_88

### EXAMPLE 3
```
Get-PASDiscoveredAccount -platformType 'Windows Domain' -AccountEnabled $true -privileged $true -search SomeSearchTerm
```

Returns discovered accounts matching query

## PARAMETERS

### -id
The ID of a discovered account to get details of.

```yaml
Type: String
Parameter Sets: byID
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -platformType
Whether to return only the accounts of a specific platform

Valid Values:
- Windows Server Local
- Windows Desktop Local
- Windows Domain
- Unix
- Unix SSH Key
- AWS
- AWS Access Keys

```yaml
Type: String
Parameter Sets: byQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -privileged
Whether to return only privileged accounts or not

```yaml
Type: Boolean
Parameter Sets: byQuery
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AccountEnabled
Whether to return only enabled accounts or not

```yaml
Type: Boolean
Parameter Sets: byQuery
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -search
A term to search for.

Search is supported for userName and address.

```yaml
Type: String
Parameter Sets: byQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -searchType
The type of search to perform.

The keyword can either be contained within the account property values,
or at the beginning of the value specified in the Search parameter.

When using a keyword at the beginning of a value, performance is enhanced.

```yaml
Type: String
Parameter Sets: byQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -limit
The maximum number of returned accounts.

If not specified, the server limits the results to 100.

The maximum number that can be specified is 1000.

```yaml
Type: Int32
Parameter Sets: byQuery
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASDiscoveredAccount](https://pspas.pspete.dev/commands/Get-PASDiscoveredAccount)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Get-discovered-accounts.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Get-discovered-accounts.htm)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Get-discovered-account-details.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Get-discovered-account-details.htm)
