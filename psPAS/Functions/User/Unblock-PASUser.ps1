# .ExternalHelp psPAS-help.xml
function Unblock-PASUser {

	[CmdletBinding(DefaultParameterSetName = 'Gen2')]
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
		[string]$UserName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = 'Gen1'
		)]
		[ValidateSet($false)]
		[boolean]$Suspended
	)

	BEGIN {

		$Request = @{'WebSession' = $psPASSession.WebSession }

	}#begin

	PROCESS {

		switch ($PSCmdlet.ParameterSetName) {

			'Gen2' {

				Assert-VersionRequirement -RequiredVersion 10.10

				#Create request
				$Request['URI'] = "$($psPASSession.BaseURI)/api/Users/$id/Activate"
				$Request['Method'] = 'POST'

				break

			}

			'Gen1' {

				Assert-VersionRequirement -MaximumVersion 12.3

				#Create request
				$Request['URI'] = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Users/$($UserName | Get-EscapedString)"
				$Request['Method'] = 'PUT'
				$Request['Body'] = $PSBoundParameters | Get-PASParameter -ParametersToRemove UserName | ConvertTo-Json

				break

			}
		}

		#send request to web service
		$result = Invoke-PASRestMethod @Request

		If ($null -ne $result) {

			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.User

		}

	}#process

	END { }#end

}