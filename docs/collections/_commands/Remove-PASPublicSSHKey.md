---
title: Remove-PASPublicSSHKey
---

## SYNOPSIS

Deletes a specific Public SSH Key from a specific vault user.

## SYNTAX

    Remove-PASPublicSSHKey [-UserName] <String> [-KeyID] <String>

## DESCRIPTION

Deletes an authorized public SSH key for a specific user in the
Vault, preventing them from authenticating to the Vault through PSMP
using a corresponding private SSH key.

"Reset Users Passwords" Vault permission is required.

The authenticated user who runs this function must be in the same Vault
Location or higher as the user whose public SSH keys are deleted.

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

    -KeyID <String>
        The ID of the public SSH key to delete.

        Required?                    true
        Position?                    2
        Default value
        Accept pipeline input?       true (ByPropertyName)
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

    PS C:\>Remove-PASPublicSSHKey -UserName Splitter -KeyID 415161FE8F2B408BB76BC244258C3697

    Deletes specified ssh key from vault user "Splitter"
