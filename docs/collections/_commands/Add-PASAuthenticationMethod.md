---
title: Add-PASAuthenticationMethod
---

## SYNOPSIS

    Adds a new authentication method

## SYNTAX

    Add-PASAuthenticationMethod [-id] <String> [[-displayName] <String>] [[-enabled] <Boolean>] [[-mobileEnabled] <Boolean>] [[-logoffUrl] <String>] [[-secondFactorAuth] <String>]
    [[-signInLabel] <String>] [[-usernameFieldLabel] <String>] [[-passwordFieldLabel] <String>] [<CommonParameters>]

## DESCRIPTION

    Adds a new authentication method.
    Membership of Vault admins group required.

## PARAMETERS

    -id <String>
        The authentication module unique identifier.

    -displayName <String>
        The display name of the authentication method.

    -enabled <Boolean>
        Whether or not the authentication method is enabled for use.

    -mobileEnabled <Boolean>
        Whether or not the authentication method is available from the mobile application.

    -logoffUrl <String>
        The logoff page URL of the third-party server.

    -secondFactorAuth <String>
        Defines which second factor authentication to use when connecting to the Vault.
        An empty value will disable the second factor authentication.

    -signInLabel <String>
        Defines the sign-in text for this authentication method.
        Relevant only for CyberArk, RADIUS and LDAP authentication methods.

    -usernameFieldLabel <String>
        Defines the label of the username field for this authentication method.
        Relevant only for CyberArk, RADIUS, and LDAP authentication methods.

    -passwordFieldLabel <String>
        Defines the label of the password field for this authentication method.
        Relevant only for CyberArk, RADIUS, and LDAP authentication methods.

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Add-PASAuthenticationMethod -id SomeID -displayName SomeAuth -enabled $true

    Creates new authentication method.
