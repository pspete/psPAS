function Resolve-PASLogonTarget {
	<#
	.SYNOPSIS
	Resolves the URLs required for a PAS logon

	.DESCRIPTION
	psPAS helper function.
	Normalises provided Self-Hosted or Privilege Cloud URLs (removing any trailing slash or PasswordVault path),
	or discovers Privilege Cloud URLs from a tenant subdomain.
	Returns the PAS API URL, the Privilege Cloud API URL and the Identity tenant URL.

	.PARAMETER BaseURI
	Self-Hosted PVWA URL.

	.PARAMETER IdentityTenantURL
	Identity tenant URL for Privilege Cloud Shared Services logon.

	.PARAMETER PrivilegeCloudURL
	Privilege Cloud API URL for Privilege Cloud Shared Services logon.

	.PARAMETER TenantSubdomain
	Privilege Cloud tenant subdomain, used to discover the Identity tenant and Privilege Cloud URLs.

	.PARAMETER PVWAAppName
	The PVWA application name.

	.EXAMPLE
	Resolve-PASLogonTarget -BaseURI https://pvwa.somedomain.com/

	Returns Uri https://pvwa.somedomain.com/PasswordVault

	.EXAMPLE
	Resolve-PASLogonTarget -TenantSubdomain SomeTenant

	Returns URLs discovered for the SomeTenant subdomain
	#>
	[CmdletBinding(DefaultParameterSetName = 'BaseURI')]
	param(
		[parameter(
			Mandatory = $true,
			ParameterSetName = 'BaseURI'
		)]
		[string]$BaseURI,

		[parameter(
			Mandatory = $true,
			ParameterSetName = 'URL'
		)]
		[string]$IdentityTenantURL,

		[parameter(
			Mandatory = $true,
			ParameterSetName = 'URL'
		)]
		[string]$PrivilegeCloudURL,

		[parameter(
			Mandatory = $true,
			ParameterSetName = 'SubDomain'
		)]
		[string]$TenantSubdomain,

		[parameter(
			Mandatory = $false
		)]
		[string]$PVWAAppName = 'PasswordVault'
	)

	process {

		if ($PSCmdlet.ParameterSetName -eq 'BaseURI') {

			#Remove trailing slash and PasswordVault if provided in BaseUri
			$BaseURI = $BaseURI -replace '/$', '' -replace '/PasswordVault$', ''

			$Uri = "$BaseURI/$PVWAAppName"
			$ApiURI = $null

		} else {

			if ($PSCmdlet.ParameterSetName -eq 'SubDomain') {

				$SharedServicesURLs = Find-SharedServicesURL -subdomain $TenantSubdomain

				$IdentityTenantURL = $SharedServicesURLs | Select-Object -ExpandProperty identity_user_portal | Select-Object -ExpandProperty api
				$PrivilegeCloudURL = $SharedServicesURLs | Select-Object -ExpandProperty pcloud | Select-Object -ExpandProperty api

			}

			#Remove trailing slash, and PasswordVault if provided in PrivilegeCloudURL
			$IdentityTenantURL = $IdentityTenantURL -replace '/$', ''
			$PrivilegeCloudURL = $PrivilegeCloudURL -replace '/$', '' -replace '/PasswordVault$', ''

			$Uri = "${PrivilegeCloudURL}/$PVWAAppName"

			#API URL for non PasswordVault operations
			if ($PrivilegeCloudURL) {
				$ApiURI = $PrivilegeCloudURL
			} else { $ApiURI = $null }

		}

		[PSCustomObject]@{
			Uri               = $Uri
			ApiURI            = $ApiURI
			IdentityTenantURL = $IdentityTenantURL
		}

	}

}
