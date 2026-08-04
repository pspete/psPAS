# .ExternalHelp psPAS-help.xml
function Get-PASServer {
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'UseGen1API', Justification = 'False Positive')]
	[CmdletBinding(DefaultParameterSetName = 'Gen2')]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ParameterSetName = 'Gen1'
		)]
		[switch]$UseGen1API

	)

	begin { }#begin

	process {

		switch ($PSCmdlet.ParameterSetName) {

			'Gen1' {

				Assert-VersionRequirement -SelfHosted

				#Create URL for request
				$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Server"

				break

			}

			'Gen2' {

				#Create URL for request
				$URI = "$($psPASSession.BaseURI)/api/server"

				break

			}

		}

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($null -ne $result) {

			$result

		}

	}#process

	end { }#end

}
