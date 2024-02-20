# .ExternalHelp psPAS-help.xml
function Add-PASApplication {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateLength(1, 127)]
		[ValidateScript( { $_ -notmatch '.*(\&).*' })]
		[string]$AppID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(0, 99)]
		[string]$Description,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$Location,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateRange(0, 23)]
		[int]$AccessPermittedFrom,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateRange(0, 23)]
		[int]$AccessPermittedTo,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[datetime]$ExpirationDate,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$Disabled,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(0, 29)]
		[string]$BusinessOwnerFName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$BusinessOwnerLName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$BusinessOwnerEmail,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(0, 24)]
		[string]$BusinessOwnerPhone

	)

	BEGIN { }#begin

	PROCESS {

		#WebService URL
		$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Applications"

		#Get request parameters
		$boundParameters = $PSBoundParameters | Get-PASParameter

		If ($PSBoundParameters.ContainsKey('ExpirationDate')) {

			#Convert ExpiryDate to string in Required format
			$Date = (Get-Date $ExpirationDate -Format MM/dd/yyyy).ToString()

			#Include date string in request
			$boundParameters['ExpirationDate'] = $Date

		}

		#Create Request Body
		$body = @{

			'application' = $boundParameters

		} | ConvertTo-Json

		#Send Request
		Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

	}#process

	END { }#end

}