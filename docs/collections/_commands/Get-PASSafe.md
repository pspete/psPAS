---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASSafe
schema: 2.0.0
title: Get-PASSafe
---

# Get-PASSafe

## SYNOPSIS
Returns safe details from the vault.

## SYNTAX

### byAll (Default)
```
Get-PASSafe [-FindAll] [-TimeoutSec <Int32>] [<CommonParameters>]
```

### byName
```
Get-PASSafe [-SafeName <String>] [-TimeoutSec <Int32>] [<CommonParameters>]
```

### byQuery
```
Get-PASSafe [-query <String>] [-TimeoutSec <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Gets safe by SafeName, by search query string, or, by default will return all safes.

## EXAMPLES

### EXAMPLE 1
```
Get-PASSafe -SafeName SAFE1
```

Returns details of "Safe1"

## PARAMETERS

### -SafeName
The name of a specific safe to get details of.

```yaml
Type: String
Parameter Sets: byName
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -query
Query String for safe search in the vault

```yaml
Type: String
Parameter Sets: byQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FindAll
Specify to find all safes.
If SafeName or query are not specified, FindAll is the default behaviour.

```yaml
Type: SwitchParameter
Parameter Sets: byAll
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -TimeoutSec
See Invoke-WebRequest
Specify a timeout value in seconds

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

[https://pspas.pspete.dev/commands/Get-PASSafe](https://pspas.pspete.dev/commands/Get-PASSafe)

