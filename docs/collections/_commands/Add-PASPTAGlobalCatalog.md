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
 [-ldap_port] <Int32> [-upn] <String> [-ldapPassword] <SecureString> [<CommonParameters>]
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Add-PASPTAGlobalCatalog](https://pspas.pspete.dev/commands/Add-PASPTAGlobalCatalog)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add-Global-Catalog.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add-Global-Catalog.htm)