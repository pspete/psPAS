---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Set-PASDependentLinkedAccount
schema: 2.0.0
title: Set-PASDependentLinkedAccount
---

# Set-PASDependentLinkedAccount

## SYNOPSIS

Sets a Linked Account for a Dependent Account

## SYNTAX

### SaaS
```
Set-PASDependentLinkedAccount [-accountId] <String> [-dependentAccountId] <String>
 [-extraPasswordAccountId] <String> [-extraPasswordIndex] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### SelfHosted
```
Set-PASDependentLinkedAccount [-accountId] <String> [-dependentAccountId] <String>
 [-extraPasswordIndex] <String> [-safe] <String> [-name] <String> [[-folder] <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

Links an account to a dependent account

## EXAMPLES

### Example 1 - Privilege Cloud

```powershell
PS C:\> Set-PASDependentLinkedAccount -accountId 12_3 -dependentAccountId 12_4 -extraPasswordAccountId 56_7 -extraPasswordIndex 1
```

Links account with ID 56_7 to linked account index 1 for dependent account 12_4 with parent account 12_3

### Example 2 - Self-Hosted

```powershell
PS C:\> Set-PASDependentLinkedAccount -accountId 22_3 -dependentAccountId 22_4 -extraPasswordIndex 1 -safe somesafe -name accountname
```

Links the account named accountname in the somesafe Safe to linked account index 1 (logon account) for dependent account 22_4 with parent account 22_3

### Example 3 - Self-Hosted with folder

```powershell
PS C:\> Set-PASDependentLinkedAccount -accountId 22_3 -dependentAccountId 22_4 -extraPasswordIndex 2 -safe somesafe -name reconcileaccount -folder Reconcile
```

Links the account named reconcileaccount in the Reconcile folder of the somesafe Safe to linked account index 2 (reconcile account) for dependent account 22_4 with parent account 22_3

### Example 4 - WhatIf

```powershell
PS C:\> Set-PASDependentLinkedAccount -accountId 12_3 -dependentAccountId 12_4 -extraPasswordAccountId 56_7 -extraPasswordIndex 3 -WhatIf
```

Shows what would happen if account 56_7 were linked as index 3 for dependent account 12_4, but does not perform the link

## PARAMETERS

### -accountId

The ID of the parent account for the dependent account

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

### -dependentAccountId

The ID of the dependent account

```yaml
Type: String
Parameter Sets: (All)
Aliases: dependentid

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -extraPasswordAccountId

The ID of the account to link to the dependent account.
Used for Privilege Cloud environments.

```yaml
Type: String
Parameter Sets: SaaS
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -extraPasswordIndex

The index to link the account to

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -safe

The Safe containing the account to link to the dependent account.
Used for Self-Hosted environments.

```yaml
Type: String
Parameter Sets: SelfHosted
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -name

The name of the account to link to the dependent account.
Used for Self-Hosted environments.

```yaml
Type: String
Parameter Sets: SelfHosted
Aliases:

Required: True
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -folder

The folder containing the account to link to the dependent account.
Used for Self-Hosted environments. Defaults to Root.

```yaml
Type: String
Parameter Sets: SelfHosted
Aliases:

Required: False
Position: 7
Default value: Root
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

## RELATED LINKS

[https://pspas.pspete.dev/commands/Set-PASDependentLinkedAccount](https://pspas.pspete.dev/commands/Set-PASDependentLinkedAccount)

[https://docs.cyberark.com/privilege-cloud-shared-services/latest/en/content/privilegecloudapis/account-dependents-cpm.htm](https://docs.cyberark.com/privilege-cloud-shared-services/latest/en/content/privilegecloudapis/account-dependents-cpm.htm)
