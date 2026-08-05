---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Resume-PASCPMAutoManagement
schema: 2.0.0
title: Resume-PASCPMAutoManagement
---

# Resume-PASCPMAutoManagement

## SYNOPSIS
Resumes CPM auto management for one or more accounts.

## SYNTAX

```
Resume-PASCPMAutoManagement [-Accountid] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Resumes automatic password management by the CPM for one or more accounts whose management was previously suspended.

When more than one value is supplied for `-Accountid`, a bulk resume request is sent.

Requires CyberArk Self-Hosted version 15.2 or higher.

## EXAMPLES

### Example 1
```powershell
Resume-PASCPMAutoManagement -Accountid 123_4
```

Resumes CPM auto management for account with id 123_4.

### Example 2
```powershell
Get-PASAccount -id 123_4 | Resume-PASCPMAutoManagement
```

Resumes CPM auto management for the account returned by Get-PASAccount.

### Example 3
```powershell
Resume-PASCPMAutoManagement -Accountid 123_4, 125_6
```

Resumes CPM auto management for accounts 123_4 and 125_6 in a single bulk request.

## PARAMETERS

### -Accountid
The unique id of the account(s) to resume CPM auto management for.

When more than one value is supplied, a bulk resume request is sent.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: id

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/resume-account-bulk.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/resume-account-bulk.htm)