---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Use-PASSession
schema: 2.0.0
title: Use-PASSession
---

# Use-PASSession

## SYNOPSIS
Sets module scope variables allowing saved session information to be used for future requests.

## SYNTAX

```
Use-PASSession [-Session] <Object> [<CommonParameters>]
```

## DESCRIPTION
Use session data (BaseURI, ExternalVersion, WebSession (containing Authorization Header)) for future requests.

psPAS uses variables in the Module scope to provide required values to all module functions, use this function to
set the required values in the module scope, using session information returned from \`Get-PASSession\`.

## EXAMPLES

### EXAMPLE 1
```
Use Saved Session Data for future requests
```

Use-PASSession -Session $Session

### EXAMPLE 2
```
Save current session, switch to using different session details, switch back to original session.
```

$CurrentSession = Get-PASSession

Use-PASSession -Session $OtherSession
...
Use-PASSession -Session $CurrentSession

## PARAMETERS

### -Session
An object containing psPAS session data, as returned from Get-PASSession

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Use-PASSession](https://pspas.pspete.dev/commands/Use-PASSession)

[https://pspas.pspete.dev/docs/api-sessions/](https://pspas.pspete.dev/docs/api-sessions/)