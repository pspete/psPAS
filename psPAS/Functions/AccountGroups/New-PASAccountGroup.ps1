# .ExternalHelp psPAS-help.xml
function New-PASAccountGroup {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$GroupName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$GroupPlatformID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$Safe
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 9.9.5
	}#begin

	PROCESS {

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/API/AccountGroups/"

		#Create body of request
		$body = $PSBoundParameters | Get-PASParameter | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($GroupName, 'Define New Account Group')) {

			#send request to PAS web service
			Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	END { }#end

}