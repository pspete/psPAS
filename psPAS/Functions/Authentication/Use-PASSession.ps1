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

	begin { }#begin

	process {

		New-Variable -Name psPASSession -Value $Session -Scope Script -Force

	}#process

	end { }#end

}