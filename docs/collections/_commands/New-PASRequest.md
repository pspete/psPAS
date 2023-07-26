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
Creates requests for account access

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

### BulkSearch
```
New-PASRequest -Search <String> [-ExcludedEntities <String[]>] [-Reason <String>]
 [-TicketingSystemName <String>] [-TicketID <String>] [-MultipleAccessRequired <Boolean>]
 [-FromDate <DateTime>] [-ToDate <DateTime>] [-AdditionalInfo <Hashtable>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### BulkFilter
```
New-PASRequest -SavedFilter <String> [-ExcludedEntities <String[]>] [-Reason <String>]
 [-TicketingSystemName <String>] [-TicketID <String>] [-MultipleAccessRequired <Boolean>]
 [-FromDate <DateTime>] [-ToDate <DateTime>] [-AdditionalInfo <Hashtable>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### BulkItems
```
New-PASRequest -BulkItems <Object[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates an access request for a specific account, list of accounts, or multiple accounts which match filter or search criteria.

A specific account may be either a password account or an SSH Key account.

Requesting access to multiple accounts is only available if Add accounts, Update account content, and Update account properties authorization is held for at least one Safe.

## EXAMPLES

### EXAMPLE 1
```
New-PASRequest -AccountId $ID -Reason "Task ABC" -MultipleAccessRequired $true -ConnectionComponent PSM-RDP
```

Creates a new request for access to account with ID in $ID

### EXAMPLE 2
```
New-PASRequest -Search some_admin -ExcludedEntities 123_4, 456_78 -Reason "some reason"
```

Requests access to multiple accounts matching search term

### EXAMPLE 3
```
New-PASRequest -SavedFilter Favorites -ExcludedEntities 12_3, 45_6 -Reason "some reason"
```

Requests access to multiple accounts matching saved filter

### EXAMPLE 4
```
New-PASRequest -BulkItems $Requests
```

Submits a list of request objects.
Request objects are created with the New-PASRequestObject command.

### EXAMPLE 5
```
New-PASRequest -MultipleAccessRequired $true -FromDate (Get-Date) -ToDate (Get-Date).AddDays(1) -SavedFilter Favorites -ExcludedEntities 50_3 -Reason "Some Reason"
```

Requests multiple access over 24 hours to multiple accounts matching saved filter.

Multiple access requests must include ToDate and FromDate values

## PARAMETERS

### -AccountId
The ID of the account to access

```yaml
Type: String
Parameter Sets: ConnectionParams, ManualParams
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
Parameter Sets: ConnectionParams, ManualParams, BulkSearch, BulkFilter
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
Parameter Sets: ConnectionParams, ManualParams, BulkSearch, BulkFilter
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
Parameter Sets: ConnectionParams, ManualParams, BulkSearch, BulkFilter
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
Parameter Sets: ConnectionParams, ManualParams, BulkSearch, BulkFilter
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
Parameter Sets: ConnectionParams, ManualParams, BulkSearch, BulkFilter
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
Parameter Sets: ConnectionParams, ManualParams, BulkSearch, BulkFilter
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
Parameter Sets: ConnectionParams, ManualParams, BulkSearch, BulkFilter
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
Parameter Sets: ConnectionParams, ManualParams
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
Parameter Sets: ConnectionParams, ManualParams
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

### -BulkItems
An array of Requests created with New-PASRequestObject.

Requires minimum version of 13.2

```yaml
Type: Object[]
Parameter Sets: BulkItems
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ExcludedEntities
A list of AccountID's to exclude when using search or filter to request access for multiple accounts.

Requires minimum version of 13.2

```yaml
Type: String[]
Parameter Sets: BulkSearch, BulkFilter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SavedFilter
Request access to multiple accounts which match a savedFilter.

Accepts account view  filter names 'Regular', 'Recently', 'Locked' & 'Favorites'

Requires minimum version of 13.2

```yaml
Type: String
Parameter Sets: BulkFilter
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Search
Request access to multiple accounts which match a search term

Requires minimum version of 13.2

```yaml
Type: String
Parameter Sets: BulkSearch
Aliases:

Required: True
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
Minimum CyberArk Version 9.10

## RELATED LINKS

[https://pspas.pspete.dev/commands/New-PASRequest](https://pspas.pspete.dev/commands/New-PASRequest)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/CreateRequest.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/CreateRequest.htm)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Create-multiple-requests.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/13.2/en/Content/WebServices/Create-multiple-requests.htm)