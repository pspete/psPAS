﻿<#
.SYNOPSIS

.DESCRIPTION

.EXAMPLE

.INPUTS

.OUTPUTS
#>
[CmdletBinding()]
param(

	[bool]$DotSourceModule = $false

)

#Enum Flag values for Directory Mapping Authorizations
[Flags()]enum Authorizations{
	AddUpdateUsers = 1
	AddSafes = 2
	AddNetworkAreas = 4
	ManageServerFileCategories = 16
	AuditUsers = 32
	BackupAllSafes = 512
	RestoreAllSafes = 1024
	ResetUsersPasswords = 8388608
	ActivateUsers = 16777216
}

#Get function files
Get-ChildItem $PSScriptRoot\ -Recurse -Include '*.ps1' -Exclude '*.ps1xml' |

	ForEach-Object {

		if ($DotSourceModule) {
			. $_.FullName
		} else {
			$ExecutionContext.InvokeCommand.InvokeScript(
				$false,
				(
					[scriptblock]::Create(
						[io.file]::ReadAllText(
							$_.FullName,
							[Text.Encoding]::UTF8
						)
					)
				),
				$null,
				$null
			)

		}

	}

[System.Version]$Version = '0.0'
Set-Variable -Name ExternalVersion -Value $Version -Scope Script