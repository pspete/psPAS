# .ExternalHelp psPAS-help.xml
function Set-PASPTAEvent {
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = '11.3')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = '11.3'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = '14.0'
		)]
		[string]$EventID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = '11.3'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = '14.0'
		)]
		[ValidateSet('OPEN', 'CLOSED')]
		[string]$mStatus,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = '14.0'
		)]
		[ValidateSet('HANDLED', 'NOTREAL', 'OTHER', 'NONE')]
		[string]$closeReason,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = '14.0'
		)]
		[ValidateLength(0, 100)]
		[string]$reasonText

	)

	begin {
		Assert-VersionRequirement -SelfHosted
		Assert-VersionRequirement -RequiredVersion $PSCmdlet.ParameterSetName
	}#begin

	process {

		#Create request URL
		$URI = "$($psPASSession.BaseURI)/API/pta/API/Events/$EventID"

		#Get Parameters to include in request
		$Body = $PSBoundParameters | Get-PASParameter -ParametersToRemove EventID | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($EventID, 'Update Event Status')) {

			#Send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method PATCH -Body $Body

		}

		if ($null -ne $result) {

			#Return Results
			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.PTA.Event

		}

	}#process

	end { }#end

}