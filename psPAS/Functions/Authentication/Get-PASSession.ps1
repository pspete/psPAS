# .ExternalHelp psPAS-help.xml
function Get-PASSession {
	[CmdletBinding()]
	param( )

	BEGIN { }#begin

	PROCESS {

		if ($null -ne $psPASSession.StartTime) {
			$psPASSession.ElapsedTime = '{0:HH:mm:ss}' -f ([datetime]$($(Get-Date) - $($psPASSession.StartTime)).Ticks)
		}
		$psPASSession

	}#process

	END { }#end

}