---
title: Add-PASDiscoveredAccount
---

## SYNOPSIS

Adds discovered account or SSH key as a pending account in the accounts feed.

## SYNTAX

    Add-PASDiscoveredAccount -UserName <String> -Address <String> -discoveryDate <DateTime>
    -AccountEnabled <Boolean> [-osGroups <String>] [-platformType <String>] [-Domain <String>]
    [-lastLogonDateTime <DateTime>] [-lastPasswordSetDateTime <DateTime>]
    [-passwordNeverExpires <Boolean>] [-OSVersion <String>] [-privileged <String>]
    [-privilegedCriteria <String>] [-UserDisplayName <String>] [-description <String>]
    [-passwordExpirationDateTime <DateTime>] [-osFamily <String>]
    [-additionalProperties <Hashtable>] [-organizationalUnit <String>] [-SID <String>]
    [<CommonParameters>]

    Add-PASDiscoveredAccount -UserName <String> -Address <String> -discoveryDate <DateTime>
    -AccountEnabled <Boolean> [-osGroups <String>] [-platformType <String>] [-Domain <String>]
    [-lastLogonDateTime <DateTime>] [-lastPasswordSetDateTime <DateTime>]
    [-passwordNeverExpires <Boolean>] [-OSVersion <String>] [-privileged <String>]
    [-privilegedCriteria <String>] [-UserDisplayName <String>] [-description <String>]
    [-passwordExpirationDateTime <DateTime>] [-osFamily <String>]
    [-additionalProperties <Hashtable>] [-organizationalUnit <String>] [-uid <String>]
    [-gid <String>] -fingerprint <String> [-size <Int32>] [-path <String>] [-format <String>]
    [-comment <String>] [-encryption <String>] [<CommonParameters>]

    Add-PASDiscoveredAccount -UserName <String> -Address <String> -discoveryDate <DateTime>
    -AccountEnabled <Boolean> [-osGroups <String>] [-platformType <String>] [-Domain <String>]
    [-lastLogonDateTime <DateTime>] [-lastPasswordSetDateTime <DateTime>]
    [-passwordNeverExpires <Boolean>] [-OSVersion <String>] [-privileged <String>]
    [-privilegedCriteria <String>] [-UserDisplayName <String>] [-description <String>]
    [-passwordExpirationDateTime <DateTime>] [-osFamily <String>]
    [-additionalProperties <Hashtable>] [-organizationalUnit <String>] [-uid <String>]
    [-gid <String>] [<CommonParameters>]

## DESCRIPTION

Enables an account or SSH key that is discovered by an external scanner to be added
as a pending account to the Accounts Feed.

Users can identify privileged accounts and determine which are on-boarded to the vault.

## PARAMETERS

    -UserName <String>
        The name of the account user.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Address <String>
        The name or address of the machine where the account is located.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -discoveryDate <DateTime>
        The date the account was discovered.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AccountEnabled <Boolean>
        The state of the account, defined in the discovery source.

        Required?                    true
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -osGroups <String>
        The name of the group the account belongs to, such as Administrators or Operators.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -platformType <String>
        The platform where the discovered account is located.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Domain <String>
        The domain of the account.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -lastLogonDateTime <DateTime>
        The date this account was last logged into, defined in the discovery source.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -lastPasswordSetDateTime <DateTime>
        The date this password was last set, defined in the discovery source.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -passwordNeverExpires <Boolean>
        Whether or not this password expires, defined in the discovery source.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -OSVersion <String>
        The version of the OS where the account was discovered.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -privileged <String>
        Whether the discovered account is privileged or non-privileged.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -privilegedCriteria <String>
        The criteria that determines whether or not the discovered account is privileged.
        For example, the user or group name.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UserDisplayName <String>
        The user's display name.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -description <String>
        A description of the account, defined in the discovery source.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -passwordExpirationDateTime <DateTime>
        The expiration date of the account, defined in the discovery source.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -osFamily <String>
        The type of machine where the account was discovered.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -additionalProperties <Hashtable>
        List of name=value pairs for additional properties added to the account.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -organizationalUnit <String>
        The organizational unit where the account is defined.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -SID <String>
        Security ID. This parameter is relevant only for Windows accounts.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -uid <String>
        The unique user ID. This parameter is relevant only for Unix accounts.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -gid <String>
        The unique group ID. This parameter is relevant only for Unix accounts.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -fingerprint <String>
        The fingerprint of the discovered SSH key. The public and private keys of the same trust
        have the same fingerprint. This is relevant for SSH keys only.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -size <Int32>
        The size in bits of the generated key.

        Required?                    false
        Position?                    named
        Default value                0
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -path <String>
        The path of the public key on the target machine.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -format <String>
        The format of the private SSH key.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -comment <String>
        Any text added when the key was created.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -encryption <String>
        The type of encryption used to generate the SSH key.

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

    PS C:\>Add-PASDiscoveredAccount -UserName Discovered23 -Address domain.com
    -discoveryDate $(Get-Date "29/10/2018") -AccountEnabled $true
    -platformType "Windows Domain" -SID 12355

    Adds matching discovered account as pending account.
