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

### NumberOfVersionsRetention (Default)
```
Add-PASSafe -SafeName <String> [-Description <String>] [-location <String>] [-OLACEnabled <Boolean>]
 [-ManagingCPM <String>] -NumberOfVersionsRetention <Int32> [-AutoPurgeEnabled <Boolean>] [<CommonParameters>]
```

### Gen1-NumberOfVersionsRetention
```
Add-PASSafe -SafeName <String> [-Description <String>] [-location <String>] [-OLACEnabled <Boolean>]
 [-ManagingCPM <String>] -NumberOfVersionsRetention <Int32> [-UseGen1API] [<CommonParameters>]
```

### NumberOfDaysRetention
```
Add-PASSafe -SafeName <String> [-Description <String>] [-location <String>] [-OLACEnabled <Boolean>]
 [-ManagingCPM <String>] -NumberOfDaysRetention <Int32> [-AutoPurgeEnabled <Boolean>] [<CommonParameters>]
```

### Gen1-NumberOfDaysRetention
```
Add-PASSafe -SafeName <String> [-Description <String>] [-location <String>] [-OLACEnabled <Boolean>]
 [-ManagingCPM <String>] -NumberOfDaysRetention <Int32> [-UseGen1API] [<CommonParameters>]
```

## DESCRIPTION
Adds a new safe to the Vault.

The "Add Safes" permission is required in the vault.

Defaults to the Gen2 API which requires CyberArk version 12.0+.

For use against earlier versions the `-UseGen1API` switch must be specified to force use of the Gen1 API.

## EXAMPLES

### EXAMPLE 1
```
Add-PASSafe -SafeName Oracle -Description "Oracle Safe" -ManagingCPM PasswordManager -NumberOfVersionsRetention 7
```

Creates a new safe named Oracle with a 7 version retention.

Minimum required version 12.0

### EXAMPLE 2
```
Add-PASSafe -SafeName Dev_Team -Description "Dev Safe" -ManagingCPM DEV_CPM -NumberOfDaysRetention 7 -location "\Safes"
```

Creates a new safe named Dev_Team, assigned to CPM DEV_CPM, with a 7 day retention period, in the \Safes location.

Minimum required version 12.0

### EXAMPLE 3
```
Add-PASSafe -SafeName Oracle -Description "Oracle Safe" -ManagingCPM PasswordManager -NumberOfVersionsRetention 7 -UseGen1API
```

Creates a new safe named Oracle with a 7 version retention using the Gen1 API.

### EXAMPLE 4
```
Add-PASSafe -SafeName Dev_Team -Description "Dev Safe" -ManagingCPM DEV_CPM -NumberOfDaysRetention 7 -UseGen1API
```

Creates a new safe named Dev_Team, assigned to CPM DEV_CPM, with a 7 day retention period using the Gen1 API.

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
Parameter Sets: NumberOfVersionsRetention, Gen1-NumberOfVersionsRetention
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
Parameter Sets: NumberOfDaysRetention, Gen1-NumberOfDaysRetention
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AutoPurgeEnabled
Whether or not to automatically purge files after the end of the Object History Retention Period defined in the Safe properties.

Minimum required version 12.0

```yaml
Type: Boolean
Parameter Sets: NumberOfVersionsRetention, NumberOfDaysRetention
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -location
The location of the Safe in the Vault.

Minimum required version 12.0

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

### -UseGen1API
Force use of Gen1 API for request.

Should be specified for versions earlier than 12.0

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

[https://pspas.pspete.dev/commands/Add-PASSafe](https://pspas.pspete.dev/commands/Add-PASSafe)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add%20Safe.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add%20Safe.htm)
