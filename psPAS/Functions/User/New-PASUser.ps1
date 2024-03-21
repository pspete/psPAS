# .ExternalHelp psPAS-help.xml
function New-PASUser {
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'Gen2')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[ValidateLength(0, 128)]
		[string]$UserName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[securestring]$InitialPassword,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[string]$userType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[AllowEmptyCollection()]
		[ValidateSet('PIMSU', 'PSM', 'PSMP', 'PVWA', 'WINCLIENT', 'PTA', 'PACLI', 'NAPI', 'XAPI', 'HTTPGW',
			'EVD', 'CPM', 'PVWAApp', 'PSMApp', 'AppPrv', 'AIMApp', 'PSMPApp', 'GUI')]
		[string[]]$unAuthorizedInterfaces,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[boolean]$enableUser,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateSet('AuthTypePass', 'AuthTypeLDAP', 'AuthTypeRADIUS')]
		[string[]]$authenticationMethod,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[string]$Email,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[boolean]$ChangePassOnNextLogon,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[boolean]$ChangePasswordOnTheNextLogon,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[boolean]$passwordNeverExpires,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[string]$distinguishedName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateSet('AddSafes', 'AuditUsers', 'AddUpdateUsers', 'ResetUsersPasswords', 'ActivateUsers', 'AddNetworkAreas',
			'ManageDirectoryMapping', 'ManageServerFileCategories', 'BackupAllSafes', 'RestoreAllSafes')]
		[AllowEmptyCollection()]
		[string[]]$vaultAuthorization,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[datetime]$ExpiryDate,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[string]$UserTypeName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[boolean]$Disabled,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[string]$Location,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[int]$userActivityLogRetentionDays,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateRange(0, 23)]
		[int]$loginFromHour,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateRange(0, 23)]
		[int]$loginToHour,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateLength(0, 29)]
		[string]$workStreet,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateLength(0, 19)]
		[string]$workCity,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateLength(0, 19)]
		[string]$workState,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateLength(0, 19)]
		[string]$workZip,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateLength(0, 19)]
		[string]$workCountry,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateLength(0, 319)]
		[string]$homePage,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateLength(0, 319)]
		[string]$homeEmail,


		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateLength(0, 319)]
		[string]$businessEmail,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateLength(0, 319)]
		[string]$otherEmail,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateLength(0, 24)]
		[string]$homeNumber,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateLength(0, 24)]
		[string]$businessNumber,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateLength(0, 24)]
		[string]$cellularNumber,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateLength(0, 24)]
		[string]$faxNumber,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateLength(0, 24)]
		[string]$pagerNumber,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateLength(0, 99)]
		[string]$description,


		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[ValidateLength(0, 29)]
		[string]$FirstName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateLength(0, 29)]
		[string]$MiddleName,


		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[ValidateLength(0, 29)]
		[string]$LastName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateLength(0, 29)]
		[string]$street,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateLength(0, 19)]
		[string]$city,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateLength(0, 19)]
		[string]$state,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateLength(0, 19)]
		[string]$zip,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateLength(0, 19)]
		[string]$country,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateLength(0, 49)]
		[string]$title,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateLength(0, 49)]
		[string]$organization,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateLength(0, 49)]
		[string]$department,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateLength(0, 49)]
		[string]$profession,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = 'Gen1'
		)]
		[Alias('UseClassicAPI')]
		[switch]$UseGen1API
	)

	BEGIN {	}#begin

	PROCESS {

		#Get request parameters
		$boundParameters = $PSBoundParameters | Get-PASParameter

		If ($PSBoundParameters.ContainsKey('InitialPassword')) {

			#Include decoded password in request
			$boundParameters['InitialPassword'] = $(ConvertTo-InsecureString -SecureString $InitialPassword)

		}

		switch ($PSCmdlet.ParameterSetName) {

			'Gen2' {

				Assert-VersionRequirement -RequiredVersion 10.9

				If ($PSBoundParameters.Keys -match 'userActivityLogRetentionDays|loginFromHour|loginToHour') {

					Assert-VersionRequirement -RequiredVersion 13.2

				}

				#Create URL for request
				$URI = "$($psPASSession.BaseURI)/api/Users"

				$boundParameters = $boundParameters | Format-PASUserObject

				$TypeName = 'psPAS.CyberArk.Vault.User.Extended'

				break

			}

			'Gen1' {

				Assert-VersionRequirement -MaximumVersion 12.3

				#Create URL for request
				$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Users"

				If ($PSBoundParameters.ContainsKey('ExpiryDate')) {

					#Convert ExpiryDate to string in Required format
					$Date = (Get-Date $ExpiryDate -Format MM/dd/yyyy).ToString()

					#Include date string in request
					$boundParameters['ExpiryDate'] = $Date

				}

				$TypeName = 'psPAS.CyberArk.Vault.User'

				break

			}

		}

		#Construct Request Body
		$body = $boundParameters | ConvertTo-Json -Depth 4

		if ($PSCmdlet.ShouldProcess($UserName, 'Create User')) {

			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

			If ($null -ne $result) {

				$result | Add-ObjectDetail -typename $typeName

			}

		}

	}#process

	END { }#end

}