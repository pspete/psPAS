# .ExternalHelp psPAS-help.xml
function Get-PASSession {
	[CmdletBinding()]
	param( )

	BEGIN { }#begin

	PROCESS {

		[PSCustomObject]@{
			User            = Get-PASLoggedOnUser -ErrorAction Stop | Select-Object -ExpandProperty Username
			BaseURI         = $Script:BaseURI
			ExternalVersion = $Script:ExternalVersion
			WebSession      = $Script:WebSession
		} | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Session

	}#process

	END { }#end

}