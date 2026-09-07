# .ExternalHelp psPAS-help.xml
function New-PASSession {
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'Gen2')]
	param(
		[parameter(
			Mandatory = $false,
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
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-Subdomain-IdentityUser'
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-Subdomain-ServiceUser'
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-Subdomain-SAML'
		)]
		[string]$TenantSubdomain,

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1Radius'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2Radius'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1SAML'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2SAML'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'shared'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'integrated'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'OAuth'
		)]
		[string]$BaseURI,

		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-URL-IdentityUser'
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-URL-ServiceUser'
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-URL-SAML'
		)]
		[string]$IdentityTenantURL,

		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-URL-IdentityUser'
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-URL-ServiceUser'
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-URL-SAML'
		)]
		[string]$PrivilegeCloudURL,

		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-Subdomain-IdentityUser'
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-URL-IdentityUser'
		)]
		[switch]$IdentityUser,

		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-Subdomain-ServiceUser'
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
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
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[SecureString]$newPassword,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2SAML'
		)]
		[switch]$SAMLAuth,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2SAML'
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1SAML'
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ISPSS-Subdomain-SAML'
		)]
		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
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
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'shared'
		)]
		[switch]$UseSharedAuthentication,

		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1Radius'
		)]
		[bool]$useRadiusAuthentication,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2Radius'
		)]
		[ValidateSet('CyberArk', 'LDAP', 'Windows', 'RADIUS', 'PKI', 'PKIPN')]
		[string]$type = 'CyberArk',

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2Radius'
		)]
		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1Radius'
		)]
		[string]$OTP,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2Radius'
		)]
		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1Radius'
		)]
		[ValidateSet('Append', 'Challenge')]
		[string]$OTPMode,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2Radius'
		)]
		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1Radius'
		)]
		[AllowEmptyString()]
		[string]$OTPDelimiter,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2Radius'
		)]
		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1Radius'
		)]
		[ValidateSet('Password', 'OTP')]
		[string]$RadiusChallenge,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'integrated'
		)]
		[switch]$UseDefaultCredentials,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2Radius'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'integrated'
		)]
		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2SAML'
		)]
		[Boolean]$concurrentSession,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1Radius'
		)]
		[ValidateRange(1, 100)]
		[int]$connectionNumber,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$PVWAAppName = 'PasswordVault',

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[switch]$SkipVersionCheck,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[X509Certificate]$Certificate,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[string]$CertificateThumbprint,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[switch]$SkipCertificateCheck

	)

	begin {

		if ($baseURI) {

			#Ensure URL is in expected format
			#Remove trailing space and PasswordVault if provided in BaseUri
			$baseURI = $baseURI -replace '/$', ''
			$baseURI = $baseURI -replace '/PasswordVault$', ''
			#Build URL
			$Uri = "$baseURI/$PVWAAppName"

		}

		#Hashtable to hold Logon Request
		$LogonRequest = @{ }

		#Define Logon Request Parameters
		$LogonRequest['Method'] = 'POST'
		$LogonRequest['SessionVariable'] = 'PASSession'
		$LogonRequest['UseDefaultCredentials'] = $UseDefaultCredentials.IsPresent
		$LogonRequest['SkipCertificateCheck'] = $SkipCertificateCheck.IsPresent

		if ($PSBoundParameters['type'] -eq 'Windows') {

			$LogonRequest['Credential'] = $Credential

		}

		if ($CertificateThumbprint) {

			$LogonRequest['CertificateThumbprint'] = $CertificateThumbprint

		}

		if ($Certificate) {

			$LogonRequest['Certificate'] = $Certificate

		}

	}#begin

	process {

		switch ($PSCmdlet.ParameterSetName) {

			( { $PSItem -match '^ISPSS-URL' } ) {

				#Ensure URLs are in expected format
				#Remove trailing space and PasswordVault (if provided in PrivilegeCloudURL)
				$IdentityTenantURL = $IdentityTenantURL -replace '/$', ''
				$PrivilegeCloudURL = $PrivilegeCloudURL -replace '/$', ''
				$PrivilegeCloudURL = $PrivilegeCloudURL -replace '/PasswordVault$', ''

			}

			( { $PSItem -match '^ISPSS-SubDomain' } ) {

				$SharedServicesURLs = Find-SharedServicesURL -subdomain $TenantSubdomain

				$IdentityTenantURL = $SharedServicesURLs | Select-Object -ExpandProperty identity_user_portal | Select-Object -ExpandProperty api
				$PrivilegeCloudURL = $SharedServicesURLs | Select-Object -ExpandProperty pcloud | Select-Object -ExpandProperty api

				#Ensure URLs are in expected format
				#Remove trailing space and PasswordVault (if provided in PrivilegeCloudURL)
				$IdentityTenantURL = $IdentityTenantURL -replace '/$', ''
				$PrivilegeCloudURL = $PrivilegeCloudURL -replace '/$', ''
				$PrivilegeCloudURL = $PrivilegeCloudURL -replace '/PasswordVault$', ''

			}

			( { $PSItem -match '^ISPSS-.*-.*User$' } ) {

				#IdentityUser/ServiceUser LogonRequest for New-IDSession/New-IDPlatformToken
				$LogonRequest['Uri'] = $IdentityTenantURL
				$LogonRequest['Credential'] = $Credential

				#URL for P Cloud API Operations
				$Uri = "${PrivilegeCloudURL}/$PVWAAppName"

				break
			}

			( { $PSItem -match '^ISPSS-.*-SAML$' } ) {

				#SAMLAuth for New-IDSession
				$LogonRequest['Uri'] = $IdentityTenantURL
				$LogonRequest['SAMLResponse'] = $SAMLResponse

				#URL for P Cloud API Operations
				$Uri = "${PrivilegeCloudURL}/$PVWAAppName"

				break
			}

			'integrated' {

				$LogonRequest['Uri'] = "$Uri/api/Auth/Windows/Logon"  #hardcode Windows for integrated auth

				#Construct Request Body
				#The only expected parameter should be concurrentSessions
				$LogonRequest['Body'] = $PSBoundParameters | Get-PASParameter -ParametersToKeep concurrentSession | ConvertTo-Json

				break

			}

			'shared' {

				Assert-VersionRequirement -SelfHosted

				$LogonRequest['Uri'] = "$Uri/WebServices/auth/Shared/RestfulAuthenticationService.svc/Logon"
				break

			}

			'Gen1SAML' {

				$LogonRequest['Uri'] = "$Uri/WebServices/auth/SAML/SAMLAuthenticationService.svc/Logon"

				#add token to header
				$LogonRequest['Headers'] = @{'Authorization' = $SAMLResponse }
				break

			}

			'Gen2SAML' {

				#*For SAML auth
				#The only expected parameter should be concurrentSession & SAMLResponse
				$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToKeep concurrentSession, SAMLResponse

				#add required parameters
				$boundParameters.Add('apiUse', $true)

				if ( -not ($PSBoundParameters.ContainsKey('SAMLResponse'))) {

					#If no SAMLResponse provided
					#Get SAML Response from IdP
					#*https://gist.github.com/infamousjoeg/b44faa299ec3de65bdd1d3b8474b0649
					$SAMLResponse = Get-PASSAMLResponse -URL $Uri

					#add SAMLResponse to boundParameters
					$boundParameters.Add('SAMLResponse', $SAMLResponse)

				}

				$LogonRequest['Body'] = $boundParameters
				$LogonRequest['ContentType'] = 'application/x-www-form-urlencoded'
				$LogonRequest['Uri'] = "$Uri/api/auth/SAML/Logon"
				break

			}

			'OAuth' {

				#BaseURI required in module scope for Assert-VersionRequirement
				$psPASSession.BaseURI = $Uri
				Assert-VersionRequirement -SelfHosted

				if ($SkipCertificateCheck) {
					if (-not (Test-IsCoreCLR)) {
						Skip-CertificateCheck
					} else {
						$Script:SkipCertificateCheck = $true
					}
				}

				# Create WebSession
				$WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

				if ($Certificate) {
					$WebSession.Certificates.Add($Certificate) | Out-Null
				}

				if ($CertificateThumbprint) {
					#Resolve certificate from the store and add to WebSession
					$ClientCertificate = Get-ChildItem -Path 'Cert:\CurrentUser\My', 'Cert:\LocalMachine\My' |
						Where-Object { $PSItem.Thumbprint -eq $CertificateThumbprint } | Select-Object -First 1

					if ($null -ne $ClientCertificate) {
						$WebSession.Certificates.Add($ClientCertificate) | Out-Null
					} else {
						throw "No certificate with thumbprint $CertificateThumbprint found in Cert:\CurrentUser\My or Cert:\LocalMachine\My"
					}
				}

				# Securely decode AccessToken and strip any redundant 'Bearer ' prefix
				$TokenString = (ConvertTo-InsecureString -SecureString $AccessToken) -replace '^Bearer\s+', ''

				# Set required CyberArk OAuth headers
				$WebSession.Headers['Authorization'] = "Bearer $TokenString"
				$WebSession.Headers['X-CA-Authentication-Type'] = 'OAuth'

				$psPASSession.WebSession = $WebSession
				$LogonRequest['Uri'] = $Uri
				break

			}

			( { $PSItem -match '^Gen2' } ) {

				$LogonRequest['Uri'] = "$Uri/api/Auth/$type/Logon"

			}

			( { $PSItem -match '^Gen1' } ) {

				$LogonRequest['Uri'] = "$Uri/WebServices/auth/Cyberark/CyberArkAuthenticationService.svc/Logon"

			}

			( { $PSItem -match '^Gen' } ) {


				#Get request parameters
				$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove Credential, SkipVersionCheck, SkipCertificateCheck,
				UseDefaultCredentials, CertificateThumbprint, BaseURI, PVWAAppName, OTP, type, OTPMode, OTPDelimiter, RadiusChallenge, Certificate

				#deal with newPassword SecureString
				if ($PSBoundParameters.ContainsKey('newPassword')) {

					#Include decoded password in request
					$boundParameters['newPassword'] = $(ConvertTo-InsecureString -SecureString $newPassword)

				}

				if ($type -ne 'PKIPN') {

					if ($PSBoundParameters.Keys.Contains('Credential')) {
						#Add user name from credential object
						$boundParameters['username'] = $($Credential.UserName)
						#Add decoded password value from credential object
						$boundParameters['password'] = $($Credential.GetNetworkCredential().Password)
					}

				} else {
					#PKIPN Auth
					$boundParameters['secureMode'] = $true
					$boundParameters['type'] = 'pkipn'
				}

				#RADIUS Auth
				if ($PSCmdlet.ParameterSetName -match 'Radius$') {

					#OTP in Append Mode
					if (($PSBoundParameters.ContainsKey('OTP')) -and ($PSBoundParameters['OTPMode'] -eq 'Append')) {

						if ($PSBoundParameters.ContainsKey('OTPDelimiter')) {

							#Use specified delimiter to append OTP
							$Delimiter = $OTPDelimiter

						} else {

							#delimit with comma by default
							$Delimiter = ','

						}

						#Append OTP to password
						$boundParameters['password'] = "$($boundParameters['password'])$Delimiter$OTP"

					}

					#RADIUS Challenge Mode
					elseif (($PSBoundParameters.ContainsKey('OTP')) -and ($PSBoundParameters['OTPMode'] -eq 'Challenge')) {

						if ($RadiusChallenge -eq 'Password') {

							#Send OTP first + then Password
							$boundParameters['password'] = $OTP
							$($Credential.GetNetworkCredential().Password) | Set-Variable -Name OTP

						}

					}

				}

				#Construct Request Body
				#Send as raw UTF8 bytes rather than a String so ParameterBinding/module logging of this
				#call records a non-revealing type name instead of the literal request content.
				$LogonRequest['Body'] = [System.Text.Encoding]::UTF8.GetBytes($($boundParameters | ConvertTo-Json))

				break

			}

		}

		if ($PSCmdlet.ShouldProcess($LogonRequest['Uri'], 'Logon')) {

			try {

				switch ($PSCmdlet.ParameterSetName) {
					( { $PSItem -match '^ISPSS' } ) {
						#Check IdentityCommand module available
						if (-not (Get-Module IdentityCommand)) {
							try { Import-Module IdentityCommand -ErrorAction Stop }
							catch { throw 'Failed to import IdentityCommand: Install the IdentityCommand Module and try again.' }
						}
					}
					( { $PSItem -match '^ISPSS-.*-IdentityUser$' } ) {
						#Perform Identity User Authentication using IdentityCommand module
						$PASSession = New-IDSession -tenant_url $LogonRequest['Uri'] -Credential $LogonRequest['Credential']
						break
					}
					( { $PSItem -match '^ISPSS-.*-SAML$' } ) {
						#Perform Identity User Authentication using IdentityCommand module
						$PASSession = New-IDSession -tenant_url $LogonRequest['Uri'] -SAMLResponse $LogonRequest['SAMLResponse']
						break
					}
					( { $PSItem -match '^ISPSS-.*-ServiceUser$' } ) {
						#Perform Identity User Authentication using IdentityCommand module
						$PASSession = New-IDPlatformToken -tenant_url $LogonRequest['Uri'] -Credential $LogonRequest['Credential']
						break
					}
					'OAuth' {
						#OAuth uses Bearer token directly with WebSession
						$PASSession = $TokenString
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

						#!If $RadiusChallenge = Password, $OTP will be password value
						$RADIUSResponse['OTP'] = $OTP

					}

					#Respond to RADIUS challenge
					$PASSession = Send-RADIUSResponse @RADIUSResponse

				}

			} finally {

				#If Logon Result
				if ($PASSession) {

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

						( { $PSCmdlet.ParameterSetName -eq 'OAuth' } ) {

							#OAuth 2.0 Bearer Token
							$CyberArkLogonResult = "Bearer $TokenString"

						}

						default {

							if ($PASSession.length -ge 180) {

								#V10 Auth Token.
								$CyberArkLogonResult = $PASSession

							}

						}

					}

					#Record Session Start Time
					$psPASSession.StartTime = Get-Date

					#BaseURI set in Module Scope
					$psPASSession.BaseURI = $Uri

					#API URL for non PasswordVault operations
					$psPASSession.ApiURI = $PrivilegeCloudURL

					#Auth token added to WebSession
					$psPASSession.WebSession.Headers['Authorization'] = [string]$CyberArkLogonResult

					#Initial Value for Version variable
					[System.Version]$Version = '0.0'

					if ( -not ($SkipVersionCheck)) {

						try {

							#Get CyberArk ExternalVersion number.
							[System.Version]$Version = Get-PASServer -ErrorAction Stop |
								Select-Object -ExpandProperty ExternalVersion

						} catch { [System.Version]$Version = '0.0' }

					}

					#Version information available in module scope.
					$psPASSession.ExternalVersion = $Version

					if ($PSCmdlet.ParameterSetName -eq 'OAuth' -and -not $SkipVersionCheck) {

						Assert-VersionRequirement -RequiredVersion 15.2

					}

					try {

						#Get Authenticated User.
						$User = Get-PASLoggedOnUser -ErrorAction Stop

					} catch {

						if ($PSBoundParameters.ContainsKey('Credential')) {
							$User = $Credential
						} else {
							$User = $null
						}

					} finally {

						#Note: must not be named $Username - that collides (case-insensitively) with the
						#-UserName parameter, and re-triggers its [ValidateNotNullOrEmpty()] on assignment.
						if ($null -ne $User) {
							$ResolvedUsername = $User | Select-Object -ExpandProperty UserName
						} else { $ResolvedUsername = $User }

						$psPASSession.User = $ResolvedUsername

					}

					try {

						#Get the idle session timeout (minutes) configured on the server.
						$psPASSession.IdleTimeout = Get-PASSessionTimeout -ErrorAction Stop | Select-Object -ExpandProperty Timeout

					} catch { $psPASSession.IdleTimeout = $null }

				}

			}

		}

	}#process

	end { }#end

}
