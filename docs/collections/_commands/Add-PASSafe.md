---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Add-PASSafe
schema: 2.0.0
title: Add-PASSafe
---

# Add-PASSafe

## SYNOPSIS
Adds a new safe to the Vault

## SYNTAX

### Versions
```
Add-PASSafe -SafeName <String> [-Description <String>] [-OLACEnabled <Boolean>] [-ManagingCPM <String>]
 -NumberOfVersionsRetention <Int32> [<CommonParameters>]
```

### Days
```
Add-PASSafe -SafeName <String> [-Description <String>] [-OLACEnabled <Boolean>] [-ManagingCPM <String>]
 -NumberOfDaysRetention <Int32> [<CommonParameters>]
```

## DESCRIPTION
Adds a new safe to the Vault.

The "Add Safes" permission is required in the vault.

## EXAMPLES

### EXAMPLE 1
```
Add-PASSafe -SafeName Oracle -Description "Oracle Safe" -ManagingCPM PasswordManager -NumberOfVersionsRetention 7
```

Creates a new safe named Oracle with a 7 version retention.

### EXAMPLE 2
```
Add-PASSafe -SafeName Dev_Team -Description "Dev Safe" -ManagingCPM DEV_CPM -NumberOfDaysRetention 7
```

Creates a new safe named Dev_Team, assigned to CPM DEV_CPM, with a 7 day retention period.

## PARAMETERS

### -SafeName
The name of the safe to create.

Max Length 28 characters.

Cannot start with a space.

Cannot contain: '\','/',':','*','\<','\>','"','.' or '|'

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

### -Description
Description of the new safe.

Max 100 characters.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -OLACEnabled
Boolean value, dictating whether or not to enable Object Level Access Control on the safe.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ManagingCPM
The Name of the CPM user to manage the safe.

Specify "" to prevent CPM management.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -NumberOfVersionsRetention
The number of retained versions of every password that is stored in the Safe.

Max value = 999

Specify either this parameter or NumberOfDaysRetention.

```yaml
Type: Int32
Parameter Sets: Versions
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -NumberOfDaysRetention
The number of days for which password versions are saved in the Safe.

Minimum Value: 1

Maximum Value 3650

Specify either this parameter or NumberOfVersionsRetention

```yaml
Type: Int32
Parameter Sets: Days
Aliases:

Required: True
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

[https://pspas.pspete.dev/commands/Add-PASSafe](https://pspas.pspete.dev/commands/Add-PASSafe)

