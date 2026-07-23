---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASDiscoveryScanLog
schema: 2.0.0
title: Get-PASDiscoveryScanLog
---

# Get-PASDiscoveryScanLog

## SYNOPSIS

Get scan instance logs URL

## SYNTAX

```
Get-PASDiscoveryScanLog [-id] <String> [<CommonParameters>]
```

## DESCRIPTION

returns the signed URL from where you can download logs for a specific scan instance

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PASDiscoveryScanLog -id 1234
```

Get the logs URL of the specified scan instance

## PARAMETERS

### -id

The ID of the scan instance

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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

[https://pspas.pspete.dev/commands/Get-PASDiscoveryScanLog](https://pspas.pspete.dev/commands/Get-PASDiscoveryScanLog)

[https://docs.cyberark.com/identity-protection-space/latest/en/content/discovery/discovery-apis/discovery-downloadlogurl.htm](https://docs.cyberark.com/identity-protection-space/latest/en/content/discovery/discovery-apis/discovery-downloadlogurl.htm)
