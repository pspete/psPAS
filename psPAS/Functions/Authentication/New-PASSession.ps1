# .ExternalHelp psPAS-help.xml
function New-PASSession {
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'Gen2')]
	param(
		[parameter(
			Mandatory = $true,
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
			ParameterSetName = 'SharedServices'
		)]
		[ValidateNotNullOrEmpty()]
		[PSCredential]$Credential,

		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'SharedServices'
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
		[string]$BaseURI,

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
		[Alias('SAMLToken')]
		[String]$SAMLResponse,

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
		[ValidateSet('CyberArk', 'LDAP', 'Windows', 'RADIUS', 'PKI')]
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

	BEGIN {

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

		If ($PSBoundParameters['type'] -eq 'Windows') {

			$LogonRequest['Credential'] = $Credential

		}

		If ($CertificateThumbprint) {

			$LogonRequest['CertificateThumbprint'] = $CertificateThumbprint

		}

		If ($Certificate) {

			$LogonRequest['Certificate'] = $Certificate

		}

	}#begin

	PROCESS {

		Switch ($PSCmdlet.ParameterSetName) {

			'SharedServices' {

				$LogonRequest['Uri'] = "https://${TenantSubdomain}.id.cyberark.cloud/oauth2/platformtoken"  #hardcode Shared Services auth

				#Build URL
				$Uri = "https://${TenantSubdomain}.privilegecloud.cyberark.cloud/$PVWAAppName"

				$Body = @{

					grant_type    = 'client_credentials'
					#Add user name from credential object
					client_id     = $($Credential.UserName)
					#Add decoded password value from credential object
					client_secret = $($Credential.GetNetworkCredential().Password)

				}

				$LogonRequest['Body'] = $Body
				$LogonRequest['ContentType'] = 'application/x-www-form-urlencoded'

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

				If ( -not ($PSBoundParameters.ContainsKey('SAMLResponse'))) {

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

				#Add user name from credential object
				$boundParameters['username'] = $($Credential.UserName)
				#Add decoded password value from credential object
				$boundParameters['password'] = $($Credential.GetNetworkCredential().Password)

				#RADIUS Auth
				If ($PSCmdlet.ParameterSetName -match 'Radius$') {

					#OTP in Append Mode
					If (($PSBoundParameters.ContainsKey('OTP')) -and ($PSBoundParameters['OTPMode'] -eq 'Append')) {

						If ($PSBoundParameters.ContainsKey('OTPDelimiter')) {

							#Use specified delimiter to append OTP
							$Delimiter = $OTPDelimiter

						} Else {

							#delimit with comma by default
							$Delimiter = ','

						}

						#Append OTP to password
						$boundParameters['password'] = "$($boundParameters['password'])$Delimiter$OTP"

					}

					#RADIUS Challenge Mode
					ElseIf (($PSBoundParameters.ContainsKey('OTP')) -and ($PSBoundParameters['OTPMode'] -eq 'Challenge')) {

						If ($RadiusChallenge -eq 'Password') {

							#Send OTP first + then Password
							$boundParameters['password'] = $OTP
							$OTP = $($Credential.GetNetworkCredential().Password)

						}

					}

				}

				#deal with newPassword SecureString
				If ($PSBoundParameters.ContainsKey('newPassword')) {

					#Include decoded password in request
					$boundParameters['newPassword'] = $(ConvertTo-InsecureString -SecureString $newPassword)

				}

				#Construct Request Body
				$LogonRequest['Body'] = $boundParameters | ConvertTo-Json

				break

			}

		}

		if ($PSCmdlet.ShouldProcess($LogonRequest['Uri'], 'Logon')) {

			try {

				#Send Logon Request
				$PASSession = Invoke-PASRestMethod @LogonRequest

				If ($null -ne $PASSession.UserName) {

					#*$PASSession is expected to be a string value
					#*For IIS Windows/PKI auth:
					#*An object with a username property will be returned if a secondary authentication is required

					#Use WebSession from initial request
					$LogonRequest.Remove('SessionVariable')
					$LogonRequest['WebSession'] = $Script:WebSession

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

				} Else {

					#ITATS542I is expected for RADIUS Challenge

					#Use WebSession from initial request
					$LogonRequest.Remove('SessionVariable')
					$LogonRequest['WebSession'] = $Script:WebSession

					#Collect values required to respond to the challenge
					$RADIUSResponse = @{}
					$RADIUSResponse['LogonRequest'] = $LogonRequest
					$RADIUSResponse['Message'] = $($PSItem.Exception.Message)

					#Include any OTP value provided in the RADIUS Response
					If ($PSBoundParameters.ContainsKey('OTP')) {

						#!If $RadiusChallenge = Password, $OTP will be password value
						$RADIUSResponse['OTP'] = $OTP

					}

					#Respond to RADIUS challenge
					$PASSession = Send-RADIUSResponse @RADIUSResponse

				}

			} finally {

				#If Logon Result
				If ($PASSession) {

					If ($null -ne $PASSession.UserName) {

						throw "No Session Token for user $($PASSession.UserName)"

					}

					#Version 10
					If ($PASSession.length -ge 180) {

						#V10 Auth Token.
						$CyberArkLogonResult = $PASSession

					}

					#Shared Services
					ElseIf ($PASSession.access_token) {

						#Shared Service access_token.
						$CyberArkLogonResult = "$($PASSession.token_type) $($PASSession.access_token)"

					}

					#Shared Auth
					ElseIf ($PASSession.LogonResult) {

						#Shared Auth LogonResult.
						$CyberArkLogonResult = $PASSession.LogonResult

					}

					#Classic
					Else {

						#Classic CyberArkLogonResult
						$CyberArkLogonResult = $PASSession.CyberArkLogonResult

					}

					#BaseURI set in Module Scope
					Set-Variable -Name BaseURI -Value $Uri -Scope Script

					#Auth token added to WebSession
					$Script:WebSession.Headers['Authorization'] = [string]$CyberArkLogonResult

					#Initial Value for Version variable
					[System.Version]$Version = '0.0'

					if ( -not ($SkipVersionCheck)) {

						Try {

							#Get CyberArk ExternalVersion number.
							[System.Version]$Version = Get-PASServer -ErrorAction Stop |
								Select-Object -ExpandProperty ExternalVersion

						} Catch { [System.Version]$Version = '0.0' }

					}

					#Version information available in module scope.
					Set-Variable -Name ExternalVersion -Value $Version -Scope Script

				}

			}

		}

	}#process

	END { }#end

}