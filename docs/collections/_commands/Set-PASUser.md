---
title: Set-PASUser
---

## SYNOPSIS

Updates a vault user

## SYNTAX

    Set-PASUser -id <Int32> -username <String> [-NewPassword <SecureString>] [-userType <String>] [-suspended <Boolean>] [-unAuthorizedInterfaces
    <String[]>] [-enableUser <Boolean>] [-authenticationMethod <String[]>] [-ChangePassOnNextLogon <Boolean>] [-passwordNeverExpires <Boolean>]
    [-distinguishedName <String>] [-vaultAuthorization <String[]>] [-ExpiryDate <DateTime>] [-Location <String>] [-workStreet <String>] [-workCity <String>]
    [-workState <String>] [-workZip <String>] [-workCountry <String>] [-homePage <String>] [-homeEmail <String>] [-businessEmail <String>] [-otherEmail
    <String>] [-homeNumber <String>] [-businessNumber <String>] [-cellularNumber <String>] [-faxNumber <String>] [-pagerNumber <String>] [-description
    <String>] [-FirstName <String>] [-MiddleName <String>] [-LastName <String>] [-street <String>] [-city <String>] [-state <String>] [-zip <String>]
    [-country <String>] [-title <String>] [-organization <String>] [-department <String>] [-profession <String>] [-WhatIf] [-Confirm] [<CommonParameters>]

    Set-PASUser -username <String> -NewPassword <SecureString> [-Email <String>] [-ChangePasswordOnTheNextLogon <Boolean>] [-ExpiryDate <DateTime>]
    [-UserTypeName <String>] [-Disabled <Boolean>] [-Location <String>] [-FirstName <String>] [-LastName <String>] [-UseClassicAPI] [-WhatIf] [-Confirm]
    [<CommonParameters>]

## DESCRIPTION

Updates an existing user in the vault
Appears to require all properties set on a user to be passed with the request.
Not passing a value to an already set property will result in it being cleared.

## PARAMETERS

    -id <Int32>
        The numeric id of the user to update.
        Requires CyberArk version 11.1+

        Required?                    true
        Position?                    named
        Default value                0
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -username <String>
        The name of the user to create in the vault

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -NewPassword <SecureString>
        A new password to set on the account, as a Secure String
        Must meet the password complexity requirements

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -userType <String>
        The user type
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -suspended <Boolean>
        The user suspension status
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -unAuthorizedInterfaces <String[]>
        The CyberArk interfaces that this user is not authorized to use.
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -enableUser <Boolean>
        Whether the user will be enabled upon creation.
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -authenticationMethod <String[]>
        The authentication method that the user will use to log on.
        Valid Values:
        "AuthTypePass", for CyberArk Authentication (default)
        "AuthTypeLDAP", for LDAP authentication
        "AuthTypeRADIUS", for RADIUS authentication
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Email <String>
        The user's email address

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ChangePassOnNextLogon <Boolean>
        Whether or not user will be forced to change password on first logon
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ChangePasswordOnTheNextLogon <Boolean>
        Whether or not user will be forced to change password on first logon

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -passwordNeverExpires <Boolean>
        Whether or not the user's password will expire
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -distinguishedName <String>
        The distinguished name of the user.
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -vaultAuthorization <String[]>
        The user permissions in the vault.
        To grant authorization to a user, the same authorization must be held by the account logged on to the API.
        Valid values:
        • AddSafes
        • AuditUsers
        • AddUpdateUsers
        • ResetUsersPasswords
        • ActivateUsers
        • AddNetworkAreas
        • ManageDirectoryMapping
        • ManageServerFileCategories
        • BackupAllSafes
        • RestoreAllSafes
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ExpiryDate <DateTime>
        Expiry Date to set on account.
        Default is Never

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UserTypeName <String>
        The Type of User to create.
        EPVUser type will be created by default.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Disabled <Boolean>
        Whether or not the user will be created as a disabled user
        Default is Enabled

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Location <String>
        The Vault Location where the user will be created
        Default location is "Root"

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -workStreet <String>
        Business Address detail for the user
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -workCity <String>
        Business Address detail for the user
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -workState <String>
        Business Address detail for the user
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -workZip <String>
        Business Address detail for the user
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -workCountry <String>
        Business Address detail for the user
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -homePage <String>
        The user's email address
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -homeEmail <String>
        The user's email address
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -businessEmail <String>
        The user's email address
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -otherEmail <String>
        The user's email address
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -homeNumber <String>
        The user's phone number
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -businessNumber <String>
        The user's phone number
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -cellularNumber <String>
        The user's phone number
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -faxNumber <String>
        The user's phone number
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -pagerNumber <String>
        The user's phone number
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -description <String>
        Description Text
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -FirstName <String>
        The user's first name

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -MiddleName <String>
        The User's Middle Name
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -LastName <String>
        The user's last name

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -street <String>
        Address detail for the user
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -city <String>
        Address detail for the user
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -state <String>
        Address detail for the user
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -zip <String>
        Address detail for the user
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -country <String>
        Address detail for the user
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -title <String>
        Personal detail for the user
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -organization <String>
        Personal detail for the user
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -department <String>
        Personal detail for the user
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -profession <String>
        Personal detail for the user
        Requires CyberArk version 11.1+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UseClassicAPI [<SwitchParameter>]
        Specify the UseClassicAPI to force usage the Classic (v9) API endpoint.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -WhatIf [<SwitchParameter>]

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -Confirm [<SwitchParameter>]

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>set-pasuser -UserName Bill -Disabled $true

    Disables vault user Bill
