---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Add-PASPTAPrivilegedGroup
schema: 2.0.0
title: Add-PASPTAPrivilegedGroup
---

# Add-PASPTAPrivilegedGroup

## SYNOPSIS
Adds an AD group to PrivilegedDomainGroupsList in PTA

## SYNTAX

```
Add-PASPTAPrivilegedGroup [-domain] <String> [-group] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds an AD group to PrivilegedDomainGroupsList in PTA configuration

## EXAMPLES

### EXAMPLE 1
```powershell
Add-PASPTAPrivilegedGroup -domain SomeDomain.com -group SomeGroup
```

Adds SomeGroup as to PrivilegedDomainGroupsList in PTA

## PARAMETERS

### -domain
A domain name in an FQDN format, such as domain.com

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

### -group
A group name defined as privileged

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

[https://pspas.pspete.dev/commands/Add-PASPTAPrivilegedGroup](https://pspas.pspete.dev/commands/Add-PASPTAPrivilegedGroup)

[https://docs.cyberark.com/PAS/Latest/en/Content/WebServices/UpdateAdministration.htm](https://docs.cyberark.com/PAS/Latest/en/Content/WebServices/UpdateSecurity.htm)
