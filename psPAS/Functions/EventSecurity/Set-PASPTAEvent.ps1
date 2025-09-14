# .ExternalHelp psPAS-help.xml
function Set-PASPTAEvent {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$EventID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet('OPEN', 'CLOSED')]
		[string]$mStatus

	)

	begin {
		Assert-VersionRequirement -SelfHosted
		Assert-VersionRequirement -RequiredVersion 11.3
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