---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASDiscoveryScanDefinition
schema: 2.0.0
title: Get-PASDiscoveryScanDefinition
---

# Get-PASDiscoveryScanDefinition

## SYNOPSIS

Get scan definitions and their details.

## SYNTAX

### byID
```
Get-PASDiscoveryScanDefinition -id <String> [<CommonParameters>]
```

### GetAllScanDefinitions
```
Get-PASDiscoveryScanDefinition [-search <String>] [-sort <String>] [-type <String>] [-recurrenceType <String>]
 [-lastInstanceStatus <String>] [-extendedDetails <Boolean>] [<CommonParameters>]
```

## DESCRIPTION

Get scan definitions and their details.

## EXAMPLES

### Example 1

```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -id

the id of the scan definition to retrieve

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

scan definition search term

```yaml
Type: String
Parameter Sets: GetAllScanDefinitions
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -sort

result sort instruction

```yaml
Type: String
Parameter Sets: GetAllScanDefinitions
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -type

scan definition type

```yaml
Type: String
Parameter Sets: GetAllScanDefinitions
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -recurrenceType

scan definition recurrenceType

```yaml
Type: String
Parameter Sets: GetAllScanDefinitions
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -lastInstanceStatus

scan definition lastInstanceStatus

```yaml
Type: String
Parameter Sets: GetAllScanDefinitions
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -extendedDetails

whether or not to return extendedDetails of scan definition

```yaml
Type: Boolean
Parameter Sets: GetAllScanDefinitions
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASDiscoveryScanDefinition](https://pspas.pspete.dev/commands/Get-PASDiscoveryScanDefinition)

[https://docs.cyberark.com/identity-protection-space/latest/en/content/discovery/discovery-apis/discovery-getscandefinitionid.htm](https://docs.cyberark.com/identity-protection-space/latest/en/content/discovery/discovery-apis/discovery-getscandefinitionid.htm)

[https://docs.cyberark.com/identity-protection-space/latest/en/content/discovery/discovery-apis/discovery-getallscandefinitions.htm](https://docs.cyberark.com/identity-protection-space/latest/en/content/discovery/discovery-apis/discovery-getallscandefinitions.htm)
