# .ExternalHelp psPAS-help.xml
Function Get-PASComponentSummary {
	[CmdletBinding()]
	param(

	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 10.1
	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/ComponentsMonitoringSummary"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		If ($null -ne $result) {

			$result | Select-Object -ExpandProperty Components

			$result | Select-Object -ExpandProperty Vaults | Add-ObjectDetail -PropertyToAdd @{
				'ComponentID'   = 'EPV'
				'ComponentName' = 'EPV'
			} | Select-Object ComponentID, ComponentName, Role, IP, IsLoggedOn

		}

	}#process

	END { }#end

}