---
title: Get-PASPublicSSHKey
---

## SYNOPSIS

Retrieves a user's SSH Keys.

## SYNTAX

    Get-PASPublicSSHKey [-UserName] <String> [<CommonParameters>]

## DESCRIPTION

Retrieves all public SSH keys that are authorized for a specific user.

The "Reset User Passwords" Vault permission is required to query public SSH Keys.

The authenticated user who runs the function must be in the same Vault
Location or higher as the user whose public SSH keys are retrieved.

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

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Get-PASPublicSSHKey -UserName user1

    Lists all SSH Keys for vault user - user1:

    UserName KeyID                            PublicSSHKey
    -------- -----                            ------------
    user1    415161FE8F2B408BB76BC244258C3697 ACABB3NzaC1kc3MAAACBAJ3hA...............
    user1    B6DCA4D54B2E93380F42DDCDB23EE52A AgreatNzaC1kc3MAAACBAJ3hB...............
    user1    D6374740D11A5F45992D80D80E97387A PHil0soPh3rkc3MAAACBAJ3hC...............
