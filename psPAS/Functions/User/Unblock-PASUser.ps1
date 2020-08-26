# .ExternalHelp psPAS-help.xml
function Unblock-PASUser {

	[CmdletBinding(DefaultParameterSetName = "10.10")]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10.10"
		)]
		[int]$id,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "ClassicAPI"
		)]
		[string]$UserName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "ClassicAPI"
		)]
		[ValidateSet($false)]
		[boolean]$Suspended
	)

	BEGIN {

		$Request = @{"WebSession" = $Script:WebSession }

	}#begin

	PROCESS {

		switch ($PSCmdlet.ParameterSetName) {

			"10.10" {

				Assert-VersionRequirement -RequiredVersion $PSCmdlet.ParameterSetName

				#Create request
				$Request["URI"] = "$Script:BaseURI/api/Users/$id/Activate"
				$Request["Method"] = "POST"

				break

			}

			"ClassicAPI" {

				#Create request
				$Request["URI"] = "$Script:BaseURI/WebServices/PIMServices.svc/Users/$($UserName | Get-EscapedString)"
				$Request["Method"] = "PUT"
				$Request["Body"] = $PSBoundParameters | Get-PASParameter -ParametersToRemove UserName | ConvertTo-Json

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