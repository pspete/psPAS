#region Loader
<#
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

#Get function files
Get-ChildItem -Path "$PSScriptRoot\Private", "$PSScriptRoot\Public" -Recurse -Filter '*.ps1' |

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
#endregion Loader

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

# Script scope session object for session data
$psPASSession = [ordered]@{
	BaseURI                 = $null
	ApiURI                  = $null
	User                    = $null
	ExternalVersion         = [System.Version]'0.0'
	WebSession              = $null
	StartTime               = $null
	ElapsedTime             = $null
	LastCommand             = $null
	LastCommandTime         = $null
	LastCommandResults      = $null
	LastError               = $null
	LastErrorTime           = $null
	AccountSearchProperties = $null
	IdleTimeout             = $null
	SessionTimeRemaining    = $null
	SessionWarningThreshold = 5
} | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Session

New-Variable -Name psPASSession -Value $psPASSession -Scope Script -Force
