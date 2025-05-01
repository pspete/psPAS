# .ExternalHelp psPAS-help.xml
function Add-PASDirectory {
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlaintextForPassword', '', Justification = "It's a path to password object")]
	[CmdletBinding(DefaultParameterSetName = '10.4')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = '10.4'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = '10.7'
		)]
		[string]$DirectoryType,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = '10.4'
		)]
		[string[]]$HostAddresses,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = '10.4'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = '10.7'
		)]
		[string]$BindUsername,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = '10.4'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = '10.7'
		)]
		[securestring]$BindPassword,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = '10.4'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = '10.7'
		)]
		[ValidateRange(1, 65535)]
		[int]$Port,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = '10.7'
		)]
		[hashtable[]]$DCList,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = '10.4'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = '10.7'
		)]
		[string]$DomainName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = '10.4'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = '10.7'
		)]
		[string]$DomainBaseContext,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = '10.4'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = '10.7'
		)]
		[boolean]$SSLConnect

	)

	BEGIN {
		Assert-VersionRequirement -SelfHosted
		Assert-VersionRequirement -RequiredVersion $PSCmdlet.ParameterSetName

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/Configuration/LDAP/Directories"

		#Get request parameters
		$boundParameters = $PSBoundParameters | Get-PASParameter

		#deal with BindPassword SecureString
		If ($PSBoundParameters.ContainsKey('BindPassword')) {

			#Include decoded bind password in request
			$boundParameters['BindPassword'] = $(ConvertTo-InsecureString -SecureString $BindPassword)

		}

		$body = $boundParameters | ConvertTo-Json

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

		If ($null -ne $result) {

			#Return Results
			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Directory.Extended

		}

	}#process

	END { }#end

}