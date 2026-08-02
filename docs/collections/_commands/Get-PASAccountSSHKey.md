---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASAccountSSHKey
schema: 2.0.0
title: Get-PASAccountSSHKey
---

# Get-PASAccountSSHKey

## SYNOPSIS
Retrieves a private SSH key

## SYNTAX

```
Get-PASAccountSSHKey [-AccountID] <String> [[-Reason] <String>] [[-TicketingSystem] <String>]
 [[-TicketId] <String>] [[-Version] <Int32>] [[-ActionType] <String>] [[-isUse] <Boolean>]
 [[-Machine] <String>] [-Path <String>] [<CommonParameters>]
```

## DESCRIPTION
Get the private SSH key value from an existing account.
If the -Path parameter is specified, the private SSH key is saved to the specified local file instead of being returned to the pipeline.

## EXAMPLES

### EXAMPLE 1
```
Get-PASAccountSSHKey -AccountId 12_3 -Reason "Some Reason"
```

Returns Private SSH Key associated with account 12_3

### EXAMPLE 2
```
Get-PASAccountSSHKey -AccountId 12_3 -Reason "Emergency access" -TicketingSystem ServiceNow -TicketId "INC0012345"
```

Returns the private SSH key for account 12_3, recording the ticketing system and ticket ID used to justify the retrieval.

### EXAMPLE 3
```
Get-PASAccountSSHKey -AccountId 12_3 -Version 2 -Machine "unix01.domain.com"
```

Returns version 2 of the private SSH key for account 12_3, retrieved for use against the specified remote machine.

### EXAMPLE 4
```
Get-PASAccount -search "unix01" | Get-PASAccountSSHKey -Reason "Scheduled maintenance"
```

Gets the matching account and retrieves its private SSH key, using the account ID from the pipeline.

### EXAMPLE 5
```
Get-PASAccountSSHKey -AccountId 12_3 -Path C:\Keys\
```

Saves the private SSH key for account 12_3 to a file in the C:\Keys\ folder.

## PARAMETERS

### -AccountID
The ID of the account whose SSH Key will be retrieved.

```yaml
Type: String
Parameter Sets: (All)
Aliases: id

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Reason
The reason for retrieving the private SSH key.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TicketingSystem
The name of the ticketing system.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TicketId
The ticket ID defined in the ticketing system.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Version
The version number of the required SSH key.

If the value is left empty or the value passed does not exist,
then the current SSH key version is returned.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ActionType
The action this SSH key is used for

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -isUse
Internal parameter (for use of PSMP only)

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Machine
The address of the remote machine that the user wants to connect to using the SSH key.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path
Output folder, or full destination file path, to save the retrieved private SSH key to.
If the path's leaf component includes a file extension, it is treated as the exact file to save to; otherwise it is treated as an output folder and a filename derived from the AccountID is appended.
If not specified, the private SSH key value is returned to the pipeline instead of being saved to a file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

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

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASAccountSSHKey](https://pspas.pspete.dev/commands/Get-PASAccountSSHKey)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Retrieve_Private_SSH_Key_Account.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Retrieve_Private_SSH_Key_Account.htm)
