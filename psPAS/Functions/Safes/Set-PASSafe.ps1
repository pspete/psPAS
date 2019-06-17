function Set-PASSafe {
	<#
.SYNOPSIS
Updates a safe in the Vault

.DESCRIPTION
Updates a single safe in the Vault.
Manage Safe permission is required.

.PARAMETER SafeName
The name of the safe to update.
Max Length 28 characters.
Cannot start with a space.
Cannot contain: '\','/',':','*','<','>','"','.' or '|'

.PARAMETER  NewSafeName
A name to rename the safe to
Max Length 28 characters.
Cannot start with a space.
Cannot contain: '\','/',':','*','<','>','"','.' or '|'

.PARAMETER Description
Updated Description for safe.
Max 100 characters.

.PARAMETER OLACEnabled
Boolean value, dictating whether or not to enable Object Level Access Control on the safe.

.PARAMETER ManagingCPM
The Name of the CPM user to manage the safe.
Specify "" to prevent CPM management.

.PARAMETER NumberOfVersionsRetention
The number of retained versions of every password that is stored in the Safe.
Max value = 999
Specify either this parameter or NumberOfDaysRetention.

.PARAMETER NumberOfDaysRetention
The number of days for which password versions are saved in the Safe.
Minimum Value: 1
Maximum Value 3650
Specify either this parameter or NumberOfVersionsRetention

.EXAMPLE
Set-PASSafe -SafeName SAFE -Description "New-Description" -NumberOfVersionsRetention 10

Updates description and version retention on SAFE

.INPUTS
SafeName, SessionToken, WebSession & BaseURI can be piped to the function by propertyname

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.Safe
Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *
#>
	[CmdletBinding(SupportsShouldProcess,
		DefaultParameterSetName = "Update")]
	param(
		[Parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Update"
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Days"
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Versions"
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateScript( {$_ -notmatch ".*(\\|\/|:|\*|<|>|`"|\.|\||^\s).*"})]
		[ValidateLength(0, 28)]
		[string]$SafeName,

		[Parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateScript( {$_ -notmatch ".*(\\|\/|:|\*|<|>|`"|\.|\||^\s).*"})]
		[ValidateLength(0, 28)]
		[string]$NewSafeName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[ValidateLength(0, 100)]
		[string]$Description,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[boolean]$OLACEnabled,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[string]$ManagingCPM,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "Versions"
		)]
		[ValidateRange(1, 999)]
		[int]$NumberOfVersionsRetention,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "Days"
		)]
		[ValidateRange(1, 3650)]
		[int]$NumberOfDaysRetention
	)

	BEGIN {}#begin

	PROCESS {

		#Create URL for Request
		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Safes/$($SafeName |

            Get-EscapedString)"

		$BoundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove SafeName, NewSafeName

		if($PSBoundParameters.ContainsKey("NewSafeName")) {
			$BoundParameters["SafeName"] = $PSBoundParameters["NewSafeName"]
		}

		#Create Request Body
		$body = @{
			"safe" = $BoundParameters

		} | ConvertTo-Json

		if($PSCmdlet.ShouldProcess($SafeName, "Update Safe Properties")) {

			#Send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body -WebSession $Script:WebSession

			if($result) {

				$result.UpdateSafeResult | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Safe

			}

		}

	}#process

	END {}#end

}