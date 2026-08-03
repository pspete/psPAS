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
- IdleTimeout: The idle session timeout, in minutes, retrieved from the server at logon.
- SessionTimeRemaining: The estimated time remaining, as a TimeSpan, before the session idle-times out,
  calculated from IdleTimeout and the time of the most recent request (or logon time, if no request
  has been sent yet). Null if IdleTimeout could not be retrieved at logon.
- SessionWarningThreshold: The number of minutes of SessionTimeRemaining at or below which psPAS
  writes a warning, on subsequent commands, that the session is close to idle-timing out. Defaults
  to 5, and can be changed by setting the value directly (e.g. `(Get-PASSession).SessionWarningThreshold = 10`).

The returned object also exposes two methods:
- GetRemainingSessionTime(): Returns a live, freshly-calculated SessionTimeRemaining TimeSpan, rather
  than the value captured at the time Get-PASSession was called.
- Refresh(): Sends a request (via Get-PASLoggedOnUser) to reset the server-side idle timer - the same
  effect as selecting "stay logged in" in the PVWA - and returns the refreshed SessionTimeRemaining.

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

### EXAMPLE 4
```
(Get-PASSession).GetRemainingSessionTime()
```

Returns a live TimeSpan indicating how much longer the session has before it idle-times out

### EXAMPLE 5
```
(Get-PASSession).Refresh()
```

Resets the idle timer for the current session, extending it, and returns the refreshed time remaining

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASSession](https://pspas.pspete.dev/commands/Get-PASSession)

[https://pspas.pspete.dev/docs/api-sessions/](https://pspas.pspete.dev/docs/api-sessions/)
