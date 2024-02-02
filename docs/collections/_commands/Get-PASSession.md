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
- BaseURI: URL value used for sending requests to the API.
- ExternalVersion: PAS version information.
- Websession: Contains Authorization Header, Cookie & Certificate data related to the current session.

The session information can be saved a variable accessible outside of the module scope for use in requests outside of psPAS.

## EXAMPLES

### EXAMPLE 1
```
Get-PASSession
```

Show current session related information

### EXAMPLE 2
```
$session = Get-PASSession
```

Save current session related information

### EXAMPLE 3
```
$session = Get-PASSession

Invoke-RestMethod -Method GET -Uri "$session.BaseURI/SomePath" -WebSession $session.WebSession
```

Use session information for Invoke-RestMethod command

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASSession](https://pspas.pspete.dev/commands/Get-PASSession)

[https://pspas.pspete.dev/docs/api-sessions/](https://pspas.pspete.dev/docs/api-sessions/)
