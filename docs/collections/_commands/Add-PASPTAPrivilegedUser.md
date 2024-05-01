---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Add-PASPTAPrivilegedUser
schema: 2.0.0
title: Add-PASPTAPrivilegedUser
---

# Add-PASPTAPrivilegedUser

## SYNOPSIS
Adds an user to PrivilegedUsersList in PTA

## SYNTAX

```
Add-PASPTAPrivilegedUser [-platform] <String> [-user] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds an user to PrivilegedUsersList in PTA configuration

## EXAMPLES

### EXAMPLE 1
```powershell
Add-PASPTAPrivilegedUser -platform WINDOWS -user AdminUser
```

Adds AdminUser to PrivilegedUsersList in PTA

## PARAMETERS

### -platform
The platform of the privileged user (UNIX, WINDOWS, ORACLE, CLOUD_AWS, CLOUD_AZURE, APPLICATION)

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

### -user
A privileged user or a regex for the privileged users

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

[https://pspas.pspete.dev/commands/Add-PASPTAPrivilegedUser](https://pspas.pspete.dev/commands/Add-PASPTAPrivilegedUser)

[https://docs.cyberark.com/PAS/Latest/en/Content/WebServices/UpdateAdministration.htm](https://docs.cyberark.com/PAS/Latest/en/Content/WebServices/UpdateSecurity.htm)
