function Initialize-PASSession {
	<#
	.SYNOPSIS
	Completes the psPAS session after a successful logon

	.DESCRIPTION
	psPAS helper function.
	Records the CyberArk version in the psPAS module scope, and resolves the authenticated user and server idle session timeout.

	.PARAMETER ExternalVersion
	The CyberArk version.

	.PARAMETER Credential
	The logon credential, used to determine the user name if the authenticated user cannot be resolved.

	.PARAMETER RequireUser
	Throw if the authenticated user cannot be resolved.

	.EXAMPLE
	Initialize-PASSession -ExternalVersion 14.0 -Credential $Credential
	#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true
		)]
		[System.Version]$ExternalVersion,

		[parameter(
			Mandatory = $false
		)]
		[PSCredential]$Credential,

		[parameter(
			Mandatory = $false
		)]
		[switch]$RequireUser
	)

	process {

		#Version information available in module scope.
		$psPASSession.ExternalVersion = $ExternalVersion

		$User = $null

		try {

			#Get Authenticated User.
			$User = Get-PASLoggedOnUser -ErrorAction Stop

		} catch {

			if ($RequireUser) {
				throw
			}

			$User = $Credential

		} finally {

			if ($null -ne $User) {
				$psPASSession.User = $User | Select-Object -ExpandProperty UserName
			} else { $psPASSession.User = $null }

		}

		try {

			#Get the idle session timeout (minutes) configured on the server.
			$psPASSession.IdleTimeout = Get-PASSessionTimeout -ErrorAction Stop | Select-Object -ExpandProperty Timeout

		} catch { $psPASSession.IdleTimeout = $null }

	}

}
