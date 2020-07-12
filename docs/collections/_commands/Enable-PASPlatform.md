---
title: Enable-PASPlatform
---

## SYNOPSIS

    Activates a platform.

## SYNTAX

    Enable-PASPlatform -TargetPlatform -ID <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]

    Enable-PASPlatform -GroupPlatform -ID <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]

    Enable-PASPlatform -RotationalGroup -ID <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]

## DESCRIPTION

    Enables, target, group or rotational group platform.

## PARAMETERS

    -TargetPlatform [<SwitchParameter>]
        Specify if ID relates to Target platform

    -GroupPlatform [<SwitchParameter>]
        Specify if ID relates to Group platform

    -RotationalGroup [<SwitchParameter>]
        Specify if ID relates to Rotational Group platform

    -ID <Int32>
        The unique ID number of the platofrm to enable.

    -WhatIf [<SwitchParameter>]

    -Confirm [<SwitchParameter>]

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS > Enable-PASPlatform -TargetPlatform -ID 53

    Enables Target Platform with ID of 53




    -------------------------- EXAMPLE 2 --------------------------

    PS > Enable-PASPlatform -GroupPlatform -id 64

    Enables Group Platform with ID of 64




    -------------------------- EXAMPLE 3 --------------------------

    PS > Enable-PASPlatform -RotationalGroup -id 65

    Enables Rotational Group Platform with ID of 65