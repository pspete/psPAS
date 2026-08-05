---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Add-PASPTAGlobalCatalog
schema: 2.0.0
title: Add-PASPTAGlobalCatalog
---

# Add-PASPTAGlobalCatalog

## SYNOPSIS

Adds Global Catalog connectivity details to the PTA.

To run this method, you must be a member of the Vault Admins or Security Admins group.

## SYNTAX

```
Add-PASPTAGlobalCatalog [[-ldap_certificate] <String>] [-ldap_server] <String> [[-ssl] <Boolean>]
 [-ldap_port] <Int32> [-upn] <String> [-ldapPassword] <SecureString> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds Global Catalog connectivity details to the PTA Administration to broaden and increase the accuracy of Security Events detections.

Requires membership of the Vault Admins or Security Admins group.
Requires minimum version of 13.0.

## EXAMPLES

### EXAMPLE 1
```powershell
Add-PASPTAGlobalCatalog -ldap_certificate $Base64Cert -ldap_server GC.domain.com -ssl $true -ldap_port 3269 -upn user@domain.com -ldapPassword $SecureString
```

Adds Global Catalog to PTA configuration

### EXAMPLE 2
```powershell
Add-PASPTAGlobalCatalog -ldap_server gc2.cyberark.local -ldap_port 3268 -ssl $false -upn svc_pta@cyberark.local -ldapPassword (ConvertTo-SecureString 'P@ssw0rd123!' -AsPlainText -Force)
```

Adds a Global Catalog connection using the default unencrypted LDAP port, without specifying a certificate

### EXAMPLE 3
```powershell
[PSCustomObject]@{
    ldap_server  = 'gc3.cyberark.local'
    ldap_port    = 3268
    ssl          = $false
    upn          = 'bind-account@cyberark.local'
    ldapPassword = (ConvertTo-SecureString 'P@ssw0rd123!' -AsPlainText -Force)
} | Add-PASPTAGlobalCatalog
```

Adds Global Catalog connectivity details using property values supplied via the pipeline

### EXAMPLE 4
```powershell
$GCParams = @{
    ldap_server      = 'gc.cyberark.local'
    ldap_port        = 3269
    ssl              = $true
    ldap_certificate = $Base64Cert
    upn              = 'bind-account@cyberark.local'
    ldapPassword     = (ConvertTo-SecureString $env:GC_BIND_PASSWORD -AsPlainText -Force)
}
Add-PASPTAGlobalCatalog @GCParams
```

Uses splatting to add Global Catalog connectivity details, sourcing the bind account password from an environment variable

## PARAMETERS

### -ldap_certificate
Base-64 encoded X.509 SSL certificate of the Global Catalog server.
Must be specified if `ssl` parameter is specified as `true`.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ldap_server
The Global Catalog server address in FQDN format.

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

### -ssl
Whether to use a secure connection when connecting to Global Catalog.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ldap_port
The server port number of the Global Catalog. The default Global Catalog ports are 3268 (LDAP) and 3269 (LDAPS).

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

### -upn
The User Principle Name of the Active Directory bind user that will be used to connect and query the Global Catalog.

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

### -ldapPassword
The credentials of the Active Directory bind user that will be used to connect and query the Global Catalog.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: 6
Default value: None
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

[https://pspas.pspete.dev/commands/Add-PASPTAGlobalCatalog](https://pspas.pspete.dev/commands/Add-PASPTAGlobalCatalog)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add-Global-Catalog.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add-Global-Catalog.htm)