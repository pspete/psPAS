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

### GetAllScanDefinitions (Default)
```
Get-PASDiscoveryScanDefinition [-search <String>] [-sort <String>] [-sortDirection <String>] [-type <String>]
 [-recurrenceType <String>] [-lastInstanceStatus <String>] [-extendedDetails <Boolean>] [<CommonParameters>]
```

### byID
```
Get-PASDiscoveryScanDefinition -id <String> [<CommonParameters>]
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

Property to sort the returned list of scan definitions by.

Valid values are creationTime, updateTime, name, type & recurrenceType.

lastInstanceStatus & lastInstanceCreationTime are also valid values, but only when extendedDetails is set to $true.

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

### -sortDirection

Direction to sort the returned list of scan definitions by, when used with the sort parameter.

Valid values are asc & desc. Defaults to asc if sort is specified but sortDirection is not.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASDiscoveryScanDefinition](https://pspas.pspete.dev/commands/Get-PASDiscoveryScanDefinition)

[https://docs.cyberark.com/identity-protection-space/latest/en/content/discovery/discovery-apis/discovery-getscandefinitionid.htm](https://docs.cyberark.com/identity-protection-space/latest/en/content/discovery/discovery-apis/discovery-getscandefinitionid.htm)

[https://docs.cyberark.com/identity-protection-space/latest/en/content/discovery/discovery-apis/discovery-getallscandefinitions.htm](https://docs.cyberark.com/identity-protection-space/latest/en/content/discovery/discovery-apis/discovery-getallscandefinitions.htm)
