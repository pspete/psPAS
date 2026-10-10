# .ExternalHelp psPAS-help.xml
function Get-PASSession {
	[CmdletBinding()]
	param( )

	begin { }#begin

	process {

		#Calculate the time elapsed since the start of the session and include in return data
		if ($null -ne $psPASSession.StartTime) {
			$psPASSession.ElapsedTime = '{0:HH:mm:ss}' -f ([datetime]$($(Get-Date) - $($psPASSession.StartTime)).Ticks)
		} else { $psPASSession.ElapsedTime = $null }

		#Calculate the time remaining until the session is expected to idle-timeout, based on the
		#idle timeout value retrieved at logon and the time of the most recent request.
		$psPASSession.SessionTimeRemaining = Get-PASIdleTimeRemaining

		#Deep Copy the $psPASSession session object and return as psPAS Session type.
		Get-SessionClone -InputObject $psPASSession | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Session

	}#process

	end { }#end

}