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

### Gen2-NumberOfDaysRetention (Default)
```
Set-PASSafe -SafeName <String> [-NewSafeName <String>] [-Description <String>] [-location <String>]
 [-OLACEnabled <Boolean>] [-ManagingCPM <String>] [-NumberOfDaysRetention <Int32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### Gen2-NumberOfVersionsRetention
```
Set-PASSafe -SafeName <String> [-NewSafeName <String>] [-Description <String>] [-location <String>]
 [-OLACEnabled <Boolean>] [-ManagingCPM <String>] [-NumberOfVersionsRetention <Int32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### Gen1-NumberOfVersionsRetention
```
Set-PASSafe -SafeName <String> [-NewSafeName <String>] [-Description <String>] [-OLACEnabled <Boolean>]
 [-ManagingCPM <String>] [-NumberOfVersionsRetention <Int32>] [-UseGen1API] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### Gen1-NumberOfDaysRetention
```
Set-PASSafe -SafeName <String> [-NewSafeName <String>] [-Description <String>] [-OLACEnabled <Boolean>]
 [-ManagingCPM <String>] [-NumberOfDaysRetention <Int32>] [-UseGen1API] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Updates a single safe in the Vault.
Manage Safe permission is required.
All required properties should be sent in the request.
Any properties set on the safe not included in the request will be cleared.

## EXAMPLES

### EXAMPLE 1
```
Set-PASSafe -SafeName SAFE -Description "New-Description" -NumberOfVersionsRetention 10
```

Updates description and version retention on SAFE using Gen2 API

Minimum required version 12.2

### EXAMPLE 2
```
Get-PASSafe -SafeName SAFE | Set-PASSafe -SafeName SAFE -NumberOfVersionsRetention 10
```

Updates version retention on SAFE using Gen2 API, maintaining all other properties.

Minimum required version 12.2

### EXAMPLE 3
```
Set-PASSafe -SafeName SAFE -Description "New-Description" -NumberOfDaysRetention 10 -UseGen1API
```

Updates description and number of days retention on SAFE using Gen1 API

## PARAMETERS

### -SafeName
The name of the safe to update.
- Max Length 28 characters.
- Cannot start with a space.
- Cannot contain: '\','/',':','*','\<','\>','"','.' or '|'

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
- Max Length 28 characters.
- Cannot start with a space.
- Cannot contain: '\','/',':','*','\<','\>','"','.' or '|'

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
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -NumberOfVersionsRetention
The number of retained versions of every password that is stored in the Safe.
- Max value = 999
Specify either this parameter or NumberOfDaysRetention.

```yaml
Type: Int32
Parameter Sets: Gen2-NumberOfVersionsRetention, Gen1-NumberOfVersionsRetention
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -NumberOfDaysRetention
The number of days for which password versions are saved in the Safe.

- Minimum Value: 0
- Maximum Value: 3650
Specify either this parameter or NumberOfVersionsRetention

```yaml
Type: Int32
Parameter Sets: Gen2-NumberOfDaysRetention, Gen1-NumberOfDaysRetention
Aliases:

Required: False
Position: Named
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

### -location
The vault location to set for the safe

Minimum required version 12.2

```yaml
Type: String
Parameter Sets: Gen2-NumberOfDaysRetention, Gen2-NumberOfVersionsRetention
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UseGen1API
Specify to force usage the Gen1 API endpoint.

Should be specified for versions earlier than 12.2

```yaml
Type: SwitchParameter
Parameter Sets: Gen1-NumberOfVersionsRetention, Gen1-NumberOfDaysRetention
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

[https://pspas.pspete.dev/commands/Set-PASSafe](https://pspas.pspete.dev/commands/Set-PASSafe)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Update%20Safe.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Update%20Safe.htm)
