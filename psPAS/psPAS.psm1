<#
.SYNOPSIS
Reads all required module files

.DESCRIPTION
Dot Sources each ps1 file under a module directory

.EXAMPLE
Import-Module ModuleFile.psm1

#>
[CmdletBinding()]
param()

#Get function files
Get-ChildItem $PSScriptRoot\ -Recurse -Include "*.ps1" -Exclude "*.ps1xml" |

ForEach-Object {

	Try {

		$ErrorActionPreference = "Stop"
		$FunctionFile = $_.fullname
		# Dot Source each file
		. (
			[scriptblock]::Create(
				[io.file]::ReadAllText($FunctionFile, [Text.Encoding]::UTF8)
			)
		)

	} Catch {

		throw "Failed to import function $FunctionFile"

	}

}