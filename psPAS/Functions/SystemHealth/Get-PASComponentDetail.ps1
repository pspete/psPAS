# .ExternalHelp psPAS-help.xml
Function Get-PASComponentDetail {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateSet('PVWA', 'SessionManagement', 'CPM', 'AIM', 'PTA')]
		[string]$ComponentID

	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 10.1
	}#begin

	PROCESS {

		if ($PSBoundParameters['ComponentID'] -eq 'PTA') {

			Assert-VersionRequirement -RequiredVersion 12.0
			Assert-VersionRequirement -SelfHosted

		}

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/ComponentsMonitoringDetails/$ComponentID"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		If ($null -ne $result) {

			#output returned data
			$result | Select-Object -ExpandProperty ComponentsDetails

		}

	}#process

	END { }#end

}