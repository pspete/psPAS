# .ExternalHelp psPAS-help.xml
function Get-PASAccountSSHKey {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('id')]
		[string]$AccountID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$Reason,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$TicketingSystem,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$TicketId,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[int]$Version,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet('retrieve')]
		[string]$ActionType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$isUse,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[switch]$Machine
	)

	begin {
		Assert-VersionRequirement -RequiredVersion 11.5
	}

	process {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/Accounts/$($AccountID | Get-EscapedString)/Secret/Retrieve"

		#Create request body
		$body = $PSBoundParameters | Get-PASParameter -ParametersToRemove AccountID | ConvertTo-Json

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

		if ($null -ne $result) {

			$result

		}
	}

	end { }

}