---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Add-PASApplicationAuthenticationMethod
schema: 2.0.0
title: Add-PASApplicationAuthenticationMethod
---

# Add-PASApplicationAuthenticationMethod

## SYNOPSIS
Adds an authentication method to an application.

## SYNTAX

### machineAddress
```
Add-PASApplicationAuthenticationMethod -AppID <String> -machineAddress <String> [<CommonParameters>]
```

### osUser
```
Add-PASApplicationAuthenticationMethod -AppID <String> -osUser <String> [<CommonParameters>]
```

### hash
```
Add-PASApplicationAuthenticationMethod -AppID <String> -hash <String> [-Comment <String>] [<CommonParameters>]
```

### certificateserialnumber
```
Add-PASApplicationAuthenticationMethod -AppID <String> -certificateserialnumber <String> [-Comment <String>]
 [<CommonParameters>]
```

### certificateattr
```
Add-PASApplicationAuthenticationMethod -AppID <String> [-Subject <String[]>] [-Issuer <String[]>]
 [-SubjectAlternativeName <String[]>] [-Comment <String>] [<CommonParameters>]
```

### path
```
Add-PASApplicationAuthenticationMethod -AppID <String> -path <String> [-IsFolder <Boolean>]
 [-AllowInternalScripts <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
Adds a new authentication method to a specific application iin the vault.
The "Manage Users" permission is required to be held by the user running the function.

## EXAMPLES

### EXAMPLE 1
```
Add-PASApplicationAuthenticationMethod -AppID NewApp -machineAddress "AppServer1.domain.com"
```

Adds a Machine Address application authentication mechanism to NewApp

### EXAMPLE 2
```
Add-PASApplicationAuthenticationMethod -AppID NewApp -osUser "Domain\SomeUser"
```

Adds an osUSer application authentication mechanism to NewApp

### EXAMPLE 3
```
Add-PASApplicationAuthenticationMethod -AppID NewApp -path "SomePath"
```

Adds path application authentication mechanism to NewApp

### EXAMPLE 4
```
Add-PASApplicationAuthenticationMethod -AppID NewApp -certificateserialnumber 040000000000FA3DEFE9A9 -Comment "DEV Cert"
```

Adds certificateserialnumber application authentication mechanism to NewApp

### EXAMPLE 5
```
Add-PASApplicationAuthenticationMethod -AppID AppWebService -Subject "CN=application.company.com"
```

Adds Certificate Attribute authentication

### EXAMPLE 6
```
Add-PASApplicationAuthenticationMethod -AppID AppWebService -SubjectAlternativeName "DNS Name=application.service"
```

Adds Certificate Attribute authentication for certificate SAN attribute

## PARAMETERS

### -AppID
The name of the application for which a new authentication method is being added.

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

### -path
The path to configure as an authentication method

```yaml
Type: String
Parameter Sets: path
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -hash
A file hash to configure as an authentication method

```yaml
Type: String
Parameter Sets: hash
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -osUser
An osUser to configure as an authentication method

```yaml
Type: String
Parameter Sets: osUser
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -machineAddress
Address value to configure as an authentication method

```yaml
Type: String
Parameter Sets: machineAddress
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -certificateserialnumber
Certificate Serial Number to configure as an authentication method

```yaml
Type: String
Parameter Sets: certificateserialnumber
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Subject
The content of the subject attribute.

```yaml
Type: String[]
Parameter Sets: certificateattr
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Issuer
The content of the issuer attribute

```yaml
Type: String[]
Parameter Sets: certificateattr
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SubjectAlternativeName
The content of the subject alternative name attribute

Accepts attributes "DNS Name", "IP Address", "URI", "RFC822"

```yaml
Type: String[]
Parameter Sets: certificateattr
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -IsFolder
Boolean value denoting if path is a folder.

```yaml
Type: Boolean
Parameter Sets: path
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AllowInternalScripts
Boolean value denoting if internal scripts are allowed.

```yaml
Type: Boolean
Parameter Sets: path
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Comment
Note Property

```yaml
Type: String
Parameter Sets: hash, certificateserialnumber, certificateattr
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

[https://pspas.pspete.dev/commands/Add-PASApplicationAuthenticationMethod](https://pspas.pspete.dev/commands/Add-PASApplicationAuthenticationMethod)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add%20Authentication.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add%20Authentication.htm)
