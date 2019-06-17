function Use-PASSession {
	<#
	.SYNOPSIS
	Sets module scope variables allowing saved session information to be used for future requests.

	.DESCRIPTION
	Use session data (BaseURI, ExternalVersion, WebSession (containing Authorization Header)) for future requests.
	psPAS uses variables in the Module scope to provide required values to all module functions, use this function to
	set the required values in the module scope, using session information returned from `Get-PASSession`.

	.EXAMPLE
	Use Saved Session Data for future requests

	Use-PASSession -Session $Session

	.EXAMPLE
	Save current session, switch to using different session details, switch back to original session.

	$CurrentSession = Get-PASSession

	Use-PASSession -Session $OtherSession
	...
	Use-PASSession -Session $CurrentSession

	#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[psTypeName('psPAS.CyberArk.Vault.Session')]$Session

	)

	BEGIN { }#begin

	PROCESS {

		Set-Variable -Name BaseURI -Value $Session.BaseURI -Scope Script
		Set-Variable -Name ExternalVersion -Value $Session.ExternalVersion -Scope Script
		Set-Variable -Name WebSession -Value $Session.WebSession -Scope Script

	}#process

	END { }#end

}
