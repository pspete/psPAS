# .ExternalHelp psPAS-help.xml
function Set-PASUserPassword {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[int]$id,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[securestring]$NewPassword
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 10.10
	}#begin

	PROCESS {

		#Get request parameters
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove id

		$Password = ConvertTo-InsecureString -SecureString $NewPassword

		If ($Password.length -gt 39) {
			throw 'Password must not exceed 39 characters'
		}

		#Include decoded password in request
		$boundParameters['NewPassword'] = $Password

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/Users/$id/ResetPassword"

		#create request body
		$body = $boundParameters | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($id, 'Reset Password')) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	END { }#end

}