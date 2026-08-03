---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Set-PASPTASMTP
schema: 2.0.0
title: Set-PASPTASMTP
---

# Set-PASPTASMTP

## SYNOPSIS
Sets an SMTP configuration to PTA

## SYNTAX

```
Set-PASPTASMTP [-host] <String> [-protocol] <String> [-port] <Int32> [-sender] <String>
 [-recipients] <String[]> [[-accountId] <String>] [[-CertificateFile] <String>]
 [-AlertToEmailScoreThreshold] <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Configure PTA SMTP settings

API is not documented, so this help file may not be 100% accurate

## EXAMPLES

### Example 1
```powershell
Set-PASPTASMTP -host smtp.domain.com -protocol TCP -port 25 -sender 'PTA@domain.com' `
 -recipients 'security_team@domain.com' -AlertToEmailScoreThreshold 70
```

Configures PTA SMTP settings

### Example 2
```powershell
Set-PASPTASMTP -host smtp.cyberark.local -protocol NONE -port 25 -sender 'pta-alerts@cyberark.local' -recipients 'soc-team@cyberark.local' -AlertToEmailScoreThreshold 80
```

Configures PTA to send alert emails for events scoring 80 or higher via an unauthenticated, unencrypted SMTP relay

### Example 3
```powershell
Set-PASPTASMTP -host smtp.cyberark.local -protocol STARTTLS -port 587 -sender 'pta-alerts@cyberark.local' -recipients 'soc-team@cyberark.local','ciso@cyberark.local' -accountId 34_5 -CertificateFile C:\Certs\smtp.cer -AlertToEmailScoreThreshold 60
```

Configures PTA SMTP settings to use STARTTLS with the specified certificate, authenticating using the vaulted account 34_5, and sends alert emails to two recipients for events scoring 60 or higher

### Example 4
```powershell
Set-PASPTASMTP -host smtp.cyberark.local -protocol SSL -port 465 -sender 'pta-alerts@cyberark.local' -recipients 'soc-team@cyberark.local' -CertificateFile C:\Certs\smtp.cer -AlertToEmailScoreThreshold 75 -WhatIf
```

Shows what would happen if the PTA SMTP configuration were updated to use SSL on port 465, without making the change

## PARAMETERS

### -host
The SMTP host

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

### -protocol
The protocol for SMTP integration

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

### -port
The port for the SMTP communication

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -sender
The sender address

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

### -recipients
The recipient address

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -accountId
Account to use for SMTP authentication

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

### -CertificateFile
Certificate to use for SMTP authentication

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AlertToEmailScoreThreshold
PTA Alert Score threshold for email alerts

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 8
Default value: 0
Accept pipeline input: True (ByPropertyName)
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

### -WhatIf
Shows what would happen if the cmdlet runs. The cmdlet is not run.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Set-PASPTASMTP](https://pspas.pspete.dev/commands/Set-PASPTASMTP)
