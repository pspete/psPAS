---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASRemediationRuleSet
schema: 2.0.0
title: Get-PASRemediationRuleSet
---

# Get-PASRemediationRuleSet

## SYNOPSIS

Get information about remediation rule sets

## SYNTAX

### byID
```
Get-PASRemediationRuleSet -id <String> [-TimeoutSec <Int32>] [<CommonParameters>]
```

### GetAllRemediationRuleSets
```
Get-PASRemediationRuleSet [-search <String>] [-sort <String>] [-limit <Int32>] [-TimeoutSec <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION

returns information about all the defined remediation rule sets or about a specific remediation rule set

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PASRemediationRuleSet -id 1234
```

Get the rule set with the specified ID

### Example 2

```powershell
PS C:\> Get-PASRemediationRuleSet -search someword -sort "name - asc" -limit 10
```

Get the rule sets matching the search

## PARAMETERS

### -id

The id of a rule set

```yaml
Type: String
Parameter Sets: byID
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -search

a search term for the rule set

```yaml
Type: String
Parameter Sets: GetAllRemediationRuleSets
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -sort

Sort by properties asc or desc:

- id
- name
- status
- rulesCount
- actionsPerformed
- lasModificationTime

```yaml
Type: String
Parameter Sets: GetAllRemediationRuleSets
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -limit

The page size for the returned results

```yaml
Type: Int32
Parameter Sets: GetAllRemediationRuleSets
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TimeoutSec

Invoke-WebRequest timeout value

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASRemediationRuleSet](https://pspas.pspete.dev/commands/Get-PASRemediationRuleSet)

[https://docs.cyberark.com/identity-protection-space/latest/en/content/discovery/discovery-apis/discoveryruleset-getall.htm](https://docs.cyberark.com/identity-protection-space/latest/en/content/discovery/discovery-apis/discoveryruleset-getall.htm)

[https://docs.cyberark.com/identity-protection-space/latest/en/content/discovery/discovery-apis/discoveryruleset-get.htm](https://docs.cyberark.com/identity-protection-space/latest/en/content/discovery/discovery-apis/discoveryruleset-get.htm)
