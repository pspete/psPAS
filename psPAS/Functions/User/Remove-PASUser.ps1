# .ExternalHelp psPAS-help.xml
function Remove-PASUser {
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'Gen2')]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[int]$id,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[string]$UserName
	)

	BEGIN {

		If ($PSCmdlet.ParameterSetName -eq 'Gen2') {

			Assert-VersionRequirement -RequiredVersion 11.1

		}

	}#begin

	PROCESS {

		switch ($PSCmdlet.ParameterSetName) {

			'Gen2' {

				$URI = "$($psPASSession.BaseURI)/api/Users/$id"

				$User = $id

				break

			}

			default {

				Assert-VersionRequirement -MaximumVersion 12.3

				#Create URL for request
				$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Users/$($UserName | Get-EscapedString)"

				$User = $UserName

				break

			}

		}

		if ($PSCmdlet.ShouldProcess($User, 'Delete User')) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE

		}

	}#process

	END { }#end

}