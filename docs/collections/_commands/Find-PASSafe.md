---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Find-PASSafe
schema: 2.0.0
title: Find-PASSafe
---

# Find-PASSafe

## SYNOPSIS
Returns safe list from the vault.

## SYNTAX

```
Find-PASSafe [[-search] <String>] [[-TimeoutSec] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Returns abbreviated details for all safes

## EXAMPLES

### EXAMPLE 1
```
Find-PASSafe
```

Returns details of all safes which the user has access to.

### EXAMPLE 2
```
Find-PASSafe -search "xyz abc"
```

Returns details of all matching safes which the user has access to.

## PARAMETERS

### -search
List of keywords, separated with a space.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
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
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
This API is largely undocumented, but appears to be available since V10
The documentation mentions no body parameters, but search/offset/limit/sort(NYI)/filter(NYI) seem to work
It returns results faster than the v9 API (invoked with Get-PASSafe) but has a vastly different return object
Recommended Use:  Use this to search for safes many quickly, then use Get-PASSafe to get full details about individual accounts

## RELATED LINKS

[https://pspas.pspete.dev/commands/Find-PASSafe](https://pspas.pspete.dev/commands/Find-PASSafe)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Safes%20Web%20Services%20-%20List%20Safes.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Safes%20Web%20Services%20-%20List%20Safes.htm)

