---
title: Remove-PASPlatform
---

## SYNOPSIS

    Deletes a platform.

## SYNTAX

    Remove-PASPlatform -TargetPlatform -ID <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]

    Remove-PASPlatform -DependentPlatform -ID <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]

    Remove-PASPlatform -GroupPlatform -ID <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]

    Remove-PASPlatform -RotationalGroup -ID <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]

## DESCRIPTION

    Deletes, target, dependent, group or rotational group platform.

## PARAMETERS

    -TargetPlatform [<SwitchParameter>]
        Specify if ID relates to Target platform

    -DependentPlatform [<SwitchParameter>]
        Specify if ID relates to Dependent platform

    -GroupPlatform [<SwitchParameter>]
        Specify if ID relates to Group platform

    -RotationalGroup [<SwitchParameter>]
        Specify if ID relates to Rotational Group platform

    -ID <Int32>
        The unique ID number of the platofrm to delete.

    -WhatIf [<SwitchParameter>]

    -Confirm [<SwitchParameter>]

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS > Remove-PASPlatform -TargetPlatform -ID 9

    Deletes Target Platform with ID of 9




    -------------------------- EXAMPLE 2 --------------------------

    PS > Remove-PASPlatform -DependentPlatform -ID 9

    Deletes Dependent Platform with ID of 9




    -------------------------- EXAMPLE 3 --------------------------

    PS > Remove-PASPlatform -GroupPlatform -ID 39

    Deletes Group Platform with ID of 39




    -------------------------- EXAMPLE 4 --------------------------

    PS > Remove-PASPlatform -RotationalGroup -ID 59

    Deletes Rotational Group Platform with ID of 59
