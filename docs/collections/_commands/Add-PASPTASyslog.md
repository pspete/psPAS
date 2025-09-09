---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Add-PASPTASyslog
schema: 2.0.0
---

# Add-PASPTASyslog

## SYNOPSIS
Add a SYSLOG configuration to PTA

## SYNTAX

```
Add-PASPTASyslog [-siem] <String> [-format] <String> [-host] <String> [-port] <Int32> [-protocol] <String>
 [[-CertificateFile] <String>] [-syslogType] <String> [-tcpOctetCounting] <Boolean> [<CommonParameters>]
```

## DESCRIPTION
Add a new SYSLOG configuration to PTA

This API is not officially documented, so this help file may not help 100%

## EXAMPLES

### Example 1
```powershell
PS C:\> Add-PASPTASyslog -siem SomeSIEM -format CEF -host SOMEHOST.domain.com -port 514 -protocol UDP -syslogType SomeType -tcpOctetCounting $false
```

Adds the specified SYSLOG configuration to PTA

## PARAMETERS

### -siem
A name for the SIEM configuration

```yaml
Type: String
Parameter Sets: (All)
Aliases: Name

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -format
CEF or LEEF format

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

### -host
The SYSLOG host

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

### -port
The SYSLOG port

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -protocol
The SYSLOG protocol

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -CertificateFile
The certificate file for SYSLOG connectivity

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -syslogType
The SYSLOG type

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -tcpOctetCounting
Whether to set TCP Octet Counting

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: True
Position: 8
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

[https://pspas.pspete.dev/commands/Add-PASPTASyslog](https://pspas.pspete.dev/commands/Add-PASPTASyslog)
