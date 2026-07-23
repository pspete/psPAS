---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Start-PASDiscoveryScan
schema: 2.0.0
title: Start-PASDiscoveryScan
---

# Start-PASDiscoveryScan

## SYNOPSIS

Starts a discovery scan

## SYNTAX

```
Start-PASDiscoveryScan [-id] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Starts a discovery scan

## EXAMPLES

### Example 1

```powershell
PS C:\> Start-PASDiscoveryScan -id 1234
```

Starts the specified discovery scan

## PARAMETERS

### -id

the id of the discovery scan to start

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

[https://pspas.pspete.dev/commands/Start-PASDiscoveryScan](https://pspas.pspete.dev/commands/Start-PASDiscoveryScan)

[https://docs.cyberark.com/identity-protection-space/latest/en/content/discovery/discovery-apis/discovery-addnewscaninstance.htm](https://docs.cyberark.com/identity-protection-space/latest/en/content/discovery/discovery-apis/discovery-addnewscaninstance.htm)
