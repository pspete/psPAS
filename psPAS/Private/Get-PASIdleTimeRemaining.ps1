function Get-PASIdleTimeRemaining {
	<#
	.SYNOPSIS
	Calculates the time remaining before the current session is expected to idle-timeout

	.DESCRIPTION
	Uses the IdleTimeout value retrieved at logon, together with the time of the most recent
	request (or the session start time, if no request has been sent yet), to estimate how much
	time remains before the session is idle-timed out by the server.

	Returns $null if the IdleTimeout value, or a reference point to measure activity from, is
	not known.

	.EXAMPLE
	Get-PASIdleTimeRemaining

	Returns a TimeSpan representing the estimated time remaining before the session idle-times out.
	#>
	[CmdletBinding()]
	[OutputType([TimeSpan])]
	param( )

	process {

		if ($null -eq $psPASSession.IdleTimeout) { return $null }

		$LastActivity = if ($null -ne $psPASSession.LastCommandTime) { $psPASSession.LastCommandTime } else { $psPASSession.StartTime }

		if ($null -eq $LastActivity) { return $null }

		$Remaining = New-TimeSpan -Start (Get-Date) -End $LastActivity.AddMinutes($psPASSession.IdleTimeout)

		if ($Remaining.Ticks -lt 0) {
			$Remaining = New-TimeSpan
		}

		$Remaining

	}

}
