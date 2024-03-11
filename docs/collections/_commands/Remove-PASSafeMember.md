---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Remove-PASSafeMember
schema: 2.0.0
title: Remove-PASSafeMember
---

# Remove-PASSafeMember

## SYNOPSIS
Removes a member from a safe

## SYNTAX

```
Remove-PASSafeMember [-SafeName] <String> [-MemberName] <String> [-UseGen1API] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Removes a specific member from a Safe.

The user who runs this function requires the ManageSafeMembers permission.

Default operation against Gen2 API requires minimum version of 12.2

## EXAMPLES

### EXAMPLE 1
```
Remove-PASSafeMember -SafeName TargetSafe -MemberName TargetUser
```

Removes TargetUser as safe member from TargetSafe using Gen2 API

Requires minimum version 12.2

### EXAMPLE 2
```
Remove-PASSafeMember -SafeName TargetSafe -MemberName TargetUser -UseGen1API
```

Removes TargetUser as safe member from TargetSafe using Gen1 API

## PARAMETERS

### -SafeName
The name of the safe from which to remove the member.

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

### -MemberName
The name of the safe member to remove from the safes list of members.

```yaml
Type: String
Parameter Sets: (All)
Aliases: UserName

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

### -UseGen1API
Specify to force usage the Gen1 API endpoint.

Should be specified for versions earlier than 12.2

Is not supported for Privilege Cloud

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
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

## RELATED LINKS

[https://pspas.pspete.dev/commands/Remove-PASSafeMember](https://pspas.pspete.dev/commands/Remove-PASSafeMember)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20Safe%20Member.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20Safe%20Member.htm)
