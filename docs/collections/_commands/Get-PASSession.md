---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASSession
schema: 2.0.0
title: Get-PASSession
---

# Get-PASSession

## SYNOPSIS
Returns information related to the authenticated session

## SYNTAX

```
Get-PASSession [<CommonParameters>]
```

## DESCRIPTION
For the current session, returns data from the module scope:
- Username relating to the session.
- BaseURI: URL value used for sending requests to the API.
- ExternalVersion: PAS version information.
- Websession: Contains Authorization Header, Cookie & Certificate data related to the current session.

The session information can be saved a variable accessible outside of the module scope for use in requests outside of psPAS.

## EXAMPLES

### EXAMPLE 1
```
Show current session related information
```

Get-PASSession

### EXAMPLE 2
```
Save current session related information
```

$session = Get-PASSession

### EXAMPLE 3
```
Use session information for Invoke-RestMethod command
```

$session = Get-PASSession

Invoke-RestMethod
Invoke-RestMethod -Method GET -Uri "$session.BaseURI/SomePath" -WebSession $session.WebSession

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASSession](https://pspas.pspete.dev/commands/Get-PASSession)

