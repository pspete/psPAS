---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Set-PASPTARule
schema: 2.0.0
title: Set-PASPTARule
---

# Set-PASPTARule

## SYNOPSIS
Updates an existing Risky Activity rule to PTA

## SYNTAX

```
Set-PASPTARule [-id] <String> [[-category] <String>] [[-regex] <String>] [[-score] <Int32>]
 [[-description] <String>] [[-response] <String>] [[-active] <Boolean>] [-vaultUsersMode <String>]
 [-vaultUsersList <String[]>] [-machinesMode <String>] [-machinesList <String[]>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Updates an existing Risky Activity rule in the PTA server configuration.

## EXAMPLES

### EXAMPLE 1
```
Set-PASPTARule -id 66 -category KEYSTROKES -regex '(*.)risky cmd(.*)' -score 65 -description "Updated Rule" -response SUSPEND -active $true
```

Updates rule 66 in PTA

### EXAMPLE 2
```
Set-PASPTARule -id 66 -category KEYSTROKES -regex '(*.)risky cmd(.*)' -score 65 -description "Updated Rule" -response SUSPEND -active $true -vaultUsersList UserA,UserB,UserC -machinesMode INCLUDE Computer1,Computer2,Computer3
```

Updates rule 66 in PTA, scoped to exclude listed users, and include listed machines

## PARAMETERS

### -id
The unique ID of the rule.

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

### -category
The Category of the risky activity
- Valid values: SSH, WINDOWS, SCP, KEYSTROKES or SQL

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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

Required: False
Position: 3
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

Required: False
Position: 4
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

Required: False
Position: 5
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

Required: False
Position: 6
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

Required: False
Position: 7
Default value: False
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

[https://pspas.pspete.dev/commands/Set-PASPTARule](https://pspas.pspete.dev/commands/Set-PASPTARule)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/UpdateRule.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/UpdateRule.htm)
