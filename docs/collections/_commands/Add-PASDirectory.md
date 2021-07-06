---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Add-PASDirectory
schema: 2.0.0
title: Add-PASDirectory
---

# Add-PASDirectory

## SYNOPSIS
Adds an LDAP directory to the Vault

## SYNTAX

### 10.4 (Default)
```
Add-PASDirectory -DirectoryType <String> -HostAddresses <String[]> -BindUsername <String>
 -BindPassword <SecureString> [-Port <Int32>] -DomainName <String> -DomainBaseContext <String>
 [-SSLConnect <Boolean>] [<CommonParameters>]
```

### 10.7
```
Add-PASDirectory -DirectoryType <String> -BindUsername <String> -BindPassword <SecureString> [-Port <Int32>]
 [-DCList <Hashtable[]>] -DomainName <String> -DomainBaseContext <String> [-SSLConnect <Boolean>]
 [<CommonParameters>]
```

## DESCRIPTION
Adds an LDAP directory to the Vault.

Membership of the Vault Admins group required.

Minimum required version 10.4

## EXAMPLES

### EXAMPLE 1
```
Add-PASDirectory -DirectoryType "MicrosoftADProfile.ini" -HostAddresses "192.168.60.1","192.168.60.100" -BindUsername "CABind" -BindPassword $pw -Port 389 -DomainName "DOMAIN.COM" -DomainBaseContext "DC=DOMAIN,DC=COM"
```

Adds the Domain.Com directory to the vault

### EXAMPLE 2
```
Add-PASDirectory -DirectoryType "MicrosoftADProfile.ini" -BindUsername "BindUser@domain.com" -BindPassword $($Creds.Password) -DomainName DOMAIN `

-DomainBaseContext "DC=domain,DC=com" -DCList @{"Name"="DC.domain.com";"Port"=636;"SSLConnect"=$true} -SSLConnect $true -Port 636
```

Adds the Domain.Com directory to the vault, configured for LDAPS.

Minimum required version 10.7

## PARAMETERS

### -DirectoryType
The name of the directory profile file that the Vault will use when working with the specified LDAP directory.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -HostAddresses
List of IP addresses of the host servers where the External Directories exist.

If the Vault will use an SSL connection to connect to the External Directory, this name must match the subject
that appears in the Directory certificate

```yaml
Type: String[]
Parameter Sets: 10.4
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -BindUsername
The username of the account used to bind to the directory

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -BindPassword
A SecureString containing the password for the Bind User

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Port
The port that will be used to access the specified server.

The standard port for SSL LDAP connections is 636, and for non-SSL LDAP connections is 389

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DCList
Array of hashtables containing LDAPDomainController information.

Minimum required version 10.7

```yaml
Type: Hashtable[]
Parameter Sets: 10.7
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DomainName
The address of the domain

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DomainBaseContext
The base context of the External Directory.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SSLConnect
Boolean value defining whether or not to connect to the external directory with SSL.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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

[https://pspas.pspete.dev/commands/Add-PASDirectory](https://pspas.pspete.dev/commands/Add-PASDirectory)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/LDAP_Create_Directory.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/LDAP_Create_Directory.htm)
