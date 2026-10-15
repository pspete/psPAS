---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Remove-PASRemediationRuleSet
schema: 2.0.0
title: Remove-PASRemediationRuleSet
---

# Remove-PASRemediationRuleSet

## SYNOPSIS

Delete a remediation rule set

## SYNTAX

```
Remove-PASRemediationRuleSet [-id] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Delete a remediation rule set

## EXAMPLES

### Example 1

```powershell
PS C:\> Remove-PASRemediationRuleSet -id 1234
```

Delete the rule set with the specified ID

## PARAMETERS

### -id

the id of the rule set to delete

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

[https://pspas.pspete.dev/commands/Remove-PASRemediationRuleSet](https://pspas.pspete.dev/commands/Remove-PASRemediationRuleSet)

[https://docs.cyberark.com/identity-protection-space/latest/en/content/discovery/discovery-apis/discoveryruleset-delete.htm](https://docs.cyberark.com/identity-protection-space/latest/en/content/discovery/discovery-apis/discoveryruleset-delete.htm)
