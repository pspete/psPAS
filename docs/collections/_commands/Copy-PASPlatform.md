---
title: Copy-PASPlatform
---

## SYNOPSIS

    Duplicates a platform

## SYNTAX

    Copy-PASPlatform -TargetPlatform -ID <Int32> -name <String> [-description <String>] [-WhatIf] [-Confirm] [<CommonParameters>]

    Copy-PASPlatform -DependentPlatform -ID <Int32> -name <String> [-description <String>] [-WhatIf] [-Confirm] [<CommonParameters>]

    Copy-PASPlatform -GroupPlatform -ID <Int32> -name <String> [-description <String>] [-WhatIf] [-Confirm] [<CommonParameters>]

    Copy-PASPlatform -RotationalGroup -ID <Int32> -name <String> [-description <String>] [-WhatIf] [-Confirm] [<CommonParameters>]

## DESCRIPTION

    Duplicates target, dependent, group or rotational group platform to a new platform.

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
        The unique ID number of the platofrm to duplicate

    -name <String>
        The name for the duplicate platform

    -description <String>
        A description for the duplicate platform

    -WhatIf [<SwitchParameter>]

    -Confirm [<SwitchParameter>]

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS > Copy-PASPlatform -TargetPlatform -ID 9 -name SomeNewPlatform -description "Some Description"

    Duplicates Target Platform with ID of 9 to SomeNewPlatform




    -------------------------- EXAMPLE 2 --------------------------

    PS > Copy-PASPlatform -DependentPlatform -ID 9 -name SomeNewPlatform -description "Some Description"

    Duplicates Dependent Platform with ID of 9 to SomeNewPlatform




    -------------------------- EXAMPLE 3 --------------------------

    PS > Copy-PASPlatform -GroupPlatform -ID 39 -name SomeNewPlatform -description "Some Description"

    Duplicates Group Platform with ID of 39 to SomeNewPlatform




    -------------------------- EXAMPLE 4 --------------------------

    PS > Copy-PASPlatform -RotationalGroup -ID 59 -name SomeNewPlatform -description "Some Description"

    Duplicates Rotational Group Platform with ID of 59 to SomeNewPlatform