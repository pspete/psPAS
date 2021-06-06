# .ExternalHelp psPAS-help.xml
function Get-PASSession {
	[CmdletBinding()]
	param( )

	BEGIN { }#begin

	PROCESS {

		Try {

			$UserName = Get-PASLoggedOnUser -ErrorAction Stop | Select-Object -ExpandProperty Username

		} Catch { $UserName = $null }

		[PSCustomObject]@{
			User            = $UserName
			BaseURI         = $Script:BaseURI
			ExternalVersion = $Script:ExternalVersion
			WebSession      = $Script:WebSession
		} | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Session

	}#process

	END { }#end

}