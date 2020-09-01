# .ExternalHelp psPAS-help.xml
Function Set-PASPTARule {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string][int]$id,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet("SSH", "WINDOWS", "SCP", "KEYSTROKES", "SQL")]
		[string]$category,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$regex,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateRange(1, 100)]
		[int]$score,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$description,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet("NONE", "TERMINATE", "SUSPEND")]
		[string]$response,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$active

	)

	BEGIN {

		Assert-VersionRequirement -RequiredVersion 10.4

	}#begin

	PROCESS {

		#Get all parameters that will be sent in the request
		$boundParameters = $PSBoundParameters | Get-PASParameter

		#Create URL for Request
		$URI = "$Script:BaseURI/API/pta/API/Settings/RiskyActivity/"

		#Create body of request
		$body = $boundParameters | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($id, "Update Risky Activity Rule")) {

			#send request to PAS web service
			Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body -WebSession $Script:WebSession

		}

	}#process

	END { }#end
}