---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASDiscoveryScan
schema: 2.0.0
title: Get-PASDiscoveryScan
---

# Get-PASDiscoveryScan

## SYNOPSIS

Get scan details.

## SYNTAX

```
Get-PASDiscoveryScan [-id] <String> [<CommonParameters>]
```

## DESCRIPTION

get scan details

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PASDiscoveryScan -id 1234
```

get scan with ID

## PARAMETERS

### -id

the id of the scan to retrieve

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASDiscoveryScan](https://pspas.pspete.dev/commands/Get-PASDiscoveryScan)

[https://docs.cyberark.com/identity-protection-space/latest/en/content/discovery/discovery-apis/discovery-getscaninstance.htm](https://docs.cyberark.com/identity-protection-space/latest/en/content/discovery/discovery-apis/discovery-getscaninstance.htm)
