# .ExternalHelp psPAS-help.xml
function Unlock-PASAccount {
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'CheckIn', Justification = 'Parameter used for ParameterSet function logic')]
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'Unlock', Justification = 'Parameter used for ParameterSet function logic')]
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
				$URI = "$($psPASSession.BaseURI)/API/Accounts/$AccountID/CheckIn"
				break

			}

			'Unlock' {

				#*Assumed working for 11.6+ (not verified/tested for all versions)
				Assert-VersionRequirement -RequiredVersion 11.6

				#Create URL for request
				$URI = "$($psPASSession.BaseURI)/API/Accounts/$AccountID/Unlock"
				break

			}

		}


		if ($PSCmdlet.ShouldProcess($AccountID, "$($PSCmdlet.ParameterSetName) Account")) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method POST

		}

	}#process

	END { }#end

}