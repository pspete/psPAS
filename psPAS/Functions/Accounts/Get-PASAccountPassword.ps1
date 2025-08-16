# .ExternalHelp psPAS-help.xml
function Get-PASAccountPassword {
	[CmdletBinding(DefaultParameterSetName = 'Gen2')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[Alias('id')]
		[string]$AccountID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = 'Gen1'
		)]
		[Alias('UseClassicAPI')]
		[switch]$UseGen1API,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = 'Gen2'
		)]
		[string]$Reason,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = 'Gen2'
		)]
		[string]$TicketingSystem,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = 'Gen2'
		)]
		[string]$TicketId,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = 'Gen2'
		)]
		[int]$Version,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = 'Gen2'
		)]
		[ValidateSet('show', 'copy', 'connect')]
		[string]$ActionType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = 'Gen2'
		)]
		[boolean]$isUse,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = 'Gen2'
		)]
		[string]$Machine,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[String]$UserName
	)

	BEGIN {

	}#begin

	PROCESS {

		#Build Request
		switch ($PSCmdlet.ParameterSetName) {

			'Gen2' {

				Assert-VersionRequirement -RequiredVersion 10.1

				#For Version 10.1+
				$Request = @{

					'URI'    = "$($psPASSession.BaseURI)/api/Accounts/$($AccountID | Get-EscapedString)/Password/Retrieve"

					'Method' = 'POST'

					#Get all parameters that will be sent in the request
					'Body'   = $PSBoundParameters | Get-PASParameter -ParametersToRemove AccountID, UserName | ConvertTo-Json

				}

				break

			}

			'Gen1' {

				#For Version 9.7+
				$Request = @{

					'URI'    = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Accounts/$($AccountID | Get-EscapedString)/Credentials"

					'Method' = 'GET'

				}

				break

			}

		}

		#Add default Request parameters
		$Request.Add('WebSession', $($psPASSession.WebSession))

		#splat request to web service
		$result = Invoke-PASRestMethod @Request

		If ($null -ne $result) {

			switch ($PSCmdlet.ParameterSetName) {

				'Gen1' {

					$result = [System.Text.Encoding]::ASCII.GetString([PSCustomObject]$result.Content)

					break

				}

				'Gen2' {

					#convert the result from json
                    $result = ConvertFrom-Json $result

					#Get UserName if parameter value not provided.
					if ($PSBoundParameters.Keys -notcontains 'UserName') {

						$UserName = Get-PASAccount -id $AccountID -ErrorAction SilentlyContinue |
							Select-Object -ExpandProperty UserName

					}

					break

				}

			}

			[PSCustomObject]@{
				'Password' = $result
				'UserName' = $UserName
			} | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Credential

		}

	}#process

	END { }#end

}
