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
 [[-TicketId] <String>] [[-Version] <Int32>] [[-ActionType] <String>] [[-isUse] <Boolean>] [-Machine]
 [<CommonParameters>]
```

## DESCRIPTION
Get the private SSH key value from an existing account

## EXAMPLES

### EXAMPLE 1
```
Get-PASAccountSSHKey -AccountId 12_3 -Reason "Some Reason"
```

Returns Private SSH Key associated with account 12_3

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
The address of the remote machine

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
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
