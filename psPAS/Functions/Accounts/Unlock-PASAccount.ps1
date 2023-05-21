# .ExternalHelp psPAS-help.xml
function Unlock-PASAccount {
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'CheckIn')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('id')]
		[string]$AccountID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'CheckIn'
		)]
		[switch]$CheckIn,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Unlock'
		)]
		[switch]$Unlock
	)

	BEGIN { }#begin

	PROCESS {

		switch ($PSCmdlet.ParameterSetName) {

			'CheckIn' {

				#Create URL for request
				$URI = "$Script:BaseURI/API/Accounts/$AccountID/CheckIn"
				break

			}

			'Unlock' {

				#Tested but not verified/documented
				Assert-VersionRequirement -RequiredVersion 12.2

				#Create URL for request
				$URI = "$Script:BaseURI/API/Accounts/$AccountID/Unlock"
				break

			}

		}


		if ($PSCmdlet.ShouldProcess($AccountID, "$($PSCmdlet.ParameterSetName) Account")) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method POST -WebSession $Script:WebSession

		}

	}#process

	END { }#end

}