---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Set-PASDependentLinkedAccount
title: Set-PASDependentLinkedAccount
schema: 2.0.0
---

# Set-PASDependentLinkedAccount

## SYNOPSIS

Sets a Linked Account for a Dependent Account

## SYNTAX

```
Set-PASDependentLinkedAccount [-accountId] <String> [-dependentAccountId] <String>
 [-extraPasswordAccountId] <String> [-extraPasswordIndex] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Links an account to a dependent account

## EXAMPLES

### Example 1

```powershell
PS C:\> Set-PASDependentLinkedAccount -accountId 12_3 -dependentAccountId 12_4 -extraPasswordAccountId 56_7 -extraPasswordIndex 1
```

Links account with ID 56_7 to linked account index 1 for dependent account 12_4 with parent account 12_3

## PARAMETERS

### -accountId

The ID of the parent account for the dependent account

```yaml
Type: String
Parameter Sets: (All)
Aliases: id

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -dependentAccountId

The ID of the dependent account

```yaml
Type: String
Parameter Sets: (All)
Aliases: dependentid

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -extraPasswordAccountId

The ID of the account to link to the dependent account

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

### -extraPasswordIndex

The index to link the account to

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

[https://pspas.pspete.dev/commands/Set-PASDependentLinkedAccount](https://pspas.pspete.dev/commands/Set-PASDependentLinkedAccount)

[https://docs.cyberark.com/privilege-cloud-shared-services/latest/en/content/privilegecloudapis/account-dependents-cpm.htm](https://docs.cyberark.com/privilege-cloud-shared-services/latest/en/content/privilegecloudapis/account-dependents-cpm.htm)
