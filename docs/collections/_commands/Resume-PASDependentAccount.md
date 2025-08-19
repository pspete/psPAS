---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Resume-PASDependentAccount
schema: 2.0.0
title: Resume-PASDependentAccount
---

# Resume-PASDependentAccount

## SYNOPSIS
This resumes automatic management of a dependent account by the CPM.

## SYNTAX

```
Resume-PASDependentAccount [-AccountID] <String> [-dependentAccountId] <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Resumes automatic management of a dependent account by the Central Password Manager (CPM). 

Requires CyberArk version 14.6 or later.

## EXAMPLES

### Example 1
```powershell
PS C:\> Resume-PASDependentAccount -AccountID "123_456" -dependentAccountId "22_2"
```

Resumes automatic CPM management for the dependent account with ID "789_012" that is 
associated with the main account "123_456".

### Example 2
```powershell
PS C:\> Get-PASAccount -id "123_456" | Resume-PASDependentAccount -dependentAccountId "22_2"
```

Uses pipeline input to resume automatic management of dependent account "789_012" for 
the main account retrieved by Get-PASAccount.

## PARAMETERS

### -AccountID
The unique ID of the main privileged account that has the dependent account associated with it.
This parameter accepts pipeline input and can be aliased as 'id'.

```yaml
Type: String
Parameter Sets: (All)
Aliases: id

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -dependentAccountId
The unique ID of the dependent account for which automatic CPM management should be resumed.
This parameter accepts pipeline input and can be aliased as 'dependentid'.

```yaml
Type: String
Parameter Sets: (All)
Aliases: dependentid

Required: True
Position: 2
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

## OUTPUTS

## NOTES

## RELATED LINKS
