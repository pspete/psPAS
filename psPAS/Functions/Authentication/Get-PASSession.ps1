# .ExternalHelp psPAS-help.xml
function Get-PASSession {
	[CmdletBinding()]
	param( )

	BEGIN { }#begin

	PROCESS {

		#Calculate the time elapsed since the start of the session and include in return data
		if ($null -ne $psPASSession.StartTime) {
			$psPASSession.ElapsedTime = '{0:HH:mm:ss}' -f ([datetime]$($(Get-Date) - $($psPASSession.StartTime)).Ticks)
		} else { $psPASSession.ElapsedTime = $null }

		#Deep Copy the $psPASSession session object and return as psPAS Session type.
		Get-SessionClone -InputObject $psPASSession | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Session

	}#process

	END { }#end

}