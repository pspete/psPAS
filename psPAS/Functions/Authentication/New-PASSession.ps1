# .ExternalHelp psPAS-help.xml
function New-PASSession {
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'Gen2')]
	param(
		[parameter(
			ValueFromPipeline = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2Radius'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			ParameterSetName = 'Gen1'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			ParameterSetName = 'Gen1Radius'
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-Subdomain-IdentityUser'
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-URL-IdentityUser'
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-Subdomain-ServiceUser'
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-URL-ServiceUser'
		)]
		[ValidateNotNullOrEmpty()]
		[PSCredential]$Credential,

		[Parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-Subdomain-IdentityUser'
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-Subdomain-ServiceUser'
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-Subdomain-SAML'
		)]
		[string]$TenantSubdomain,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1Radius'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2Radius'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1SAML'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2SAML'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'shared'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'integrated'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'OAuth'
		)]
		[string]$BaseURI,

		[Parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-URL-IdentityUser'
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-URL-ServiceUser'
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-URL-SAML'
		)]
		[string]$IdentityTenantURL,

		[Parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-URL-IdentityUser'
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-URL-ServiceUser'
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-URL-SAML'
		)]
		[string]$PrivilegeCloudURL,

		[Parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-Subdomain-IdentityUser'
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-URL-IdentityUser'
		)]
		[switch]$IdentityUser,

		[Parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-Subdomain-ServiceUser'
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-URL-ServiceUser'
		)]
		[switch]$ServiceUser,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1Radius'
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1SAML'
		)]
		[Alias('UseClassicAPI')]
		[switch]$UseGen1API,

		[Parameter(
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[Parameter(
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[SecureString]$newPassword,

		[Parameter(
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2SAML'
		)]
		[switch]$SAMLAuth,

		[Parameter(
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2SAML'
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1SAML'
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-Subdomain-SAML'
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-URL-SAML'
		)]
		[Alias('SAMLToken')]
		[String]$SAMLResponse,

		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'OAuth'
		)]
		[Alias('OAuth')]
		[ValidateNotNullOrEmpty()]
		[SecureString]$AccessToken,

		[Parameter(
			Mandatory = $True,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'shared'
		)]
		[switch]$UseSharedAuthentication,

		[Parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1Radius'
		)]
		[bool]$useRadiusAuthentication,

		[Parameter(
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[Parameter(
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2Radius'
		)]
		[ValidateSet('CyberArk', 'LDAP', 'Windows', 'RADIUS', 'PKI', 'PKIPN')]
		[string]$type = 'CyberArk',

		[Parameter(
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2Radius'
		)]
		[Parameter(
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1Radius'
		)]
		[string]$OTP,

		[Parameter(
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2Radius'
		)]
		[Parameter(
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1Radius'
		)]
		[ValidateSet('Append', 'Challenge')]
		[string]$OTPMode,

		[Parameter(
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2Radius'
		)]
		[Parameter(
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1Radius'
		)]
		[AllowEmptyString()]
		[string]$OTPDelimiter,

		[Parameter(
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2Radius'
		)]
		[Parameter(
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1Radius'
		)]
		[ValidateSet('Password', 'OTP')]
		[string]$RadiusChallenge,

		[parameter(
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'integrated'
		)]
		[switch]$UseDefaultCredentials,

		[parameter(
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[parameter(
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2Radius'
		)]
		[parameter(
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'integrated'
		)]
		[Parameter(
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2SAML'
		)]
		[Boolean]$concurrentSession,

		[Parameter(
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[Parameter(
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1Radius'
		)]
		[ValidateRange(1, 100)]
		[int]$connectionNumber,

		[parameter(
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$PVWAAppName = 'PasswordVault',

		[Parameter(
			ValueFromPipelinebyPropertyName = $false
		)]
		[switch]$SkipVersionCheck,

		[parameter(
			ValueFromPipelinebyPropertyName = $false
		)]
		[X509Certificate]$Certificate,

		[parameter(
			ValueFromPipelinebyPropertyName = $false
		)]
		[string]$CertificateThumbprint,

		[parameter(
			ValueFromPipelinebyPropertyName = $true
		)]
		[switch]$SkipCertificateCheck

	)

	begin { }#begin

	process {

		#Resolve PAS and Identity URLs
		$TargetParameters = $PSBoundParameters | Get-PASParameter -ParametersToKeep BaseURI, IdentityTenantURL, PrivilegeCloudURL, TenantSubdomain
		$Target = Resolve-PASLogonTarget @TargetParameters -PVWAAppName $PVWAAppName
		$Uri = $Target.Uri

		if ($PSCmdlet.ParameterSetName -eq 'shared') {

			Assert-VersionRequirement -SelfHosted

		}

		$LogonRequest = Get-PASLogonRequest -ParameterSetName $PSCmdlet.ParameterSetName -Uri $Uri -IdentityTenantURL $Target.IdentityTenantURL -BoundParameters $PSBoundParameters

		if ($PSCmdlet.ShouldProcess($LogonRequest['Uri'], 'Logon')) {

			try {

				switch -Regex ($PSCmdlet.ParameterSetName) {

					'^ISPSS-.*-IdentityUser$' {
						#Perform Identity User Authentication using IdentityCommand module
						$PASSession = Invoke-PASIdentityLogon -TenantURL $LogonRequest['Uri'] -Credential $LogonRequest['Credential']
						break
					}
					'^ISPSS-.*-SAML$' {
						#Perform Identity User SAML Authentication using IdentityCommand module
						$PASSession = Invoke-PASIdentityLogon -TenantURL $LogonRequest['Uri'] -SAMLResponse $LogonRequest['SAMLResponse']
						break
					}
					'^ISPSS-.*-ServiceUser$' {
						#Perform Service User Authentication using IdentityCommand module
						$PASSession = Invoke-PASIdentityLogon -TenantURL $LogonRequest['Uri'] -Credential $LogonRequest['Credential'] -ServiceUser
						break
					}
					'^OAuth$' {

						#Snapshot the WebSession about to be replaced, so a rejected token/version can restore it
						$PreviousWebSession = $psPASSession.WebSession

						$psPASSession.WebSession = Get-PASOAuthWebSession -AccessToken $AccessToken -Certificate $Certificate -CertificateThumbprint $CertificateThumbprint -SkipCertificateCheck:$SkipCertificateCheck

						#OAuth uses Bearer token directly with WebSession
						$PASSession = $psPASSession.WebSession.Headers['Authorization']
						break
					}
					default {
						#Send Logon Request
						$PASSession = Invoke-PASRestMethod @LogonRequest
						break
					}
				}

				if ($null -ne $PASSession.UserName) {

					#*$PASSession is expected to be a string value
					#*For IIS Windows/PKI auth:
					#*An object with a username property will be returned if a secondary authentication is required

					#Use WebSession from initial request
					$LogonRequest.Remove('SessionVariable')
					$LogonRequest['WebSession'] = $psPASSession.WebSession

					#Prepare auth request
					switch ( $true ) {

						($PSCmdlet.ParameterSetName -match 'Radius$') {

							#RADIUS Secondary auth
							$LogonRequest['Uri'] = "$Uri/api/Auth/RADIUS/Logon"
							break
						}

						($type -eq 'PKI') {

							#LDAP Secondary auth
							$LogonRequest['Uri'] = "$Uri/api/Auth/LDAP/Logon"
							break

						}

					}

					#Submit secondary auth request
					$PASSession = Invoke-PASRestMethod @LogonRequest

				}

			} catch {

				if ($PSItem.FullyQualifiedErrorId -notmatch 'ITATS542I') {

					#Throw all errors not related to ITATS542I
					throw $PSItem

				} else {

					#ITATS542I is expected for RADIUS Challenge

					#Use WebSession from initial request
					$LogonRequest.Remove('SessionVariable')
					$LogonRequest['WebSession'] = $psPASSession.WebSession

					#Collect values required to respond to the challenge
					$RADIUSResponse = @{}
					$RADIUSResponse['LogonRequest'] = $LogonRequest
					$RADIUSResponse['Message'] = $($PSItem.Exception.Message)

					#Include any OTP value provided in the RADIUS Response
					if ($PSBoundParameters.ContainsKey('OTP')) {

						#!If $RadiusChallenge = Password, OTP will be password value
						$RadiusParameters = $PSBoundParameters | Get-PASParameter -ParametersToKeep Credential, OTP, OTPMode, OTPDelimiter, RadiusChallenge
						$RADIUSResponse['OTP'] = [System.Net.NetworkCredential]::new('', (Get-PASRadiusCredential @RadiusParameters).OTP).SecurePassword

					}

					#Respond to RADIUS challenge
					$PASSession = Send-RADIUSResponse @RADIUSResponse

				}

			} finally {

				#If Logon Result
				if ($PASSession) {

					$IsOAuth = $PSCmdlet.ParameterSetName -eq 'OAuth'

					switch ($PASSession) {

						( { $null -ne $PSItem.UserName } ) {

							throw "No Session Token for user $($PASSession.UserName)"

						}

						( { $null -ne $PSItem.access_token } ) {

							#Shared Service access_token.
							$CyberArkLogonResult = "$($PASSession.token_type) $($PASSession.access_token)"

							#Make the IdentityCommand WebSession available in the psPAS module scope
							$psPASSession.WebSession = $($PSItem.GetWebSession())

						}

						( { $null -ne $PSItem.Token } ) {

							#Shared Services Identity User Bearer Token
							$CyberArkLogonResult = "Bearer $($PASSession.Token)"

							#Make the IdentityCommand WebSession available in the psPAS module scope
							$psPASSession.WebSession = $($PSItem.GetWebSession())

						}

						( { $null -ne $PSItem.LogonResult } ) {

							#Shared Auth LogonResult.
							$CyberArkLogonResult = $PASSession.LogonResult

						}

						( { $null -ne $PSItem.CyberArkLogonResult } ) {

							#Classic CyberArkLogonResult
							$CyberArkLogonResult = $PASSession.CyberArkLogonResult

						}

						( { $IsOAuth } ) {

							#OAuth 2.0 Bearer Token, set in WebSession by Get-PASOAuthWebSession
							$CyberArkLogonResult = $PASSession

						}

						default {

							if ($PASSession.length -ge 180) {

								#V10 Auth Token.
								$CyberArkLogonResult = $PASSession

							}

						}

					}

					if ($IsOAuth) {
						#Snapshot prior connection details - a rejected token or unsupported version must not
						#clobber a previously-working session with one that was never actually validated.
						#WebSession itself was already replaced above (outside this finally block), so its
						#prior value was captured there, in $PreviousWebSession
						$PreviousBaseURI = $psPASSession.BaseURI
						$PreviousApiURI = $psPASSession.ApiURI
						$PreviousExternalVersion = $psPASSession.ExternalVersion
					}

					try {

						#Record Session Start Time
						$psPASSession.StartTime = Get-Date

						#BaseURI set in Module Scope
						$psPASSession.BaseURI = $Uri

						#API URL for non PasswordVault operations
						$psPASSession.ApiURI = $Target.ApiURI

						#Initial Value for Version variable
						[System.Version]$Version = '0.0'

						if ( -not ($SkipVersionCheck)) {

							try {

								#Get CyberArk ExternalVersion number.
								[System.Version]$Version = Get-PASServer -ErrorAction Stop |
									Select-Object -ExpandProperty ExternalVersion

							} catch { [System.Version]$Version = '0.0' }

							if ($IsOAuth) {

								Assert-VersionRequirement -ExternalVersion $Version -RequiredVersion 15.2

							}

						}

						#Auth token added to WebSession
						$psPASSession.WebSession.Headers['Authorization'] = [string]$CyberArkLogonResult

						#For OAuth there is no prior logon call - resolving the authenticated user is the only
						#server-side confirmation that the supplied AccessToken was actually accepted
						Initialize-PASSession -ExternalVersion $Version -Credential $Credential -RequireUser:$IsOAuth

					} catch {

						if ($IsOAuth) {
							$psPASSession.BaseURI = $PreviousBaseURI
							$psPASSession.ApiURI = $PreviousApiURI
							$psPASSession.WebSession = $PreviousWebSession
							$psPASSession.ExternalVersion = $PreviousExternalVersion
						}

						throw

					}

				}

			}

		}

	}#process

	end { }#end

}
