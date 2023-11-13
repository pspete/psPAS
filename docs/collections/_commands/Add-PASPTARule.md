---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Add-PASPTARule
schema: 2.0.0
title: Add-PASPTARule
---

# Add-PASPTARule

## SYNOPSIS
Adds a new Risky Activity rule to PTA

## SYNTAX

```
Add-PASPTARule [-category] <String> [-regex] <String> [-score] <Int32> [-description] <String>
 [-response] <String> [-active] <Boolean> [-vaultUsersMode <String>] [-vaultUsersList <String[]>]
 [-machinesMode <String>] [-machinesList <String[]>] [<CommonParameters>]
```

## DESCRIPTION
Adds a new Risky Activity rule in the PTA server configuration.

## EXAMPLES

### EXAMPLE 1
```
Add-PASPTARule -category KEYSTROKES -regex '(*.)risky command(.*)' -score 60 -description "Example Rule" -response NONE -active $true
```

### EXAMPLE 2
```
Add-PASPTARule -category KEYSTROKES -regex '(*.)risky command(.*)' -score 60 -description "Example Rule" -response NONE -active $true -vaultUsersMode EXCLUDE -vaultUsersList UserA,UserB,UserC -machinesMode INCLUDE Computer1,Computer2,Computer3
```

Adds a new rule to PTA, scoped to exclude listed users, and include listed machines

## PARAMETERS

### -category
The Category of the risky activity

Valid values: SSH, WINDOWS, SCP, KEYSTROKES or SQL

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -regex
Risky activity in regex form.

Must support all characters (including "/" and escaping characters)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -score
Activity score.

Number must be between 1 and 100

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

### -description
Activity description.

The field is mandatory but can be empty

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

### -response
Automatic response to be executed

Valid Values: NONE, TERMINATE or SUSPEND

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -active
Indicate if the rule should be active or disabled

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: True
Position: 6
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -machinesList
List of machines to be included or excluded for detection

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -machinesMode
Indicates whether the list of machines will be processed for Suspicious Activity detection
Valid values:
- INCLUDE
  - Only machines on the list will be processed for detection
- EXCLUDE
  - Machines on the list will not be processed for detection

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

### -vaultUsersList
List of accounts to be included or excluded for detection

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -vaultUsersMode
Indicates whether the list of accounts will be processed for Suspicious Activity detection
Valid values:
- INCLUDE
  - Only accounts on the list will be processed for detection
- EXCLUDE
  - Accounts on the list will not be processed for detection

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Minimum Version CyberArk 10.4

## RELATED LINKS

[https://pspas.pspete.dev/commands/Add-PASPTARule](https://pspas.pspete.dev/commands/Add-PASPTARule)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/AddNewRule.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/AddNewRule.htm)
