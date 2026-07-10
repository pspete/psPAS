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
Resume-PASCPMAutoManagement [-Accountid] <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
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

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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