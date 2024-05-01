---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Set-PASIPAllowList
schema: 2.0.0
---

# Set-PASIPAllowList

## SYNOPSIS
Update the list of allowed IP addresses for connector communication to the Privilege Cloud SaaS environment.

## SYNTAX

```
Set-PASIPAllowList [-customerPublicIPs] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Configuration erases everything that was previously configured. In order to keep your current configuration, add the existing IP addresses to the list. An empty list will remove all the current IP addresses.

Configuration can take up to 10 minutes. You cannot trigger a new process when there is a process running. To verify, run the `Get-PASIPAllowList` CmdLet and check that the updateInProgress parameter property is false.

Requires one of the following roles:
- Privilege Cloud Administrator
- Privilege Cloud Administrator Basic
- Privilege Cloud Administrator Lite

## EXAMPLES

### EXAMPLE 1
```
Set-PASIPAllowList -customerPublicIPs '10.66.19.45/32','19.79.19.79/22','194.2.192.5/32','201.3.201.3/24'
```

Configures the IP Allow List with the specified addresses

## PARAMETERS

### -customerPublicIPs
List of IP addresses and subnets separated by commas

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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

[https://pspas.pspete.dev/commands/Set-PASIPAllowList](https://pspas.pspete.dev/commands/Set-PASIPAllowList)

[https://docs.cyberark.com/privilege-cloud-shared-services/latest/en/Content/PrivilegeCloudAPIs/PrivCloud-IP-allowlist-Configure-API.htm](https://docs.cyberark.com/privilege-cloud-shared-services/latest/en/Content/PrivilegeCloudAPIs/PrivCloud-IP-allowlist-Configure-API.htm)
