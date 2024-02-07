# .ExternalHelp psPAS-help.xml
function Add-PASAccount {
	[CmdletBinding()]
	param(

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[string]$name,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[string]$address,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[string]$userName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[Alias('PolicyID')]
		[string]$platformID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('safe')]
		[string]$SafeName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateSet('Password', 'Key')]
		[string]$secretType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[securestring]$secret,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[hashtable]$platformAccountProperties,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[boolean]$automaticManagementEnabled,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[string]$manualManagementReason,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[string]$remoteMachines,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[boolean]$accessRestrictedToRemoteMachines,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[string]$accountName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[securestring]$password,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[boolean]$disableAutoMgmt,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[string]$disableAutoMgmtReason,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[string]$groupName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[string]$groupPlatformID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[int]$Port,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$ExtraPass1Name,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[string]$ExtraPass1Folder,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$ExtraPass1Safe,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$ExtraPass3Name,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[string]$ExtraPass3Folder,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$ExtraPass3Safe,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[hashtable]$DynamicProperties
	)

	BEGIN {

		#V9 baseparameters are contained in JSON object at the same depth
		$baseParameters = [Collections.Generic.List[String]]@('Safe', 'PlatformID', 'Address', 'AccountName', 'Password', 'Username',
			'DisableAutoMgmt', 'DisableAutoMgmtReason', 'GroupName', 'GroupPlatformID')

	}#begin

	PROCESS {

		#Get all parameters that will be sent in the request
		$boundParameters = $PSBoundParameters | Get-PASParameter

		switch ($PSCmdlet.ParameterSetName) {

			'Gen2' {

				Assert-VersionRequirement -RequiredVersion 10.4

				#Create URL for Request
				$URI = "$($psPASSession.BaseURI)/api/Accounts"

				$Account = New-PASAccountObject @boundParameters

				$body = $Account | ConvertTo-Json

				break

			}

			'Gen1' {

				#Create URL for Request
				$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Account"

				#deal with Password SecureString
				If ($PSBoundParameters.ContainsKey('password')) {

					#Include decoded password in request
					$boundParameters['password'] = $(ConvertTo-InsecureString -SecureString $password)

				}

				#Process for required formatting - fix V10 specific parameter names
				$boundParameters.remove('SafeName')
				$boundParameters.remove('userName')
				$boundParameters['safe'] = $SafeName
				$boundParameters['username'] = $userName

				#declare empty hashtable to hold "non-base" parameters
				$properties = @{ }

				#declare empty array to hold keys to remove from bound parameters
				$keysToRemove = [Collections.Generic.List[String]]@()

				#Get "non-base" parameters
				$boundParameters.keys | Where-Object { $baseParameters -notcontains $_ } | ForEach-Object {

					#For all "non-base" parameters except "DynamicProperties"
					if ($_ -ne 'DynamicProperties') {

						#Add key/Value to "properties" hashtable
						$properties[$_] = $boundParameters[$_]

					}

					Else {
						#for DynamicProperties key=value pairs

						#Enumerate DynamicProperties object
						$boundParameters[$_].getenumerator() | ForEach-Object {

							#add key=value to "properties" hashtable
							$properties[$_.name] = $_.value

						}
					}

					#add the "non-base" parameter key to array
					$null = $keysToRemove.Add($_)

				}

				#Add "non-base" parameter hashtable as value of "properties" on boundparameters object
				$boundParameters['properties'] = [Collections.Generic.List[Object]]@($properties.getenumerator() | ForEach-Object { $_ })

				#Create body of request
				$body = @{

					#account node does not contain non-base parameters
					'account' = $boundParameters | Get-PASParameter -ParametersToRemove $keysToRemove

					#ensure nodes at all required depths are included in the JSON object
				} | ConvertTo-Json -Depth 4

				break

			}

		}

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

		if ($PSCmdlet.ParameterSetName -eq 'Gen2') {

			If ($null -ne $result) {

				#Return Results
				$result | Add-ObjectDetail -typename 'psPAS.CyberArk.Vault.Account.V10'

			}

		}

	}#process

	END { }#end

}