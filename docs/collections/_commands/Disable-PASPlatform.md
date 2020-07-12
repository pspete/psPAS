---
title: Disable-PASPlatform
---

## SYNOPSIS

    Deactivates a platform.

## SYNTAX

    Disable-PASPlatform -TargetPlatform -ID <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]

    Disable-PASPlatform -GroupPlatform -ID <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]

    Disable-PASPlatform -RotationalGroup -ID <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]

## DESCRIPTION

    Disables, target, group or rotational group platform.

## PARAMETERS

    -TargetPlatform [<SwitchParameter>]
        Specify if ID relates to Target platform

    -GroupPlatform [<SwitchParameter>]
        Specify if ID relates to Group platform

    -RotationalGroup [<SwitchParameter>]
        Specify if ID relates to Rotational Group platform

    -ID <Int32>
        The unique ID number of the platofrm to disable.

    -WhatIf [<SwitchParameter>]

    -Confirm [<SwitchParameter>]

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS > Disable-PASPlatform -TargetPlatform -ID 53

    Disables Target Platform with ID of 53




    -------------------------- EXAMPLE 2 --------------------------

    PS > Disable-PASPlatform -GroupPlatform -id 64

    Disables Group Platform with ID of 64




    -------------------------- EXAMPLE 3 --------------------------

    PS > Disable-PASPlatform -RotationalGroup -id 65

    Disables Rotational Group Platform with ID of 65
