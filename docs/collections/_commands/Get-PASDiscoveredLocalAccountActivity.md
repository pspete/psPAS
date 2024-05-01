---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASDiscoveredLocalAccountActivity
schema: 2.0.0
---

# Get-PASDiscoveredLocalAccountActivity

## SYNOPSIS
Get discovery rule activities of a discovered account

## SYNTAX

```
Get-PASDiscoveredLocalAccountActivity [-id] <String> [<CommonParameters>]
```

## DESCRIPTION
Get discovery rule activities of a discovered account

Applies to the accounts that are discovered by the EPM scanning of endpoints, including loosely connected devices:
- Windows loosely connected devices
- Mac loosely connected devices
- Linux loosely connected devices

Requires one of the following roles:
- Privilege Cloud Administrator
- Privilege Cloud Administrator Basic
- Privilege Cloud Administrator Lite

## EXAMPLES

### EXAMPLE 1
```powershell
Get-PASDiscoveredLocalAccountActivity -id SomeId
```

Get discovery rule activities for specified discovered account

## PARAMETERS

### -id
The unique id of the discovered account

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

[https://pspas.pspete.dev/commands/Get-PASDiscoveredLocalAccountActivity](https://pspas.pspete.dev/commands/Get-PASDiscoveredLocalAccountActivity)
