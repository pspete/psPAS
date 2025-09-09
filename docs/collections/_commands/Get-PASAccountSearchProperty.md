---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASAccountSearchProperty
schema: 2.0.0
---

# Get-PASAccountSearchProperty

## SYNOPSIS
Return a list of available search properties

## SYNTAX

```
Get-PASAccountSearchProperty [<CommonParameters>]
```

## DESCRIPTION
Returns a list of all the properties that are included in the search filter when searching for an account.

The list is created from the list of parameters in Options > Search Properties

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-PASAccountSearchProperty
```

Returns valid search properties and any valid operators which can be used

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASAccountSearchProperty](https://pspas.pspete.dev/commands/Get-PASAccountSearchProperty)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/get-advanced-search-properties.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/get-advanced-search-properties.htm)