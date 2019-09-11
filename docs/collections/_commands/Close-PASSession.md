---
title: Close-PASSession
---

## SYNOPSIS

Logoff from CyberArk Vault.

## SYNTAX

    Close-PASSession [<CommonParameters>]

    Close-PASSession [-UseClassicAPI] [<CommonParameters>]

    Close-PASSession [-SharedAuthentication] [<CommonParameters>]

    Close-PASSession [-SAMLAuthentication] [<CommonParameters>]

## DESCRIPTION

Performs Logoff and removes the Vault session.

## PARAMETERS

    -UseClassicAPI [<SwitchParameter>]
        Specify the UseClassicAPI switch to send the authentication request via the Classic (v9)
        API endpoint.
        Relevant for CyberArk versions earlier than 10.4

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -SharedAuthentication [<SwitchParameter>]
        Specify the SharedAuthentication switch to logoff from a shared authentication session

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -SAMLAuthentication [<SwitchParameter>]
        Specify the SAMLAuthentication switch to logoff from a session authenticated to with SAML

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

    PS C:\>Close-PASSession

    Logs off from the session related to the authorisation token.




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Close-PASSession -SAMLAuthentication

    Logs off from the session related to the authorisation token using the SAML Authentication API
    endpoint.




    -------------------------- EXAMPLE 3 --------------------------

    PS C:\>Close-PASSession -SharedAuthentication

    Logs off from the session related to the authorisation token using the Shared Authentication API
    endpoint.




    -------------------------- EXAMPLE 4 --------------------------

    PS C:\>Close-PASSession -UseClassicAPI

    Logs off from the session related to the authorisation token using the Classic API endpoint.
