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

### Gen2 (Default)
```
Get-PASAccountPassword -AccountID <String> [-Reason <String>] [-TicketingSystem <String>] [-TicketId <String>]
 [-Version <Int32>] [-ActionType <String>] [-isUse <Boolean>] [-Machine <String>] [-UserName <String>]
 [<CommonParameters>]
```

### Gen1
```
Get-PASAccountPassword -AccountID <String> [-UseGen1API] [-UserName <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns password for an account identified by its AccountID.

If using version 9.7+ & Gen1 API parameters:
 - Will not return SSH Keys.
 - Cannot be used if a reason for password access must be specified.

If using version 10.1+ & Gen2 API parameters:
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
Get-PASAccount -Keywords root -Safe Prod_Safe | Get-PASAccountPassword -UseGen1API
```

Will retrieve the password value of the account found by Get-PASAccount using the Gen1 API

### EXAMPLE 3
```
Get-PASAccount -Keywords root -Safe Prod_Safe | Get-PASAccountPassword -Reason "Incident Investigation"
```

Will retrieve the password value of the account found by Get-PASAccount using the Gen2 API, and specify a reason for access.

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

### -Reason
The reason that is required to be specified to retrieve the password/SSH key.

Requires minimum version of 10.1

```yaml
Type: String
Parameter Sets: Gen2
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TicketingSystem
The name of the Ticketing System.

Requires minimum version of 10.1

```yaml
Type: String
Parameter Sets: Gen2
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TicketId
The ticket ID of the ticketing system.

Requires minimum version of 10.1

```yaml
Type: String
Parameter Sets: Gen2
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

Requires minimum version of 10.1

```yaml
Type: Int32
Parameter Sets: Gen2
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ActionType
The action this password will be used for.

Requires minimum version of 10.1

```yaml
Type: String
Parameter Sets: Gen2
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -isUse
Internal parameter (for PSMP only).

Requires minimum version of 10.1

```yaml
Type: Boolean
Parameter Sets: Gen2
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Machine
The address of the remote machine to connect to.

Requires minimum version of 10.1

```yaml
Type: String
Parameter Sets: Gen2
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseGen1API
Specify to force usage the Gen1 API endpoint.

Should be specified for versions earlier than 10.1

```yaml
Type: SwitchParameter
Parameter Sets: Gen1
Aliases: UseClassicAPI

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserName
UserName value, specified either manually or via input object.

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
Minimum API version is 9.7 for password retrieval only.
From version 10.1 onwards both passwords and ssh keys can be retrieved.

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASAccountPassword](https://pspas.pspete.dev/commands/Get-PASAccountPassword)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetPasswordValueV10.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetPasswordValueV10.htm)
