---
title: Set-PASPTARule
---

## SYNOPSIS

Updates an existing Risky Activity rule to PTA

## SYNTAX

    Set-PASPTARule [-id] <String> [-category] <String> [-regex] <String>
    [-score] <Int32> [-description] <String> [-response] <String> [-active] <Boolean>

## DESCRIPTION

Updates an existing Risky Activity rule in the PTA server configuration.

## PARAMETERS

    -id <String>
        The unique ID of the rule.

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -category <String>
        The Category of the risky activity
        Valid values: SSH, WINDOWS, SCP, KEYSTROKES or SQL

        Required?                    true
        Position?                    2
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -regex <String>
        Risky activity in regex form.
        Must support all characters (including "/" and escaping characters)

        Required?                    true
        Position?                    3
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -score <Int32>
        Activity score.
        Number must be between 1 and 100

        Required?                    true
        Position?                    4
        Default value                0
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -description <String>
        Activity description.
        The field is mandatory but can be empty

        Required?                    true
        Position?                    5
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -response <String>
        Automatic response to be executed
        Valid Values: NONE, TERMINATE or SUSPEND

        Required?                    true
        Position?                    6
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -active <Boolean>
        Indicate if the rule should be active or disabled

        Required?                    true
        Position?                    7
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

    PS C:\>Set-PASPTARule -id 66 -category KEYSTROKES -regex '(*.)risky cmd(.*)' -score 65
    -description "Updated Rule" -response SUSPEND -active $true

    Updates rule 66 in PTA
