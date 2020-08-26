---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Set-PASSafe
schema: 2.0.0
title: Set-PASSafe
---

# Set-PASSafe

## SYNOPSIS
Updates a safe in the Vault

## SYNTAX

### Update (Default)
```
Set-PASSafe -SafeName <String> [-NewSafeName <String>] [-Description <String>] [-OLACEnabled <Boolean>]
 [-ManagingCPM <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Versions
```
Set-PASSafe -SafeName <String> [-NewSafeName <String>] [-Description <String>] [-OLACEnabled <Boolean>]
 [-ManagingCPM <String>] [-NumberOfVersionsRetention <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Days
```
Set-PASSafe -SafeName <String> [-NewSafeName <String>] [-Description <String>] [-OLACEnabled <Boolean>]
 [-ManagingCPM <String>] [-NumberOfDaysRetention <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a single safe in the Vault.
Manage Safe permission is required.

## EXAMPLES

### EXAMPLE 1
```
Set-PASSafe -SafeName SAFE -Description "New-Description" -NumberOfVersionsRetention 10
```

Updates description and version retention on SAFE

## PARAMETERS

### -SafeName
The name of the safe to update.
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

### -NewSafeName
A name to rename the safe to
Max Length 28 characters.
Cannot start with a space.
Cannot contain: '\','/',':','*','\<','\>','"','.' or '|'

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

### -Description
Updated Description for safe.
Max 100 characters.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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
Accept pipeline input: False
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
Accept pipeline input: False
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

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
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

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
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

[https://pspas.pspete.dev/commands/Set-PASSafe](https://pspas.pspete.dev/commands/Set-PASSafe)

