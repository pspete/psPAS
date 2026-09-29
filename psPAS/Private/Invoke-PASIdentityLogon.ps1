function Invoke-PASIdentityLogon {
	<#
	.SYNOPSIS
	Authenticates to Identity for Privilege Cloud Shared Services logon

	.DESCRIPTION
	psPAS helper function.
	Uses the IdentityCommand module to authenticate an Identity User (Credential or SAMLResponse)
	or a Service User (Credential), returning the IdentityCommand session object.

	.PARAMETER TenantURL
	The Identity tenant URL.

	.PARAMETER Credential
	Identity User or Service User credential.

	.PARAMETER SAMLResponse
	SAML response for Identity User SAML authentication.

	.PARAMETER ServiceUser
	Authenticate as a Service User (New-IDPlatformToken) rather than an Identity User (New-IDSession).

	.EXAMPLE
	Invoke-PASIdentityLogon -TenantURL https://sometenant.id.cyberark.cloud -Credential $Cred

	.EXAMPLE
	Invoke-PASIdentityLogon -TenantURL https://sometenant.id.cyberark.cloud -Credential $Cred -ServiceUser
	#>
	[CmdletBinding(DefaultParameterSetName = 'Credential')]
	param(
		[parameter(
			Mandatory = $true
		)]
		[string]$TenantURL,

		[parameter(
			Mandatory = $true,
			ParameterSetName = 'Credential'
		)]
		[PSCredential]$Credential,

		[parameter(
			Mandatory = $true,
			ParameterSetName = 'SAML'
		)]
		[string]$SAMLResponse,

		[parameter(
			Mandatory = $false,
			ParameterSetName = 'Credential'
		)]
		[switch]$ServiceUser
	)

	process {

		#Check IdentityCommand module available
		if (-not (Get-Module IdentityCommand)) {
			try { Import-Module IdentityCommand -ErrorAction Stop }
			catch { throw "Failed to import IdentityCommand: Install the IdentityCommand Module and try again. $($PSItem.Exception.Message)" }
		}

		switch ($true) {

			($PSCmdlet.ParameterSetName -eq 'SAML') {
				New-IDSession -tenant_url $TenantURL -SAMLResponse $SAMLResponse
				break
			}

			($ServiceUser.IsPresent) {
				New-IDPlatformToken -tenant_url $TenantURL -Credential $Credential
				break
			}

			default {
				New-IDSession -tenant_url $TenantURL -Credential $Credential
			}

		}

	}

}
