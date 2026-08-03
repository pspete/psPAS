---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/New-PASDiscoveredAccountObject
schema: 2.0.0
title: New-PASDiscoveredAccountObject
---

# New-PASDiscoveredAccountObject

## SYNOPSIS

Creates hashtable structured to be used as input for the accounts parameter of Test-PASDiscoveredLocalAccount

## SYNTAX

```
New-PASDiscoveredAccountObject -type <String> -subType <String> -address <String> -username <String>
 -externalId <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Provide parameter values to return a hashtable, correctly structured to represent a single discovered account.

The output of this function is intended to be collected into an array and passed to the accounts parameter of Test-PASDiscoveredLocalAccount, to check the existence of multiple discovered accounts in a single request.

## EXAMPLES

### Example 1

```powershell
New-PASDiscoveredAccountObject -type Windows -subType Domain -address win-computer.cyber-ark.com -username admin -externalId user_account_5924
```

Returns hashtable structured to represent a single discovered account.

### Example 2

```powershell
$accounts = @(
    New-PASDiscoveredAccountObject -type windows -subType loosely -address win-computer.cyber-ark.com -username admin -externalId user_account_5924
    New-PASDiscoveredAccountObject -type mac -subType loosely -address mac-computer.cyber-ark.com -username root -externalId user_account_1132
)
Test-PASDiscoveredLocalAccount -accounts $accounts
```

Builds an array of discovered account objects and checks the existence of all of them in a single request.

### Example 3

```powershell
New-PASDiscoveredAccountObject -type Windows -subType Domain -address win-computer.cyber-ark.com -username admin -externalId user_account_5924 -WhatIf
```

Shows what would happen if the discovered account object were created, but does not return the object.

### Example 4

```powershell
[PSCustomObject]@{type='Unix'; subType='Local'; address='unix-host.cyber-ark.com'; username='root'; externalId='user_account_8842'} | New-PASDiscoveredAccountObject
```

Creates a discovered account object using pipeline input, with property names matching the function's parameters.

## PARAMETERS

### -type

The account type

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

### -subType

The account subtype

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

### -address

The address identifier of the account

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

### -username

The username identifier of the account

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

### -externalId

The external id of the account

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

[https://pspas.pspete.dev/commands/New-PASDiscoveredAccountObject](https://pspas.pspete.dev/commands/New-PASDiscoveredAccountObject)

[https://pspas.pspete.dev/commands/Test-PASDiscoveredLocalAccount](https://pspas.pspete.dev/commands/Test-PASDiscoveredLocalAccount)
