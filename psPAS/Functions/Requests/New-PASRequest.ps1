# .ExternalHelp psPAS-help.xml
function New-PASRequest {
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'ConnectionParams')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$AccountId,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$Reason,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$TicketingSystemName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$TicketID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$MultipleAccessRequired,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[datetime]$FromDate,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[datetime]$ToDate,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[hashtable]$AdditionalInfo,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$UseConnect,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$ConnectionComponent,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ConnectionParams'
		)]
		[ValidateSet('Yes', 'No')]
		[string]$AllowMappingLocalDrives,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ConnectionParams'
		)]
		[ValidateSet('Yes', 'No')]
		[string]$AllowConnectToConsole,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ConnectionParams'
		)]
		[ValidateSet('Yes', 'No')]
		[string]$RedirectSmartCards,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ConnectionParams'
		)]
		[string]$PSMRemoteMachine,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ConnectionParams'
		)]
		[string]$LogonDomain,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ConnectionParams'
		)]
		[ValidateSet('Yes', 'No')]
		[string]$AllowSelectHTML5,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ManualParams'
		)]
		[hashtable]$ConnectionParams
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 9.10
	}#begin

	PROCESS {

		#Create URL for Request
		$URI = "$Script:BaseURI/API/MyRequests"

		$boundParameters = $PSBoundParameters | Get-PASParameter

		if ($boundParameters.ContainsKey('FromDate')) {

			#convert to unix time
			$boundParameters['FromDate'] = $FromDate | ConvertTo-UnixTime

		}

		if ($boundParameters.ContainsKey('ToDate')) {

			#convert to unix time
			$boundParameters['ToDate'] = $ToDate | ConvertTo-UnixTime

		}

		#Nest parameters "AllowMappingLocalDrives", "AllowConnectToConsole","RedirectSmartCards",
		#"PSMRemoteMachine", "LogonDomain" & "AllowSelectHTML5" under ConnectionParams Property
		$boundParameters = $boundParameters | ConvertTo-ConnectionParam

		#Create body of request
		$body = $boundParameters | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($AccountId, 'Create Request for Account Access')) {

			#send request to PAS web service
			$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -WebSession $Script:WebSession

			If ($null -ne $result) {

				$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Request

			}

		}

	}#process

	END { }#end

}