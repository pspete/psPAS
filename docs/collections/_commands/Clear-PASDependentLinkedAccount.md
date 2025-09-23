---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Clear-PASDependentLinkedAccount
title: Clear-PASDependentLinkedAccount
schema: 2.0.0
---

# Clear-PASDependentLinkedAccount

## SYNOPSIS

Clears a linked account from a dependent account

## SYNTAX

```
Clear-PASDependentLinkedAccount [-AccountID] <String> [-dependentAccountId] <String>
 [-extraPasswordIndex] <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Unlink an account from a dependent account

## EXAMPLES

### Example 1

```powershell
PS C:\> Clear-PASDependentLinkedAccount -AccountID 32_1 -dependentAccountId 32_2 -extraPasswordIndex 1
```

Clears linked account index 1 from dependent account 32_2

## PARAMETERS

### -AccountID

The ID of the parent account for the linked account

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

The ID of the Dependent account for the Parent Account

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

### -extraPasswordIndex

The index of the account to unlink from the dependent account

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: 0
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

[https://pspas.pspete.dev/commands/Clear-PASDependentLinkedAccount](https://pspas.pspete.dev/commands/Clear-PASDependentLinkedAccount)

[https://docs.cyberark.com/privilege-cloud-shared-services/latest/en/content/privilegecloudapis/account-dependents-cpm.htm](https://docs.cyberark.com/privilege-cloud-shared-services/latest/en/content/privilegecloudapis/account-dependents-cpm.htm)
