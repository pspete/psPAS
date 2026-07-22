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

	begin {
		Assert-VersionRequirement -RequiredVersion 10.10
	}#begin

	process {

		#Get request parameters
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove id

		$Password = ConvertTo-InsecureString -SecureString $NewPassword

		if ($Password.length -gt 39) {
			throw 'Password must not exceed 39 characters'
		}

		#Include decoded password in request
		$boundParameters['NewPassword'] = $Password

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/Users/$id/ResetPassword"

		#create request body
		#Send as raw UTF8 bytes rather than a String so ParameterBinding/module logging of this
		#call records a non-revealing type name instead of the literal request content.
		$body = [System.Text.Encoding]::UTF8.GetBytes($($boundParameters | ConvertTo-Json))

		if ($PSCmdlet.ShouldProcess($id, 'Reset Password')) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	end { }#end

}