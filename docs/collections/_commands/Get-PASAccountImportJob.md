---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASAccountImportJob
schema: 2.0.0
title: Get-PASAccountImportJob
---

# Get-PASAccountImportJob

## SYNOPSIS
Gets the status of bulk account upload jobs performed by the user.

## SYNTAX

```
Get-PASAccountImportJob [-id <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns the result of all bulk account upload jobs, or an individual job identified by it's ID.

Once the upload has finished, the API returns the result.

The result contains a list of all the accounts that succeeded or failed to upload.

## EXAMPLES

### EXAMPLE 1
```
Get-PASAccountImportJob
```

Returns status details of user's account upload jobs

### EXAMPLE 2
```
Get-PASAccountImportJob -id 4
```

Returns status details of user's account upload job with id of 4

## PARAMETERS

### -id
The identifier for the bulk account upload.

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

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASAccountImportJob](https://pspas.pspete.dev/commands/Get-PASAccountImportJob)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Get-all-bulk-account-uploads-for-user-v10.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Get-all-bulk-account-uploads-for-user-v10.htm)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Get-bulk-account-upload-result-v10.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Get-bulk-account-upload-result-v10.htm)
