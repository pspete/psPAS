---
title: Add-PASApplicationAuthenticationMethod
---

## SYNOPSIS

Adds an authentication method to an application.

## SYNTAX

    Add-PASApplicationAuthenticationMethod -AppID <String> -machineAddress <String> [<CommonParameters>]

    Add-PASApplicationAuthenticationMethod -AppID <String> -osUser <String> [<CommonParameters>]

    Add-PASApplicationAuthenticationMethod -AppID <String> -hash <String> [-Comment <String>] [<CommonParameters>]

    Add-PASApplicationAuthenticationMethod -AppID <String> -certificateserialnumber <String> [-Comment <String>] [<CommonParameters>]

    Add-PASApplicationAuthenticationMethod -AppID <String> [-Subject <String[]>] [-Issuer <String[]>] [-SubjectAlternativeName <String[]>] [-Comment <String>] [<CommonParameters>]

    Add-PASApplicationAuthenticationMethod -AppID <String> -path <String> [-IsFolder <Boolean>] [-AllowInternalScripts <Boolean>] [<CommonParameters>]


## DESCRIPTION

Adds a new authentication method to a specific application iin the vault.
The "Manage Users" permission is required to be held by the user running the function.

## PARAMETERS

    -AppID <String>
        The name of the application for which a new authentication method is being added.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -path <String>
        The path to configure as an authentication method

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -hash <String>
        A file hash to configure as an authentication method

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -osUser <String>
        An osUser to configure as an authentication method

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -machineAddress <String>
        Address value to configure as an authentication method

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -certificateserialnumber <String>
        Certificate Serial Number to configure as an authentication method

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Subject <String[]>
        The content of the subject attribute.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Issuer <String[]>
        The content of the issuer attribute

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -SubjectAlternativeName <String[]>
        The content of the subject alternative name attribute
        Accepts attributes "DNS Name", "IP Address", "URI", "RFC822"

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -IsFolder <Boolean>
        Boolean value denoting if path is a folder.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AllowInternalScripts <Boolean>
        Boolean value denoting if internal scripts are allowed.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Comment <String>
        Note Property

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Add-PASApplicationAuthenticationMethod -AppID NewApp -machineAddress "AppServer1.domain.com"

    Adds a Machine Address application authentication mechanism to NewApp




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Add-PASApplicationAuthenticationMethod -AppID NewApp -osUser "Domain\SomeUser"

    Adds an osUSer application authentication mechanism to NewApp




    -------------------------- EXAMPLE 3 --------------------------

    PS C:\>Add-PASApplicationAuthenticationMethod -AppID NewApp -path "SomePath"

    Adds path application authentication mechanism to NewApp




    -------------------------- EXAMPLE 4 --------------------------

    PS C:\>Add-PASApplicationAuthenticationMethod -AppID NewApp -certificateserialnumber 040000000000FA3DEFE9A9 -Comment "DEV Cert"

    Adds certificateserialnumber application authentication mechanism to NewApp




    -------------------------- EXAMPLE 5 --------------------------

    PS C:\>Add-PASApplicationAuthenticationMethod -AppID AppWebService -Subject "CN=application.company.com"

    Adds Certificate Attribute authentication




    -------------------------- EXAMPLE 6 --------------------------

    PS C:\>Add-PASApplicationAuthenticationMethod -AppID AppWebService -SubjectAlternativeName "DNS Name=application.service"

    Adds Certificate Attribute authentication for certificate SAN attribute