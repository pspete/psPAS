---
external help file: psPAS-help.xml
Module Name: psPAS
online version:
schema: 2.0.0
title: Publish-PASDiscoveredAccount
---

# Publish-PASDiscoveredAccount

## SYNOPSIS

Onboard a discovered account

## SYNTAX

```
Publish-PASDiscoveredAccount [-id] <String> [-PlatformID] <String> [-safeName] <String>
 [[-shouldReconcileAccount] <Boolean>] [[-defaultPassword] <SecureString>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Onboard a discovered account to a target platform into a target safe.
Optionally set the account to be reconciled, and/or with a default password.

## EXAMPLES

### EXAMPLE 1
```powershell
$password = Read-Host -AsSecureString -Prompt "defaultPassword value"
Publish-PASDiscoveredAccount -id 66_6 -PlatformID WinDomain -safeName SomeSafe -defaultPassword $password
```

Onboard discovered account with id 66_6 to `SomeSafe` with the provided default password

## PARAMETERS

### -id
Discovered account ID

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

### -PlatformID
Target platform ID

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

### -safeName
Target safe name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -shouldReconcileAccount
Specify if the account should be reconciled

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -defaultPassword
The default password value

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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

## RELATED LINKS

[https://pspas.pspete.dev/commands/Publish-PASDiscoveredAccount](https://pspas.pspete.dev/commands/Publish-PASDiscoveredAccount)
