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

### Gen2 (Default)
```
Get-PASSafe [-search <String>] [-sort <String>] [-includeAccounts <Boolean>] [-extendedDetails <Boolean>]
 [-TimeoutSec <Int32>] [<CommonParameters>]
```

### Gen1-byName
```
Get-PASSafe [-SafeName <String>] [-TimeoutSec <Int32>] [<CommonParameters>]
```

### Gen1-byQuery
```
Get-PASSafe [-query <String>] [-TimeoutSec <Int32>] [<CommonParameters>]
```

### Gen1-byAll
```
Get-PASSafe [-FindAll] [-TimeoutSec <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Gets safe by SafeName, by search query string, or, by default will return all safes.

## EXAMPLES

### EXAMPLE 1
```
Get-PASSafe
```

Returns details of all safes.

### EXAMPLE 2
```
Get-PASSafe -search SAFE1 -extendedDetails $false
```

Returns names of safes matching pattern "Safe1"

### EXAMPLE 3
```
Get-PASSafe -SafeName SAFE1
```

Returns details of "Safe1" using Gen1 API.
Depreciated from version 12.2

### EXAMPLE 4
```
Get-PASSafe -query SAFE1
```

Returns details of safes matching query "Safe1" using Gen1 API.
Depreciated from version 12.2

### EXAMPLE 5
```
Get-PASSafe -FindAll
```

Returns details of all safes using Gen1 API.
Depreciated from version 12.2

## PARAMETERS

### -includeAccounts
Whether or not to return accounts for each Safe as part of the response.

```yaml
Type: Boolean
Parameter Sets: Gen2
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -search
Searches according to the Safe name.

```yaml
Type: String
Parameter Sets: Gen2
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -sort
Sorts according to the safeName property in ascending order (default) or descending order.

```yaml
Type: String
Parameter Sets: Gen2
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -extendedDetails
Whether or not to return all Safe details or only safeName as part of the response.
Supported from version 12.1

```yaml
Type: Boolean
Parameter Sets: Gen2
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SafeName
The name of a specific safe to get details of using Gen1 API.
Depreciated from version 12.2

```yaml
Type: String
Parameter Sets: Gen1-byName
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -query
Query String for safe search in the vault using Gen1 API.
Depreciated from version 12.2

```yaml
Type: String
Parameter Sets: Gen1-byQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FindAll
Specify to find all safes using Gen1 API.
If SafeName or query are not specified, FindAll is the default behaviour.
Depreciated from version 12.2

```yaml
Type: SwitchParameter
Parameter Sets: Gen1-byAll
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

