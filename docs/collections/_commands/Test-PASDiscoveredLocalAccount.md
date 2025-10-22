---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Test-PASDiscoveredLocalAccount
schema: 2.0.0
title: Test-PASDiscoveredLocalAccount
---

# Test-PASDiscoveredLocalAccount

## SYNOPSIS

Check discovered account existence

## SYNTAX

### single
```
Test-PASDiscoveredLocalAccount -type <String> -subtype <String> -identifiers <Hashtable> -externalId <String>
 [<CommonParameters>]
```

### multiple
```
Test-PASDiscoveredLocalAccount -accounts <DiscoveredAccount[]> [<CommonParameters>]
```

## DESCRIPTION

Check discovered account existence

## EXAMPLES

### Example 1

```powershell
PS C:\> Test-PASDiscoveredLocalAccount -type Windows -subtype Domain -identifiers @{
    "address" = "win-computer.cyber-ark.com"
    "username" = "admin"
} -externalId "user_account_5924"
```

Checks for the existence of the specified account

## PARAMETERS

### -type

The account type

```yaml
Type: String
Parameter Sets: single
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -subtype

The account subtype

```yaml
Type: String
Parameter Sets: single
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -identifiers

Any account identifiers

```yaml
Type: Hashtable
Parameter Sets: single
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -externalId

The external id of the account

```yaml
Type: String
Parameter Sets: single
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -accounts

a collection of accounts to query.

account details are created using the DiscoveredAccount class

```yaml
Type: DiscoveredAccount[]
Parameter Sets: multiple
Aliases:

Required: True
Position: Named
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

[https://pspas.pspete.dev/commands/Test-PASDiscoveredLocalAccount](https://pspas.pspete.dev/commands/Test-PASDiscoveredLocalAccount)

[https://docs.cyberark.com/identity-protection-space/latest/en/content/discovery/discovery-discoveredaccountsservice-check.htm](https://docs.cyberark.com/identity-protection-space/latest/en/content/discovery/discovery-discoveredaccountsservice-check.htm)
