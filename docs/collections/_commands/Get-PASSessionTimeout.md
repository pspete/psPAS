---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASSessionTimeout
schema: 2.0.0
title: Get-PASSessionTimeout
---

# Get-PASSessionTimeout

## SYNOPSIS
Returns the configured idle session timeout

## SYNTAX

```
Get-PASSessionTimeout [<CommonParameters>]
```

## DESCRIPTION
Returns the idle session timeout, in minutes, configured on the server.

This is the same request sent by the PVWA when a user authenticates, and is used to determine
how long a session can remain idle before it is automatically logged out.

Requires minimum version 13.2. Only applicable to Self-Hosted implementations.

`New-PASSession` calls this automatically at logon and stores the result in the `IdleTimeout`
property of the session, viewable with `Get-PASSession`. If called as part of the logon process
against an earlier version, or against Privilege Cloud/ISPSS, this fails silently - `IdleTimeout`
is simply left `$null`.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-PASSessionTimeout
```

Returns the configured idle session timeout, in minutes.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASSessionTimeout](https://pspas.pspete.dev/commands/Get-PASSessionTimeout)
