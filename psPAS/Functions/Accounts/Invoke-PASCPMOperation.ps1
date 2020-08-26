# .ExternalHelp psPAS-help.xml
function Invoke-PASCPMOperation {
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', 'ChangeCredsForGroup', Justification = "Parameter does not hold password")]
	[CmdletBinding(SupportsShouldProcess)] # DefaultParameterSetName = "VerifyStandard"
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias("id")]
		[string]$AccountID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "VerifyClassic"
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Verify"
		)]
		[switch]$VerifyTask,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Password/Update"
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "SetNextPassword"
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Change"
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "ChangeClassic"
		)]
		[switch]$ChangeTask,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Reconcile"
		)]
		[switch]$ReconcileTask,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "SetNextPassword"
		)]
		[boolean]$ChangeImmediately,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "SetNextPassword"
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Password/Update"
		)]
		[securestring]$NewCredentials,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "Change"
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Password/Update"
		)]
		[boolean]$ChangeEntireGroup,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "ChangeClassic"
		)]
		[ValidateSet('Yes', 'No')]
		[string]$ImmediateChangeByCPM,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "ChangeClassic"
		)]
		[ValidateSet('Yes', 'No')]
		[string]$ChangeCredsForGroup,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "VerifyClassic"
		)]
		[switch]$UseClassicAPI
	)

	Begin {

		#Create hashtable for splatting
		$ThisRequest = @{ }
		$ThisRequest["WebSession"] = $Script:WebSession
		$ThisRequest["Method"] = "PUT"

	}#Begin

	Process {

		#Get parameters to include in request body
		$boundParameters = $PSBoundParameters |
		Get-PASParameter -ParametersToRemove ImmediateChangeByCPM, AccountID, VerifyTask, ChangeTask, ReconcileTask

		switch ($PSCmdlet.ParameterSetName) {

			"ChangeClassic" {

				#Classic API CPM Change URI
				$ThisRequest["URI"] = "$Script:BaseURI/WebServices/PIMServices.svc/Accounts/$AccountID/ChangeCredentials"

				#add ImmediateChangeByCPM to header as key=value pair
				$ThisRequest["WebSession"].Headers["ImmediateChangeByCPM"] = $ImmediateChangeByCPM

				#create request body
				$ThisRequest["Body"] = $boundParameters | ConvertTo-Json

			}

			"VerifyClassic" {

				#Classic API CPM Verify URI
				$ThisRequest["URI"] = "$Script:BaseURI/WebServices/PIMServices.svc/Accounts/$AccountID/VerifyCredentials"

				#Empty Body
				$ThisRequest["Body"] = @{ } | ConvertTo-Json

			}

			default {

				#Not using classic API
				#At least version 9.10 required to verify/change/reconcile
				Assert-VersionRequirement -RequiredVersion 9.10

				#Use ParameterSet name for required URI
				$ThisRequest["URI"] = "$Script:BaseURI/API/Accounts/$AccountID/$($PSCmdlet.ParameterSetName)"

				#verify/change/reconcile method
				$ThisRequest["Method"] = "POST"

				#deal with NewCredentials SecureString
				If ($PSBoundParameters.ContainsKey("NewCredentials")) {

					#Specifying next password value, or changing in the vault requires 10.1 or above
					Assert-VersionRequirement -RequiredVersion 10.1

					#Include decoded password in request
					$boundParameters["NewCredentials"] = $(ConvertTo-InsecureString -SecureString $NewCredentials)

				}

				#create request body
				$ThisRequest["Body"] = $boundParameters | ConvertTo-Json

			}

		}

		if ($PSCmdlet.ShouldProcess($AccountID, "Initiate CPM $($PSBoundParameters.Keys | Where-Object{$_ -like '*Task'})")) {

			#Send the request to the web service
			Invoke-PASRestMethod @ThisRequest

		}

		If ($ThisRequest["WebSession"].Headers.ContainsKey("ImmediateChangeByCPM")) {

			#Ensure ImmediateChangeByCPM is removed from WebSession Header
			$ThisRequest["WebSession"].Headers.Remove("ImmediateChangeByCPM") | Out-Null

		}

	}#Process

	End { }#End

}