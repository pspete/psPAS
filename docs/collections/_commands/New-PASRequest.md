---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/New-PASRequest
schema: 2.0.0
title: New-PASRequest
---

# New-PASRequest

## SYNOPSIS
Creates an access request for a specific account

## SYNTAX

### ConnectionParams (Default)
```
New-PASRequest -AccountId <String> [-Reason <String>] [-TicketingSystemName <String>] [-TicketID <String>]
 [-MultipleAccessRequired <Boolean>] [-FromDate <DateTime>] [-ToDate <DateTime>] [-AdditionalInfo <Hashtable>]
 [-UseConnect <Boolean>] [-ConnectionComponent <String>] [-AllowMappingLocalDrives <String>]
 [-AllowConnectToConsole <String>] [-RedirectSmartCards <String>] [-PSMRemoteMachine <String>]
 [-LogonDomain <String>] [-AllowSelectHTML5 <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ManualParams
```
New-PASRequest -AccountId <String> [-Reason <String>] [-TicketingSystemName <String>] [-TicketID <String>]
 [-MultipleAccessRequired <Boolean>] [-FromDate <DateTime>] [-ToDate <DateTime>] [-AdditionalInfo <Hashtable>]
 [-UseConnect <Boolean>] [-ConnectionComponent <String>] [-ConnectionParams <Hashtable>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Creates an access request for a specific account.

This account may be either a password account or an SSH Key account.

Officially supported from version 9.10.

Reports received that function works in 9.9 also.

## EXAMPLES

### EXAMPLE 1
```
New-PASRequest -AccountId $ID -Reason "Task ABC" -MultipleAccessRequired $true -ConnectionComponent PSM-RDP
```

Creates a new request for access to account with ID in $ID

## PARAMETERS

### -AccountId
The ID of the account to access

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Reason
The reason why the account will be accessed

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

### -TicketingSystemName
The name of the Ticketing system specified in the request

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

### -TicketID
The Ticket ID given by the ticketing system.

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

### -MultipleAccessRequired
Whether the request is for multiple accesses

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FromDate
If the request is for a timeframe, the time from when the user wants to access the account.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ToDate
If the request is for a timeframe, the time until the user wants to access the account.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AdditionalInfo
Additional information included in the request

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UseConnect
Whether or not the request is for connection through the PSM.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ConnectionComponent
If the connection is through PSM, the name of the connection component to connect with,
as defined in the configuration.

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

### -AllowMappingLocalDrives
Whether or not to redirect their local hard drives to the remote server.

```yaml
Type: String
Parameter Sets: ConnectionParams
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AllowConnectToConsole
Whether or not to connect to the administrative console of the remote machine.

```yaml
Type: String
Parameter Sets: ConnectionParams
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RedirectSmartCards
Whether or not to redirect Smart Card so that the certificate stored on the card can be accessed on the target

```yaml
Type: String
Parameter Sets: ConnectionParams
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PSMRemoteMachine
Address of the remote machine to connect to.

```yaml
Type: String
Parameter Sets: ConnectionParams
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -LogonDomain
The NetBIOS domain name of the account being used.

```yaml
Type: String
Parameter Sets: ConnectionParams
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AllowSelectHTML5
Specify which connection method, HTML5-based or RDP-file, to use when connecting to the remote server

```yaml
Type: String
Parameter Sets: ConnectionParams
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ConnectionParams
A list of parameters required to perform the connection, as defined in each connection component configuration

```yaml
Type: Hashtable
Parameter Sets: ManualParams
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Minimum CyberArk Version 9.10

## RELATED LINKS

[https://pspas.pspete.dev/commands/New-PASRequest](https://pspas.pspete.dev/commands/New-PASRequest)

