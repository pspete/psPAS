---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASComponentDetail
schema: 2.0.0
title: Get-PASComponentDetail
---

# Get-PASComponentDetail

## SYNOPSIS
Returns details & health information about CyberArk component instances.

## SYNTAX

```
Get-PASComponentDetail [-ComponentID] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns details about specific components and all their installed instances,
as well as system health information for each one.

## EXAMPLES

### EXAMPLE 1
```
Get-PASComponentDetail -ComponentID CPM
```

Displays CPM Component information

### EXAMPLE 2
```
Get-PASComponentDetail -ComponentID PVWA
```

Displays PVWA Component information

### EXAMPLE 3
```
Get-PASComponentDetail -ComponentID SessionManagement
```

Displays PSM Component information

## PARAMETERS

### -ComponentID
Specify component type to return information on (PVWA, SessionManagement, CPM or AIM)

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
Requires minimum version of CyberArk 10.1.

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASComponentDetail](https://pspas.pspete.dev/commands/Get-PASComponentDetail)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/SystemDetails.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/SystemDetails.htm)
