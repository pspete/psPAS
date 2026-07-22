---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASMasterPolicy
schema: 2.0.0
title: Get-PASMasterPolicy
---

# Get-PASMasterPolicy

## SYNOPSIS
Retrieves Master Policy details

## SYNTAX

```
Get-PASMasterPolicy [-PolicyId <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Retrieves Master Policy details

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-PASMasterPolicy
```

Outputs all Master Policy details.
Policy ID 1 is the main Master Policy

### Example 2
```powershell
PS C:\> Get-PASMasterPolicy -PolicyId 2
```

Outputs all Master Policy details for platform with id 2

## PARAMETERS

### -PolicyId
The ID of the policy to retrieve.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 1
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASMasterPolicy](https://pspas.pspete.dev/commands/Get-PASMasterPolicy)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/get-policy-by-id.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/get-policy-by-id.htm)