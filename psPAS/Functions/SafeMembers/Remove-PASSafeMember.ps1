# .ExternalHelp psPAS-help.xml
function Remove-PASSafeMember {
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'UseGen1API', Justification = 'False Positive')]
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$SafeName,

		[Alias('UserName')]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$MemberName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[switch]$UseGen1API
	)

	BEGIN { }#begin

	PROCESS {

		switch ($PSCmdlet.ParameterSetName) {

			'Gen1' {

				Assert-VersionRequirement -SelfHosted

				#Create URL for request
				$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Safes/$($SafeName |
					Get-EscapedString)/Members/$($MemberName | Get-EscapedString)/"

			}

			default {

				Assert-VersionRequirement -RequiredVersion 12.2

				#Create URL for request
				$URI = "$($psPASSession.BaseURI)/api/Safes/$($SafeName |
					Get-EscapedString)/Members/$($MemberName | Get-EscapedString)/"

			}

		}

		if ($PSCmdlet.ShouldProcess($SafeName, "Remove Safe Member '$MemberName'")) {

			#Send Delete request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE

		}

	}#process

	END { }#end

}