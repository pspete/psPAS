Function ConvertTo-UnixTime {
	<#
.SYNOPSIS
Returns UnixTime of a given date.

.DESCRIPTION
Returns UnixTime as a whole number.

.PARAMETER Date
A DateTime object to return the UnixTime of.

.EXAMPLE
Get-Date | ConvertTo-UnixTime

#>
	[CmdletBinding()]
	[OutputType('System.Integer')]
	Param(
		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[DateTime]$Date,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false
		)]
		[switch]$Milliseconds
	)

	Process {
		$UnixTime = [math]::Round($(Get-Date $Date.ToLocalTime() -UFormat %s))

		If ($Milliseconds) {
			$UnixTime = $UnixTime * 1000
		}

		$UnixTime
	}
}