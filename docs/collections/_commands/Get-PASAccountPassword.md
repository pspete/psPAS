---
category: psPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASAccountPassword
schema: 2.0.0
title: Get-PASAccountPassword
---

# Get-PASAccountPassword

## SYNOPSIS
Returns password for an account.

## SYNTAX

### 10.1 (Default)
```
Get-PASAccountPassword -AccountID <String> [-Reason <String>] [-TicketingSystem <String>] [-TicketId <String>]
 [-Version <Int32>] [-ActionType <String>] [-isUse <Boolean>] [-Machine] [<CommonParameters>]
```

### ClassicAPI
```
Get-PASAccountPassword -AccountID <String> [-UseClassicAPI] [<CommonParameters>]
```

## DESCRIPTION
Returns password for an account identified by its AccountID.

If using version 9.7+ of the API:
 - Will not return SSH Keys.
 - Cannot be used if a reason for password access must be specified.

If using version 10.1+ of the API:
 - Will return SSH key of an existing account
 - Can be used if a reason and/or ticket ID must be specified.

## EXAMPLES

### EXAMPLE 1
```
Get-PASAccount -Keywords root -Safe Prod_Safe | Get-PASAccountPassword
```

Will return the password value of the account found by Get-PASAccount

### EXAMPLE 2
```
Get-PASAccount -Keywords root -Safe Prod_Safe | Get-PASAccountPassword -UseClassicAPI
```

Will retrieve the password value of the account found by Get-PASAccount using the classic (v9) API

### EXAMPLE 3
```
Get-PASAccount -Keywords root -Safe Prod_Safe | Get-PASAccountPassword -Reason "Incident Investigation"
```

Will retrieve the password value of the account found by Get-PASAccount using the v10 API, and specify a reason for access.

## PARAMETERS

### -AccountID
The ID of the account whose password will be retrieved.

```yaml
Type: String
Parameter Sets: (All)
Aliases: id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UseClassicAPI
Specify the UseClassicAPI to force usage the Classic (v9) API endpoint.

```yaml
Type: SwitchParameter
Parameter Sets: ClassicAPI
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Reason
The reason that is required to be specified to retrieve the password/SSH key.

Use of parameter requires version 10.1 at a minimum.

```yaml
Type: String
Parameter Sets: 10.1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TicketingSystem
The name of the Ticketing System.

Use of parameter requires version 10.1 at a minimum.

```yaml
Type: String
Parameter Sets: 10.1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TicketId
The ticket ID of the ticketing system.

Use of parameter requires version 10.1 at a minimum.

```yaml
Type: String
Parameter Sets: 10.1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Version
The version number of the required password.

If there are no previous versions, the current password/key version is returned.

Use of parameter requires version 10.1 at a minimum.

```yaml
Type: Int32
Parameter Sets: 10.1
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ActionType
The action this password will be used for.

Use of parameter requires version 10.1 at a minimum.

```yaml
Type: String
Parameter Sets: 10.1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -isUse
Internal parameter (for PSMP only).

Use of parameter requires version 10.1 at a minimum.

```yaml
Type: Boolean
Parameter Sets: 10.1
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Machine
The address of the remote machine to connect to.

Use of parameter requires version 10.1 at a minimum.

```yaml
Type: SwitchParameter
Parameter Sets: 10.1
Aliases:

Required: False
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
Minimum API version is 9.7 for password retrieval only.
From version 10.1 onwards both passwords and ssh keys can be retrieved.

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASAccountPassword](https://pspas.pspete.dev/commands/Get-PASAccountPassword)

