# .ExternalHelp psPAS-help.xml
function Use-PASSession {
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