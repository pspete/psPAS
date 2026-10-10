# .ExternalHelp psPAS-help.xml
function Set-PASPTARemediation {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$changePassword_SuspectedCredentialsTheft,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$changePassword_OverPassTheHash,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$reconcilePassword_SuspectedPasswordChange,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$pendAccount_UnmanagedPrivilegedAccount

	)

	begin {
		Assert-VersionRequirement -SelfHosted
		Assert-VersionRequirement -RequiredVersion 10.4

	}#begin

	process {

		#Get all parameters that will be sent in the request
		$boundParameters = $PSBoundParameters | Get-PASParameter

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/API/pta/API/Settings/AutomaticRemediations/"


		#Create body of request
		$body = $boundParameters | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess('PTA', 'Update Automatic Remediation Config')) {

			#send request to PAS web service
			Invoke-PASRestMethod -Uri $URI -Method PATCH -Body $Body | Out-Null

		}

	}#process

	end { }#end

}