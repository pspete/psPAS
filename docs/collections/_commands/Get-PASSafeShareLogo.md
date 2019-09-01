---
title: Get-PASSafeShareLogo
---

## SYNOPSIS

Returns details of configured SafeShare Logo

## SYNTAX

    Get-PASSafeShareLogo [-ImageType] <String> [<CommonParameters>]

## DESCRIPTION

Gets configuration details of logo displayed in the SafeShare WebGUI

## PARAMETERS

    -ImageType <String>
        The requested logo type: Square or Watermark.

        Required?                    true
        Position?                    1
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

    PS C:\>Get-PASSafeShareLogo -ImageType Square

    Retrieves Safe Share Logo
