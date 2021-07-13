---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASApplication
schema: 2.0.0
title: Get-PASApplication
---

# Get-PASApplication

## SYNOPSIS
Returns details of applications in the Vault

## SYNTAX

### byQuery (Default)
```
Get-PASApplication [-AppID <String>] [-Location <String>] [-IncludeSublocations <Boolean>] [<CommonParameters>]
```

### byAppID
```
Get-PASApplication -AppID <String> [-ExactMatch] [<CommonParameters>]
```

## DESCRIPTION
Returns information on Applications from the Vault.

Results can be filtered by specifying additional parameters.

Applications can be found by name, or searched for.

Audit Users permission is required.

## EXAMPLES

### EXAMPLE 1
```
Get-PASApplication
```

Returns information on all defined applications

### EXAMPLE 2
```
Get-PASApplication NewApp -ExactMatch
```

Gets details of the application "NewApp"

### EXAMPLE 3
```
Get-PASApplication NewApp
```

Gets details of all application matching "NewApp"

## PARAMETERS

### -AppID
Application Name

```yaml
Type: String
Parameter Sets: byQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: byAppID
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ExactMatch
By Default, the function will search the vault.

All found applications (based on parameters supplied) will be returned.

When Specifying this parameter, the function will not search;
data for the supplied AppID will be returned.

```yaml
Type: SwitchParameter
Parameter Sets: byAppID
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Location
Location of the application in the Vault hierarchy.

Default=\

```yaml
Type: String
Parameter Sets: byQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -IncludeSublocations
Will search be carried out in sublocations of specified location?

```yaml
Type: Boolean
Parameter Sets: byQuery
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

[https://pspas.pspete.dev/commands/Get-PASApplication](https://pspas.pspete.dev/commands/Get-PASApplication)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/List%20Applications.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/List%20Applications.htm)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/List%20a%20Specific%20Application.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/List%20a%20Specific%20Application.htm)
