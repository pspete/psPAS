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
Test-PASDiscoveredLocalAccount -type <String> -subtype <String> -address <String> -username <String>
 -externalId <String> [<CommonParameters>]
```

### multiple
```
Test-PASDiscoveredLocalAccount -accounts <Hashtable[]> [<CommonParameters>]
```

## DESCRIPTION

Check discovered account existence

## EXAMPLES

### Example 1

```powershell
PS C:\> Test-PASDiscoveredLocalAccount -type Windows -subtype Domain -address win-computer.cyber-ark.com -username admin -externalId "user_account_5924"
```

Checks for the existence of the specified account

### Example 2

```powershell
PS C:\> $accounts = @(
    New-PASDiscoveredAccountObject -type windows -subType loosely -address win-computer.cyber-ark.com -username admin -externalId user_account_5924
    New-PASDiscoveredAccountObject -type mac -subType loosely -address mac-computer.cyber-ark.com -username root -externalId user_account_1132
)
PS C:\> Test-PASDiscoveredLocalAccount -accounts $accounts
```

Uses New-PASDiscoveredAccountObject to build an array of correctly structured account objects, and checks for the existence of all of them in a single request.

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

### -address

The address identifier of the account

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

### -username

The username identifier of the account

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

each account must be a hashtable containing type, subType, identifiers & externalId keys, in the format expected by the API.

New-PASDiscoveredAccountObject can be used to create correctly structured account objects to pass as this parameter's value.

```yaml
Type: Hashtable[]
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

[https://pspas.pspete.dev/commands/New-PASDiscoveredAccountObject](https://pspas.pspete.dev/commands/New-PASDiscoveredAccountObject)

[https://docs.cyberark.com/identity-protection-space/latest/en/content/discovery/discovery-discoveredaccountsservice-check.htm](https://docs.cyberark.com/identity-protection-space/latest/en/content/discovery/discovery-discoveredaccountsservice-check.htm)
