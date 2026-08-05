---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASLoggedOnUser
schema: 2.0.0
title: Get-PASLoggedOnUser
---

# Get-PASLoggedOnUser

## SYNOPSIS
Returns details of the logged on user

## SYNTAX

### Gen2 (Default)
```
Get-PASLoggedOnUser [<CommonParameters>]
```

### Gen1
```
Get-PASLoggedOnUser [-UseGen1API] [<CommonParameters>]
```

## DESCRIPTION
Returns information on the user who is logged in.

By default, uses the Gen2 `api/currentuser` endpoint, which works against both self-hosted and
Privilege Cloud/ISPSS shared-services implementations. This is the same request the PVWA sends
when a user selects "stay logged in" in response to the session timeout warning, so it can also
be used as a lightweight way to keep a session alive.

Specify `-UseGen1API` to use the legacy `WebServices/PIMServices.svc/User` endpoint instead. This
is only applicable to self-hosted implementations.

## EXAMPLES

### EXAMPLE 1
```
Get-PASLoggedOnUser
```

Returns information on the currently authenticated user.

### EXAMPLE 2
```
$user = Get-PASLoggedOnUser
```

Saves the details of the currently authenticated user in the $user variable.

### EXAMPLE 3
```
(Get-PASLoggedOnUser).UserName
```

Returns just the UserName property value of the currently authenticated user.

## PARAMETERS

### -UseGen1API
Use the legacy Gen1 `WebServices/PIMServices.svc/User` endpoint instead of the Gen2 `api/currentuser` endpoint.

Only applicable to self-hosted implementations.

```yaml
Type: SwitchParameter
Parameter Sets: Gen1
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASLoggedOnUser](https://pspas.pspete.dev/commands/Get-PASLoggedOnUser)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/User%20Web%20Services%20-%20Logged%20on%20User%20Details.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/User%20Web%20Services%20-%20Logged%20on%20User%20Details.htm)
