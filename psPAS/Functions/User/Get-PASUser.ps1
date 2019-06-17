function Get-PASUser {
	<#
.SYNOPSIS
Returns details of a user

.DESCRIPTION
Returns information on specific vault user.

.PARAMETER Search
Search string.

.PARAMETER UserType
The type of the user.

.PARAMETER ComponentUser
Whether the user is a known component or not.

.PARAMETER UserName
The user's name

.EXAMPLE
Get-PASUser

Returns information for all found Users

.EXAMPLE
Get-PASUser -search SearchTerm -ComponentUser $False

Returns information for all matching Users

.EXAMPLE
Get-PASUser -UserName Target_User

Displays information on Target_User

.INPUTS
All parameters can be piped by property name

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.User
Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *
#>
	[CmdletBinding(DefaultParameterSetName = "10_9")]
	param(

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[string]$Search,


		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[string]$UserType,


		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[boolean]$ComponentUser,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "legacy"
		)]
		[string]$UserName
	)

	BEGIN {
		$MinimumVersion = [System.Version]"10.9"
	}#begin

	PROCESS {

		If ($PSCmdlet.ParameterSetName -eq "10_9") {

			Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

			#Create URL for request
			$URI = "$Script:BaseURI/api/Users"

			#Get Parameters to include in request
			$boundParameters = $PSBoundParameters | Get-PASParameter

			#Create Query String, escaped for inclusion in request URL
			$queryString = ($boundParameters.keys | ForEach-Object {

					"$_=$($boundParameters[$_] | Get-EscapedString)"

				}) -join '&'

			#Build URL from base URL
			$URI = "$URI`?$queryString"

		}

		ElseIf ($PSCmdlet.ParameterSetName -eq "legacy") {

			#Create URL for request
			$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Users/$($UserName |

            Get-EscapedString)"

		}

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		#Handle V10 return
		if ($result.Users) {

			$result.Users | Add-ObjectDetail -typename psPAS.CyberArk.Vault.User.Extended

		}

		#Handle legacy return
		ElseIf ($result) {

			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.User

		}



	}#process

	END { }#end

}