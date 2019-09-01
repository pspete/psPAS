---
title: Add-PASPublicSSHKey
---

## SYNOPSIS

Adds an authorised public SSH key foraspecific user in the Vault.

## SYNTAX

    Add-PASPublicSSHKey [-UserName] <String> [-PublicSSHKey] <String> [<CommonParameters>]

## DESCRIPTION

Adding an authorised public SSH key to a vault user allows the user
to authenticate to the Vault through PSMP using a corresponding private SSH key.

The "Reset User Passwords" Permission is required in the vault to manage public SSH keys.

The user account used to add the key MUST be in the same Vault Location or higher
then the user whose public SSH keys are added.

A user cannot manage their own public SSH keys.

## PARAMETERS

    -UserName <String>
        The username of the Vault user whose public SSH keys will be added
        A username cannot contain te follwing characters: "%", "&", "+" or ".".

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -PublicSSHKey <String>
        The content of the public SSH key as it appears in the authorized_keys file.
        The key must not include new lines ('\n').
        Do not include options such as "command", as they are not supported when
        authenticating through PSMP.
        This key can only include comments in English.

        Required?                    true
        Position?                    2
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

    PS C:\>Add-PASPublicSSHKey -UserName keyUser -PublicSSHKey
    AAAAB3NzaC1kc3MAAACBAJ3hB5SAF6mBXPlZlRoJEZi0KSIN+NU2iGiaXZXi9CDrgVxp6/andonandonandOON==

    Adds SSH Key to vault user keyUser
