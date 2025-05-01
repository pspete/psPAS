# .ExternalHelp psPAS-help.xml
function Add-PASPendingAccount {
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPassWordParams', '', Justification = 'Username not used for authentication')]
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', 'LastPasswordSet', Justification = 'Parameter does not hold password')]
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$UserName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$Address,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[datetime]$AccountDiscoveryDate,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet('Windows', 'Unix')]
		[string]$OSType,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet('enabled', 'disabled')]
		[string]$AccountEnabled,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$AccountOSGroups,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet('domain', 'local')]
		[string]$AccountType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$DiscoveryPlatformType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$Domain,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$LastLogonDate,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$LastPasswordSet,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$PasswordNeverExpires,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$OSVersion,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$OU,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet('Privileged', 'Non-privileged')]
		[string]$AccountCategory,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$AccountCategoryCriteria,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$UserDisplayName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$AccountDescription,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$AccountExpirationDate,

		[string]$UID,
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$GID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet('Workstation', 'Server')]
		[string]$MachineOSFamily
	)

	BEGIN {
		#!Depracated above 13.2
		Assert-VersionRequirement -MaximumVersion 13.2
	}#begin

	PROCESS {

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/PendingAccounts"

		#Get all parameters that will be sent in the request
		$boundParameters = $PSBoundParameters | Get-PASParameter

		If ($PSBoundParameters.ContainsKey('AccountDiscoveryDate')) {

			#Convert ExpiryDate to string in Required format
			$Date = (Get-Date $AccountDiscoveryDate.ToUniversalTime() -Format 'yyyy-MM-ddTHH:mm:ssZ').ToString()

			#Include date string in request
			$boundParameters['AccountDiscoveryDate'] = $Date

		}

		#Create body of request
		$body = @{

			#pendingaccount node
			'pendingAccount' = $boundParameters | Get-PASParameter

			#JSON object
		} | ConvertTo-Json

		#send request to PAS web service
		Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

	}#process

	END { }#end

}