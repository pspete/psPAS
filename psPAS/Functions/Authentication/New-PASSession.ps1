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
		[ValidateNotNullOrEmpty()]
		[PSCredential]$Credential,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			ParameterSetName = 'Gen1Radius'
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
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2SAML'
		)]
		[switch]$SAMLAuth,

		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1SAML'
		)]
		[String]$SAMLToken,

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
		[ValidateSet('CyberArk', 'LDAP', 'Windows', 'RADIUS')]
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
		[ValidateLength(1, 1)]
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
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$BaseURI,

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

			'integrated' {

				$LogonRequest['Uri'] = "$baseURI/$PVWAAppName/api/Auth/Windows/Logon"  #hardcode Windows for integrated auth

				#Construct Request Body
				#The only expected parameter should be concurrentSessions
				$LogonRequest['Body'] = $PSBoundParameters | Get-PASParameter -ParametersToKeep concurrentSession | ConvertTo-Json

				break

			}

			'shared' {

				$LogonRequest['Uri'] = "$baseURI/$PVWAAppName/WebServices/auth/Shared/RestfulAuthenticationService.svc/Logon"
				break

			}

			'Gen1SAML' {

				$LogonRequest['Uri'] = "$baseURI/$PVWAAppName/WebServices/auth/SAML/SAMLAuthenticationService.svc/Logon"

				#add token to header
				$LogonRequest['Headers'] = @{'Authorization' = $SAMLToken }
				break

			}

			'Gen2SAML' {

				$URI = "$baseURI/$PVWAAppName/api/Auth/SAML/Logon"
				break

			}

			( { $PSItem -match '^Gen2' } ) {

				$LogonRequest['Uri'] = "$baseURI/$PVWAAppName/api/Auth/$type/Logon"

			}

			( { $PSItem -match '^Gen1' } ) {

				$LogonRequest['Uri'] = "$baseURI/$PVWAAppName/WebServices/auth/Cyberark/CyberArkAuthenticationService.svc/Logon"

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

		if ($PSCmdlet.ShouldProcess("$BaseURI/$PVWAAppName", 'Logon')) {

			try {

				If ($PSCmdlet.ParameterSetName -eq 'Gen2SAML') {

					#The only expected parameter should be concurrentSessions
					$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove SAMLAuth,
					SkipVersionCheck, SkipCertificateCheck, CertificateThumbprint, BaseURI, PVWAAppName, Certificate

					#*For SAML auth:
					#*https://gist.github.com/infamousjoeg/b44faa299ec3de65bdd1d3b8474b0649
					$SAMLResponse = Get-PASSAMLResponse -URL "$baseURI/$PVWAAppName"

					#add required parameters
					$boundParameters.Add('SAMLResponse', $SAMLResponse)
					$boundParameters.Add('apiUse', $true)

					#Create Logon URL
					$LogonString = $boundParameters | ConvertTo-QueryString

					if ($LogonString) {

						#Build URL from base URL
						$URI = "$URI`?$LogonString"

					}

					$LogonRequest['Uri'] = $URI

				}

				#Send Logon Request
				$PASSession = Invoke-PASRestMethod @LogonRequest

				If ($null -ne $PASSession.UserName) {

					#*$PASSession is expected to be a string value
					#*For IIS Windows auth:
					#*An object with a username property can be returned if a secondary authentication is required

					If ($PSCmdlet.ParameterSetName -match 'Radius$') {

						#If RADIUS parameters are specified
						#Prepare RADIUS auth request
						$LogonRequest['Uri'] = "$baseURI/$PVWAAppName/api/Auth/RADIUS/Logon"

						#Use WebSession from initial request
						$LogonRequest.Remove('SessionVariable')
						$LogonRequest['WebSession'] = $Script:WebSession

						#Submit initial RADIUS auth request
						$PASSession = Invoke-PASRestMethod @LogonRequest

					}

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

					#?SAML Auth?

					#BaseURI set in Module Scope
					Set-Variable -Name BaseURI -Value "$BaseURI/$PVWAAppName" -Scope Script

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