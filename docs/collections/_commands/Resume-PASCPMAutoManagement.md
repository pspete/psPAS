---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Resume-PASCPMAutoManagement
schema: 2.0.0
title: Resume-PASCPMAutoManagement
---

# Resume-PASCPMAutoManagement

## SYNOPSIS
Resumes CPM auto management for an account.

## SYNTAX

```
Resume-PASCPMAutoManagement [-Accountid] <String> [<CommonParameters>]
```

## DESCRIPTION
Resumes automatic password management by the CPM for a specific account whose management was previously suspended.

Requires CyberArk Self-Hosted version 15.2 or higher.

## EXAMPLES

### Example 1
```powershell
PS C:\> Resume-PASCPMAutoManagement -Accountid 123_4
```

Resumes CPM auto management for account with id 123_4.

### Example 2
```powershell
PS C:\> Get-PASAccount -id 123_4 | Resume-PASCPMAutoManagement
```

Resumes CPM auto management for the account returned by Get-PASAccount.

### Example 3
```powershell
PS C:\> '123_4', '125_6' | ForEach-Object { Resume-PASCPMAutoManagement -Accountid $_ }
```

Resumes CPM auto management for each of the specified accounts.

## PARAMETERS

### -Accountid
The unique id of the account to resume CPM auto management for.

```yaml
Type: String
Parameter Sets: (All)
Aliases: id

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Resume-PASCPMAutoManagement](https://pspas.pspete.dev/commands/Resume-PASCPMAutoManagement)