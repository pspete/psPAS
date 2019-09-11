---
title: Invoke-PASCPMOperation
---

## SYNOPSIS

Marks accounts for CPM Verify, Change or Reconcile operations

## SYNTAX

    Invoke-PASCPMOperation -AccountID <String> -VerifyTask

    Invoke-PASCPMOperation -AccountID <String> -VerifyTask -UseClassicAPI

    Invoke-PASCPMOperation -AccountID <String> -ChangeTask -ImmediateChangeByCPM <String>
    [-ChangeCredsForGroup <String>]

    Invoke-PASCPMOperation -AccountID <String> -ChangeTask [-ChangeEntireGroup <Boolean>] [-WhatIf]
    [-Confirm] [<CommonParameters>]

    Invoke-PASCPMOperation -AccountID <String> -ChangeTask -ChangeImmediately <Boolean>
    -NewCredentials <SecureString>


    Invoke-PASCPMOperation -AccountID <String> -ChangeTask -NewCredentials <SecureString>
    [-ChangeEntireGroup <Boolean>]

    Invoke-PASCPMOperation -AccountID <String> -ReconcileTask

## DESCRIPTION

Accounts Can be flagged for immediate verification, change or reconcile
Flags a managed account credentials for an immediate CPM password verification.

CPM Change Options:
Flags a managed account credentials for an immediate CPM password change.

- The "Initiate CPM password management operations" permission is required.

Sets a password to use for an account's next CPM change.

- The "Initiate CPM password management operations" & "Specify next password value" permission is required.

Updates the account's password only in the Vault (without affecting the credentials on the target device).

- The "Update password value" permission is required.

Verify & Reconcile both require "Initiate CPM password management operations"

## PARAMETERS

    -AccountID <String>
        The unique ID  of the account.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -VerifyTask [<SwitchParameter>]
        Initiates a verify task

        Required?                    true
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ChangeTask [<SwitchParameter>]
        Initiates a change task

        Required?                    true
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ReconcileTask [<SwitchParameter>]
        Initiates a reconcile task
        Requires CyberArk version 9.10+

        Required?                    true
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ChangeImmediately <Boolean>
        Whether or not the password will be changed immediately in the Vault.
        Only relevant when specifying a password value for the next CPM change.
        Requires CyberArk version 10.1+

        Required?                    true
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -NewCredentials <SecureString>
        Secure String value of the new account password that will be allocated to the account in
        the Vault.
        Only relevant when specifying a password value for the next CPM change, or updating the
        password only in the vault.
        Requires CyberArk version 10.1+

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ChangeEntireGroup <Boolean>
        Boolean value, dictating if all accounts that belong to the same group should have their
        passwords changed.
        This is only relevant for accounts that belong to an account group.
        Parameter will be ignored if account does not belong to a group.
        Applicable to immediate change via CPM, and password change in the vault only.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -ImmediateChangeByCPM <String>
        Yes/No value, dictating if the account will be scheduled for immediate change.
        Specify Yes to initiate a password change by CPM - Relevant for Classic API only.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -ChangeCredsForGroup <String>
        Yes/No value, dictating if all accounts that belong to the same group should
        have their passwords changed.
        This is only relevant for accounts that belong to an account group.
        Parameter will be ignored if account does not belong to a group.
        Relevant for Classic API only.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -UseClassicAPI [<SwitchParameter>]
        Specify to force verification via Classic API.

        Required?                    true
        Position?                    named
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

    PS C:\>Invoke-PASCPMOperation -AccountID $ID -VerifyTask

    Marks an account for verification




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Invoke-PASCPMOperation -AccountID $ID -VerifyTask -UseClassicAPI

    Marks an account for verification using the Classic API




    -------------------------- EXAMPLE 3 --------------------------

    PS C:\>Invoke-PASCPMOperation -AccountID $ID -ChangeTask -ImmediateChangeByCPM Yes

    Marks an account for immediate change using the Classic API




    -------------------------- EXAMPLE 4 --------------------------

    PS C:\>Invoke-PASCPMOperation -AccountID $ID -ChangeTask

    Marks an account for immediate change




    -------------------------- EXAMPLE 5 --------------------------

    PS C:\>Invoke-PASCPMOperation -AccountID $ID -ChangeTask -ChangeImmediately $true
    -NewCredentials $SecureString

    Marks an account for immediate change to the specified password value




    -------------------------- EXAMPLE 6 --------------------------

    PS C:\>Invoke-PASCPMOperation -AccountID $ID -ChangeTask -NewCredentials $SecureString

    Changes the password for the account in the Vault




    -------------------------- EXAMPLE 7 --------------------------

    PS C:\>Invoke-PASCPMOperation -AccountID $ID -ReconcileTask

    Marks an account for immediate reconcile
