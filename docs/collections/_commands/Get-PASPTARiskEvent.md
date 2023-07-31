---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASPTARiskEvent
schema: 2.0.0
---

# Get-PASPTARiskEvent

## SYNOPSIS
Output all PTA Risk Events

## SYNTAX

```
Get-PASPTARiskEvent [[-type] <String>] [[-status] <String>] [[-sort] <String>] [[-page] <Int32>]
 [[-size] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Output details of all PTA Risk Events, or those matching the criteria specified.

Requires minimum version of 13.2

## EXAMPLES

### Example 1
```powershell
Get-PASPTARiskEvent -type RISK_UNCONSTRAINED_DELEGATION -status OPEN
```

Get all open risk events related to unconstrained delegation.

## PARAMETERS

### -type
Return only the risk events of a specific type, using the type name

Valid values:

RISK_UNCONSTRAINED_DELEGATION

RISK_RISKY_SPN

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -status
Return only open or closed risk events

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

### -sort
Sort the events you are searching for

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

### -page
The page number, starting with 0

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

### -size
The maximum number of returned events in a given page.

If not specified, the server limits the results to 100.

The maximum number that can be specified is 1000.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASPTARiskEvent](https://pspas.pspete.dev/commands/Get-PASPTARiskEvent)

[https://docs.cyberark.com/PAS/Latest/en/Content/WebServices/GetRiskEvents.htm](https://docs.cyberark.com/PAS/Latest/en/Content/WebServices/GetRiskEvents.htm)
