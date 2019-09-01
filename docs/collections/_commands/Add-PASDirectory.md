---
title: Add-PASDirectory
---

## SYNOPSIS

Adds an LDAP directory to the Vault

## SYNTAX

    Add-PASDirectory -DirectoryType <String> -HostAddresses <String[]> [-BindUsername <String>]
    [-BindPassword <SecureString>] [-Port <Int32>] -DomainName <String> -DomainBaseContext <String>
    [-SSLConnect <Boolean>] [<CommonParameters>]

    Add-PASDirectory -DirectoryType <String> [-BindUsername <String>] [-BindPassword <SecureString>]
    [-Port <Int32>] [-DCList <Hashtable[]>] -DomainName <String> -DomainBaseContext <String>
    [-SSLConnect <Boolean>] [<CommonParameters>]

## DESCRIPTION

Adds an LDAP directory to the Vault.

Membership of the Vault Admins group required.

## PARAMETERS

    -DirectoryType <String>
        The name of the directory profile file that the Vault will use when working with the
        specified LDAP directory.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -HostAddresses <String[]>
        List of IP addresses of the host servers where the External Directories exist.
        If the Vault will use an SSL connection to connect to the External Directory, this name
        must match the subject
        that appears in the Directory certificate

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -BindUsername <String>
        The username of the account used to bind to the directory

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -BindPassword <SecureString>
        A SecureString containing the password for the Bind User

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Port <Int32>
        The port that will be used to access the specified server.
        The standard port for SSL LDAP connections is 636, and for non-SSL LDAP connections is 389

        Required?                    false
        Position?                    named
        Default value                0
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -DCList <Hashtable[]>
        Applies to 10.7+; an array of hashtables containing
        LDAPDomainController information.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -DomainName <String>
        The address of the domain

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -DomainBaseContext <String>
        The base context of the External Directory.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -SSLConnect <Boolean>
        Boolean value defining whether or not to connect to the external directory with SSL.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Add-PASDirectory -DirectoryType "MicrosoftADProfile.ini"
    -HostAddresses "192.168.60.1","192.168.60.100" -BindUsername "CABind" -BindPassword $pw
    -Port 389 -DomainName "DOMAIN.COM" -DomainBaseContext "DC=DOMAIN,DC=COM"

    Adds the Domain.Com directory to the vault




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Add-PASDirectory -DirectoryType "MicrosoftADProfile.ini" -BindUsername "bind@domain.com"
    -BindPassword $pw -DomainName DOMAIN -DomainBaseContext "DC=DOMAIN,DC=COM" -DCList @(@{
        "Name"="192.168.99.1";"Port"=389;"SSLConnect"=$false},
        @{"Name"="192.168.99.1";"Port"=389;"SSLConnect"=$false}) -Port 389

    (For 10.7+) - Adds the Domain.Com directory to the vault
