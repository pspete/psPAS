# .ExternalHelp psPAS-help.xml
Function Set-PASLinkedAccount {
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '', Justification = 'Does not involve a plaintext password')]
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('id')]
		[string]$AccountID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$safe,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet('1', '2', '3')]
		[string]$extraPasswordIndex,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$name,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$folder

	)

	BEGIN {

		Assert-VersionRequirement -RequiredVersion 12.1

	}#begin

	PROCESS {

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/api/Accounts/$AccountID/LinkAccount"

		#Get Parameters to include in request
		$body = $PSBoundParameters | Get-PASParameter -ParametersToRemove AccountID | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($AccountID, 'Set Linked Account')) {

			#Send request to web service
			Invoke-PASRestMethod -Uri $URI -Method POST -Body $body

		}

	}#process

	END { }#end

}