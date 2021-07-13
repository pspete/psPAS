---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/New-PASPSMSession
schema: 2.0.0
title: New-PASPSMSession
---

# New-PASPSMSession

## SYNOPSIS
Get required parameters to connect through PSM

## SYNTAX

### PSMConnect
```
New-PASPSMSession -AccountID <String> [-reason <String>] [-TicketingSystemName <String>] [-TicketId <String>]
 -ConnectionComponent <String> [-AllowMappingLocalDrives <String>] [-AllowConnectToConsole <String>]
 [-RedirectSmartCards <String>] [-PSMRemoteMachine <String>] [-LogonDomain <String>]
 [-AllowSelectHTML5 <String>] [-ConnectionMethod <String>] [-Path <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### AdHocConnect
```
New-PASPSMSession -userName <String> -secret <SecureString> -address <String> -platformID <String>
 [-extraFields <String>] [-reason <String>] [-TicketingSystemName <String>] [-TicketId <String>]
 -ConnectionComponent <String> [-AllowMappingLocalDrives <String>] [-AllowConnectToConsole <String>]
 [-RedirectSmartCards <String>] [-PSMRemoteMachine <String>] [-LogonDomain <String>]
 [-AllowSelectHTML5 <String>] [-ConnectionMethod <String>] [-Path <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
This method enables you to connect to an account through PSM (PSMConnect).

The function returns either an RDP file or URL for PSM connections.

It requires the PVWA and PSM to be configured for either transparent connections through PSM with RDP files
or the HTML5 Gateway.

Minimum required version for AdHocConnect 10.5

Minimum required version for HTMLGW 10.2

## EXAMPLES

### EXAMPLE 1
```
New-PASPSMSession -AccountID $ID -ConnectionComponent PSM-SSH -reason "Fix XYZ"
```

Outputs RDP file for Direct Connection via PSM using account with ID in $ID

### EXAMPLE 2
```
New-PASPSMSession -AccountID $id -ConnectionComponent PSM-RDP -AllowMappingLocalDrives No -PSMRemoteMachine ServerName
```

Provide connection parameters for the new PSM connection

## PARAMETERS

### -AccountID
The unique ID of the account to retrieve and use to connect to the target via PSM

```yaml
Type: String
Parameter Sets: PSMConnect
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -userName
For Ad-Hoc connections: the username of the account to connect with.

Minimum required version 10.5

```yaml
Type: String
Parameter Sets: AdHocConnect
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -secret
For Ad-Hoc connections: The target account password.

Minimum required version 10.5

```yaml
Type: SecureString
Parameter Sets: AdHocConnect
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -address
For Ad-Hoc connections: The target account address.

Minimum required version 10.5

```yaml
Type: String
Parameter Sets: AdHocConnect
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -platformID
For Ad-Hoc connections: A configured secure connect platform.

Minimum required version 10.5

```yaml
Type: String
Parameter Sets: AdHocConnect
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -extraFields
For Ad-Hoc connections: Additional needed parameters for the various connection components.

Minimum required version 10.5

```yaml
Type: String
Parameter Sets: AdHocConnect
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -reason
The reason that is required to request access to this account.

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
The name of the Ticketing System used in the request.

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

### -TicketId
The TicketId to use with the Ticketing System

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

### -ConnectionComponent
The name of the connection component to connect with as defined in the configuration

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

### -AllowMappingLocalDrives
Whether or not to redirect their local hard drives to the remote server.

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

### -AllowConnectToConsole
Whether or not to connect to the administrative console of the remote machine.

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

### -RedirectSmartCards
Whether or not to redirect Smart Card so that the certificate stored on the card can be accessed on the target

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

### -PSMRemoteMachine
Address of the remote machine to connect to.

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

### -LogonDomain
The NetBIOS domain name of the account being used.

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

### -AllowSelectHTML5
Specify which connection method, HTML5-based or RDP-file, to use when connecting to the remote server

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

### -ConnectionMethod
The expected parameters to be returned, either RDP or PSMGW.

PSMGW is only available from version 10.2 onwards

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

### -Path
The folder to save the output file in.

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
PSMGW connections require 10.2
Ad-Hoc connections require 10.5

## RELATED LINKS

[https://pspas.pspete.dev/commands/New-PASPSMSession](https://pspas.pspete.dev/commands/New-PASPSMSession)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/ConnectThroughPSM.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/ConnectThroughPSM.htm)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/SecureConnectPSM.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/SecureConnectPSM.htm)
