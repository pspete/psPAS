# .ExternalHelp psPAS-help.xml
function Set-PASSafe {
	[CmdletBinding(SupportsShouldProcess,
		DefaultParameterSetName = "Update")]
	param(
		[Parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Update"
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Days"
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Versions"
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateScript( { $_ -notmatch ".*(\\|\/|:|\*|<|>|`"|\.|\||^\s).*" })]
		[ValidateLength(0, 28)]
		[string]$SafeName,

		[Parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateScript( { $_ -notmatch ".*(\\|\/|:|\*|<|>|`"|\.|\||^\s).*" })]
		[ValidateLength(0, 28)]
		[string]$NewSafeName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[ValidateLength(0, 100)]
		[string]$Description,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[boolean]$OLACEnabled,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[string]$ManagingCPM,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "Versions"
		)]
		[ValidateRange(1, 999)]
		[int]$NumberOfVersionsRetention,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "Days"
		)]
		[ValidateRange(1, 3650)]
		[int]$NumberOfDaysRetention
	)

	BEGIN { }#begin

	PROCESS {

		#Create URL for Request
		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Safes/$($SafeName |

            Get-EscapedString)"

		$BoundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove SafeName, NewSafeName

		if ($PSBoundParameters.ContainsKey("NewSafeName")) {
			$BoundParameters["SafeName"] = $PSBoundParameters["NewSafeName"]
		}

		#Create Request Body
		$body = @{
			"safe" = $BoundParameters

		} | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($SafeName, "Update Safe Properties")) {

			#Send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body -WebSession $Script:WebSession

			If ($null -ne $result) {

				$result.UpdateSafeResult | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Safe

			}

		}

	}#process

	END { }#end

}