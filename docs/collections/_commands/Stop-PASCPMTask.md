---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Stop-PASCPMTask
schema: 2.0.0
title: Stop-PASCPMTask
---

# Stop-PASCPMTask

## SYNOPSIS
Cancels a pending CPM task for one or more accounts.

## SYNTAX

```
Stop-PASCPMTask [-Accountid] <String[]> [-dependentAccountid <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Cancels an in-progress or pending CPM operation (such as a change, verify or reconcile task) for a specific account.

Multiple accounts can be processed in a single bulk request by supplying more than one value for `-Accountid`.

Requires CyberArk Self-Hosted version 15.2 or higher.

## EXAMPLES

### Example 1
```powershell
PS C:\> Stop-PASCPMTask -Accountid 123_4
```

Cancels the pending CPM task for account with id 123_4.

### Example 2
```powershell
PS C:\> Stop-PASCPMTask -Accountid 123_4, 567_8
```

Cancels the pending CPM tasks for accounts 123_4 and 567_8 in a single bulk request.

## PARAMETERS

### -Accountid
The unique id of the account to cancel the pending CPM task for.

When more than one value is supplied, a bulk cancel request is sent.

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

### -WhatIf
Shows what would happen if the cmdlet runs. The cmdlet is not run.

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

### -dependentAccountid
{{ Fill dependentAccountid Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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

Bulk operations are sent when `-Accountid` contains more than one value.

Requires CyberArk Self-Hosted version 15.2 or higher.

## RELATED LINKS

[https://pspas.pspete.dev/commands/Stop-PASCPMTask](https://pspas.pspete.dev/commands/Stop-PASCPMTask)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/cancel-account-task.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/cancel-account-task.htm)