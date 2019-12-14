function Get-PASAccountGroup {
	<#
.SYNOPSIS
Returns all the account groups in a specific Safe.

.DESCRIPTION
Returns all the account groups in a specific Safe.
The following permissions are required on the safe where the account group will be created:
 - Add Accounts
 - Update Account Content
 - Update Account Properties
  -Create Folders

.PARAMETER Safe
The Safe where the account groups are.

.PARAMETER UseClassicAPI
Specify the UseClassicAPI to force usage the Classic (v9) API endpoint.
Relevant for CyberArk versions earlier than 10.5

.EXAMPLE
Get-PASAccountGroup -Safe SafeName

List all account groups in SafeName

.INPUTS
All parameters can be piped by property name

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.Account.Group
Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.NOTES
Minimum CyberArk version 9.10

.LINK
https://pspas.pspete.dev/commands/Get-PASAccountGroup
#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$Safe,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "v9"
		)]
		[switch]$UseClassicAPI
	)

	BEGIN {
		$MinimumVersion = [System.Version]"9.10"
		$RequiredVersion = [System.Version]"10.5"
	}#begin

	PROCESS {

		If ($PSCmdlet.ParameterSetName -eq "v9") {

			Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

			#Create URL for Request
			$URI = "$Script:BaseURI/API/AccountGroups?Safe=$($Safe | Get-EscapedString)"

		}

		Else {

			Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $RequiredVersion

			#Create URL for Request
			$URI = "$Script:BaseURI/API/Safes/$($Safe | Get-EscapedString)/AccountGroups"

		}

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		if ($result) {

			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Account.Group

		}

	}#process

	END { }#end

}