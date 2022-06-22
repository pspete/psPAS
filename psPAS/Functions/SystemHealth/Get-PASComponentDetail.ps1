# .ExternalHelp psPAS-help.xml
Function Get-PASComponentDetail {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateSet('PVWA', 'SessionManagement', 'CPM', 'AIM')]
		[string]$ComponentID

	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 10.1
	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/api/ComponentsMonitoringDetails/$ComponentID"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If ($null -ne $result) {

			#output returned data
			$result | Select-Object -ExpandProperty ComponentsDetails

		}

	}#process

	END { }#end

}