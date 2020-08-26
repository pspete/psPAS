# .ExternalHelp psPAS-help.xml
function Remove-PASUser {
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = "11.1")]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11.1"
		)]
		[int]$id,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "legacy"
		)]
		[string]$UserName
	)

	BEGIN {

		If ($PSCmdlet.ParameterSetName -ne "legacy") {

			Assert-VersionRequirement -RequiredVersion $PSCmdlet.ParameterSetName

		}

	}#begin

	PROCESS {

		switch ($PSCmdlet.ParameterSetName) {

			"11.1" {

				$URI = "$Script:BaseURI/api/Users/$id"

				break

			}

			default {

				#Create URL for request
				$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Users/$($UserName | Get-EscapedString)"

				break

			}

		}

		if ($PSCmdlet.ShouldProcess($UserName, "Delete User")) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE -WebSession $Script:WebSession

		}

	}#process

	END { }#end
}