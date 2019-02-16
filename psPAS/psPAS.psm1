<#
.SYNOPSIS

.DESCRIPTION

.EXAMPLE

.INPUTS

.OUTPUTS

.NOTES

.LINK

#>
[CmdletBinding()]
param(

	[bool]$DotSourceModule = $false

)

#Get function files
Write-Verbose $PSScriptRoot

Get-ChildItem $PSScriptRoot\ -Recurse -Filter "*.ps1" -Exclude "*.ps1xml" |

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