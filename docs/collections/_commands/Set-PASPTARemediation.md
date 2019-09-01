---
title: Set-PASPTARemediation
---

## SYNOPSIS

Updates automatic remediation settings in PTA

## SYNTAX

    Set-PASPTARemediation [[-changePassword_SuspectedCredentialsTheft] <Boolean>]
    [[-changePassword_OverPassTheHash] <Boolean>]
    [[-reconcilePassword_SuspectedPasswordChange] <Boolean>]
    [[-pendAccount_UnmanagedPrivilegedAccount] <Boolean>]

## DESCRIPTION

Updates automatic remediation settings configured in PTA

## PARAMETERS

    -changePassword_SuspectedCredentialsTheft <Boolean>
        Indicate if Change Password on Suspected Credential Theft the command is active

        Required?                    false
        Position?                    1
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -changePassword_OverPassTheHash <Boolean>
        Indicate if the Change Password on Over Pass The Hash command is active

        Required?                    false
        Position?                    2
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -reconcilePassword_SuspectedPasswordChange <Boolean>
        Indicate if the Reconcile Password on Suspected Password Change command is active

        Required?                    false
        Position?                    3
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -pendAccount_UnmanagedPrivilegedAccount <Boolean>
        Indicate if the Add Unmanaged Accounts to Pending Accounts command is active

        Required?                    false
        Position?                    4
        Default value                False
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

    PS C:\>Set-PASPTARemediation -changePassword_SuspectedCredentialsTheft $true

    Enables the "Change password on Suspected Credentials Theft" rule.




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Set-PASPTARemediation -reconcilePassword_SuspectedPasswordChange $false

    Disables the "reconcile on suspected password change" rule.
