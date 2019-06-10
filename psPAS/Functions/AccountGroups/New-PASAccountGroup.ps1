function New-PASAccountGroup {
	<#
.SYNOPSIS
Adds a new account group to the Vault

.DESCRIPTION
Defines a new account group in the vault.
The following permissions are required on the safe where the account group will be created:
 - Add Accounts
 - Update Account Content
 - Update Account Properties
  -Create Folders

.PARAMETER GroupName
The name of the group to create

.PARAMETER GroupPlatformID
The name of the platform for the group.
The associated platform must be set to "PolicyType=Group"

.PARAMETER Safe
The Safe where the group will be created

.EXAMPLE
New-PASAccountGroup -GroupName UATGroup -GroupPlatform UnixGroup-NonProd -Safe UAT-Team -sessionToken $token.sessionToken -BaseURI $url

Creates new account group named UATGroup and assigns to platform in the UAT-Team Safe.

.INPUTS
All parameters can be piped by property name

.OUTPUTS
None

.NOTES
Minimum version 9.9.5

.LINK

#>
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$GroupName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$GroupPlatformID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$Safe
	)

	BEGIN {
		$MinimumVersion = [System.Version]"9.9.5"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for Request
		$URI = "$Script:BaseURI/$Script:PVWAAppName/API/AccountGroups/"

		#Create body of request
		$body = $PSBoundParameters | Get-PASParameter | ConvertTo-Json

		if($PSCmdlet.ShouldProcess($GroupName, "Define New Account Group")) {

			#send request to PAS web service
			Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -WebSession $WebSession

		}

	}#process

	END {}#end

}