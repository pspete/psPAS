---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Set-PASDiscoveredLocalAccount
schema: 2.0.0
title: Set-PASDiscoveredLocalAccount
---

# Set-PASDiscoveredLocalAccount

## SYNOPSIS
Edits properties of a discovered local account.

## SYNTAX

```
Set-PASDiscoveredLocalAccount [-id] <String> [[-customProperties] <Hashtable>] [[-tags] <String[]>]
 [[-isPrivileged] <Boolean>] [[-applyRules] <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Edits properties of an account in the Discovered Accounts list. Only customProperties, tags and isPrivileged can be updated.

Requires one of the following roles:
- Privilege Cloud Administrator
- Privilege Cloud Administrator Basic
- Privilege Cloud Administrator Lite

## EXAMPLES

### EXAMPLE 1
```powershell
Set-PASDiscoveredLocalAccount -id 54507db1-66d7-4dc7-93cf-a310cc19b9fc -isPrivileged $true
```

Marks the specified discovered account as privileged.

### EXAMPLE 2
```powershell
Set-PASDiscoveredLocalAccount -id 54507db1-66d7-4dc7-93cf-a310cc19b9fc -tags 'tag1', 'tag2' -applyRules $true
```

Sets tags on the specified discovered account and applies remediation rules to it.

## PARAMETERS

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

### -applyRules
Whether to apply remediation rules on the edited account.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -customProperties
User-defined properties to be combined with the existing custom properties of the discovered account. New properties are added, existing custom property values are overridden, and properties can be removed by not sending them again.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -id
The unique identifier of the discovered account.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -isPrivileged
Whether the user is privileged on the target.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -tags
A list of tags to associate with the discovered account.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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

[https://pspas.pspete.dev/commands/Set-PASDiscoveredLocalAccount](https://pspas.pspete.dev/commands/Set-PASDiscoveredLocalAccount)

[https://docs.cyberark.com/manage/latest/en/content/discovery/discovery-apis/discovery-editaccountproperties.htm](https://docs.cyberark.com/manage/latest/en/content/discovery/discovery-apis/discovery-editaccountproperties.htm)
