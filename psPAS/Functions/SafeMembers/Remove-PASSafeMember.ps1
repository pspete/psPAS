# .ExternalHelp psPAS-help.xml
function Remove-PASSafeMember {
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

				#Create URL for request
				$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Safes/$($SafeName |
					Get-EscapedString)/Members/$($MemberName | Get-EscapedString)"

			}

			default {

				Assert-VersionRequirement -RequiredVersion 12.2

				#Create URL for request
				$URI = "$Script:BaseURI/api/Safes/$($SafeName |
					Get-EscapedString)/members/$($MemberName | Get-EscapedString)"

			}

		}

		if ($PSCmdlet.ShouldProcess($SafeName, "Remove Safe Member '$MemberName'")) {

			#Send Delete request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE -WebSession $Script:WebSession

		}

	}#process

	END { }#end

}