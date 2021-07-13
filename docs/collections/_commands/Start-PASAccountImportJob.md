---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Start-PASAccountImportJob
schema: 2.0.0
title: Start-PASAccountImportJob
---

# Start-PASAccountImportJob

## SYNOPSIS
Add multiple accounts to existing Safes.

## SYNTAX

```
Start-PASAccountImportJob [[-source] <String>] [-accountsList] <Object[]> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Sends a list of accounts to be added to existing safes.

Must be authenticated with a user who has Add accounts, Update account content, and Update account properties authorization in at least one Safe.

Returns bulk account upload id or status.

## EXAMPLES

### EXAMPLE 1
```
$Accounts = @(

New-PASAccountObject -uploadIndex 1 -userName SomeAccount1 -address domain.com -platformID WinDomain -SafeName SomeSafe
	New-PASAccountObject -uploadIndex 2 -userName SomeAccount2 -address domain.com -platformID WinDomain -SafeName SomeSafe
	New-PASAccountObject -uploadIndex 3 -userName SomeAccount3 -address domain.com -platformID WinDomain -SafeName SomeSafe
	New-PASAccountObject -uploadIndex 4 -userName SomeAccount4 -address domain.com -platformID WinDomain -SafeName SomeSafe
)

Start-PASAccountImportJob -source "SomeSource" -accountsList $Accounts
```

Create & send list of accounts to be added as a bulk operation.

## PARAMETERS

### -source
Free text that describes the source of the bulk account upload.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -accountsList
List of account objects.
Each account object contains the parameters for that account.
New-PASAccountObject creates Account Objects with the expected properties.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

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

[https://pspas.pspete.dev/commands/Start-PASAccountImportJob](https://pspas.pspete.dev/commands/Start-PASAccountImportJob)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Create-bulk-upload-of-accounts-v10.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Create-bulk-upload-of-accounts-v10.htm)
