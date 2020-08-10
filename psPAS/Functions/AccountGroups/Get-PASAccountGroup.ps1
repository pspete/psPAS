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
	[CmdletBinding(DefaultParameterSetName = "10.5")]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10.5"
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "9.10"
		)]
		[string]$Safe,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "9.10"
		)]
		[switch]$UseClassicAPI
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion $PSCmdlet.ParameterSetName
	}#begin

	PROCESS {

		switch ($PSCmdlet.ParameterSetName) {

			"9.10" {

				#Create URL for Request
				$URI = "$Script:BaseURI/API/AccountGroups?$($PSBoundParameters | Get-PASParameter | ConvertTo-QueryString)"

				break

			}

			default {

				#Create URL for Request
				$URI = "$Script:BaseURI/API/Safes/$($Safe | Get-EscapedString)/AccountGroups"

			}

		}


		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If ($null -ne $result) {

			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Account.Group

		}

	}#process

	END { }#end

}