---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Add-PASPendingAccount
schema: 2.0.0
title: Add-PASPersonalAdminAccount
---

# Add-PASPersonalAdminAccount

## SYNOPSIS
Adds a personal privileged account in Privilege Cloud.

## SYNTAX

```
Add-PASPersonalAdminAccount [-address] <String> [-userName] <String> [-secret] <SecureString>
 [<CommonParameters>]
```

## DESCRIPTION
Privilege Cloud Only.

Add personal privileged account for individual use and store in private dedicated Safe.

This capability is currently in Beta phase and will be undergoing future changes and expansion.

## EXAMPLES

### EXAMPLE 1
```powershell
Add-PASPersonalAdminAccount -address somedomain -userName someUser -secret $SomePassword
```

Adds Personal Admin Account to private dedicated Safe.

## PARAMETERS

### -address
The name or address of the machine where the account will be used. Valid values: DNS/IP/URL where the account is managed.

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

### -userName
Account user's name.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -secret
Account password as SecureString

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
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

[https://pspas.pspete.dev/commands/Add-PASPersonalAdminAccount](https://pspas.pspete.dev/commands/Add-PASPersonalAdminAccount)
