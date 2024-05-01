function Invoke-PASRestMethod {
	<#
	.SYNOPSIS
	Wrapper for Invoke-WebRequest to call REST method via API

	.DESCRIPTION
	Sends requests to web services. Catches Exceptions. Outputs Success.
	Acts as wrapper for the Invoke-WebRequest CmdLet so that status codes can be
	queried and acted on.
	All requests are sent with ContentType=application/json.
	If the sessionVariable parameter is passed, the function will return the WebSession
	object to the $($psPASSession.WebSession) variable.

	.PARAMETER Method
	The method for the REST Method.
	Only accepts GET, POST, PUT, PATCH or DELETE

	.PARAMETER URI
	The address of the API or service to send the request to.

	.PARAMETER Body
	The body of the request to send to the API

	.PARAMETER Headers
	The header of the request to send to the API.

	.PARAMETER SessionVariable
	If passed, will be sent to invoke-webrequest which in turn will create a websession
	variable using the string value as the name. This variable will only exist in the current scope
	so will be set as the value of $($psPASSession.WebSession) to be available in a modules scope.
	Cannot be specified with WebSession

	.PARAMETER WebSession
	Accepts a WebRequestSession object containing session details
	Cannot be specified with SessionVariable

	.PARAMETER UseDefaultCredentials
	See Invoke-WebRequest
	Used for Integrated Auth

	.PARAMETER Credential
	See Invoke-WebRequest
	Used for Integrated Auth

	.PARAMETER TimeoutSec
	See Invoke-WebRequest
	Specify a timeout value in seconds

	.PARAMETER Certificate
	See Invoke-WebRequest
	The client certificate used for a secure web request.

	.PARAMETER CertificateThumbprint
	See Invoke-WebRequest
	The thumbprint of the certificate to use for client certificate authentication.

	.PARAMETER SkipCertificateCheck
	Skips certificate validation checks.

	.EXAMPLE
	Invoke-PASRestMethod -Uri $URI -Method DELETE

	Send request to web service
	#>
	[CmdletBinding(DefaultParameterSetName = 'WebSession')]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateSet('GET', 'POST', 'PUT', 'DELETE', 'PATCH')]
		[String]$Method,

		[Parameter(Mandatory = $true)]
		[String]$URI,

		[Parameter(Mandatory = $false)]
		[Object]$Body,

		[Parameter(Mandatory = $false)]
		[hashtable]$Headers,

		[Parameter(
			Mandatory = $false,
			ParameterSetName = 'SessionVariable'
		)]
		[String]$SessionVariable,

		[Parameter(
			Mandatory = $false,
			ParameterSetName = 'WebSession'
		)]
		[Microsoft.PowerShell.Commands.WebRequestSession]$WebSession,

		[Parameter(Mandatory = $false)]
		[switch]$UseDefaultCredentials,

		[Parameter(Mandatory = $false)]
		[PSCredential]$Credential,

		[Parameter(Mandatory = $false)]
		[int]$TimeoutSec,

		[Parameter(Mandatory = $false)]
		[X509Certificate]$Certificate,

		[Parameter(Mandatory = $false)]
		[string]$CertificateThumbprint,

		[Parameter(Mandatory = $false)]
		[switch]$SkipCertificateCheck,

		[Parameter(Mandatory = $false)]
		[string]$ContentType
	)

	Begin {

		#Set defaults for all function calls
		$ProgressPreference = 'SilentlyContinue'
		$PSBoundParameters.Add('UseBasicParsing', $true)

		if ( -not ($PSBoundParameters.ContainsKey('ContentType'))) {

			$PSBoundParameters.Add('ContentType', 'application/json')

		}

		if (($PSCmdlet.ParameterSetName -ne 'SessionVariable') -and ($null -ne $psPASSession.WebSession)) {

			#use the WebSession if it exists in the module scope, and alternate session or SessionVariable is not specified.
			if ( -not ($PSBoundParameters.ContainsKey('WebSession'))) {

				$PSBoundParameters.Add('WebSession', $psPASSession.WebSession)

			}

		}

		#Bypass strict RFC header parsing in PS Core
		#Use TLS 1.2
		if (Test-IsCoreCLR) {

			$PSBoundParameters.Add('SkipHeaderValidation', $true)
			$PSBoundParameters.Add('SslProtocol', 'TLS12')

		}

		Switch ($PSBoundParameters.ContainsKey('SkipCertificateCheck')) {

			$true {

				#SkipCertificateCheck Declared
				if ( -not (Test-IsCoreCLR)) {

					#Remove parameter, incompatible with PowerShell
					$PSBoundParameters.Remove('SkipCertificateCheck') | Out-Null

					if ($SkipCertificateCheck) {

						#Skip SSL Validation
						Skip-CertificateCheck

					}

				} else {

					#PWSH
					if ($SkipCertificateCheck) {

						#Ongoing SSL Validation Bypass Required
						$Script:SkipCertificateCheck = $true

					}

				}

			}

			$false {

				#SkipCertificateCheck Not Declared
				#SSL Validation Bypass Previously Requested
				If ($Script:SkipCertificateCheck) {

					#PWSH Zone
					if (Test-IsCoreCLR) {

						#Add SkipCertificateCheck to PS Core command
						#Parameter must be included for all pwsh invocations of Invoke-WebRequest
						$PSBoundParameters.Add('SkipCertificateCheck', $true)

					}

				}

			}

		}

		#If Tls12 Security Protocol is available
		if (([Net.SecurityProtocolType].GetEnumNames() -contains 'Tls12') -and

			#And Tls12 is not already in use
			(-not ([System.Net.ServicePointManager]::SecurityProtocol -match 'Tls12'))) {

			[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

		}

	}

	Process {

		#Show sanitised request body if in debug mode
		If ([System.Management.Automation.ActionPreference]::SilentlyContinue -ne $DebugPreference) {

			If (($PSBoundParameters.ContainsKey('Body')) -and (($PSBoundParameters['Body']).GetType().Name -eq 'String')) {

				Write-Debug "[Body] $(Hide-SecretValue -InputValue $Body)"

			}

		}

		try {

			#make web request, splat PSBoundParameters
			$APIResponse = Invoke-WebRequest @PSBoundParameters -ErrorAction Stop

		} catch [System.UriFormatException] {

			#Catch URI Format errors. Likely $($psPASSession.BaseURI) is not set; New-PASSession should be run.
			$PSCmdlet.ThrowTerminatingError(

				[System.Management.Automation.ErrorRecord]::new(

					"$PSItem Run New-PASSession",
					$null,
					[System.Management.Automation.ErrorCategory]::NotSpecified,
					$PSItem

				)

			)

		} catch {

			$psPASSession.LastError = $PSItem
			$psPASSession.LastErrorTime = Get-Date

			#Privilege Cloud Shared Services Error Handling
			If ($PSitem.TargetObject.RequestUri.Host -match 'cyberark.cloud') {

				$ResponseException = $($PSItem.ErrorDetails.Message)

				If ($null -ne $($ResponseException)) {

					try {

						$ThisException = $ResponseException | ConvertFrom-Json

						switch ($ThisException) {

							{ $null -ne $PSItem.ErrorMessage } {
								$ErrorMessage = $ThisException | Select-Object -ExpandProperty ErrorMessage
							}

							{ $null -ne $PSItem.ErrorCode } {
								$ErrorID = $ThisException | Select-Object -ExpandProperty ErrorCode
							}

							{ $null -ne $PSItem.error_description } {
								$ErrorMessage = $ThisException | Select-Object -ExpandProperty error_description
							}

							{ $null -ne $PSItem.error } {
								$ErrorID = $ThisException | Select-Object -ExpandProperty error
							}

							{ $null -ne $PSItem.message } {
								$ErrorMessage = $ThisException | Select-Object -ExpandProperty message
							}

							{ $null -ne $PSItem.code } {
								$ErrorID = $ThisException | Select-Object -ExpandProperty code
							}

							default {
								$ErrorMessage = $ResponseException
								$ErrorID = $null
							}

						}
					} catch {
						$ErrorMessage = $ResponseException
						$ErrorID = $null
					}
				}

			}

			#Original Flavour Error Handling
			Else {

				$ErrorID = $null
				$StatusCode = $($PSItem.Exception.Response).StatusCode.value__
				$ErrorMessage = $($PSItem.Exception.Message)

				$Response = $PSItem.Exception | Select-Object -ExpandProperty 'Response' -ErrorAction Ignore
				if ( $Response ) {

					$ErrorDetails = $($PSItem.ErrorDetails)
				}

				# Not an exception making the request or the failed request didn't have a response body.
				if ( $null -eq $ErrorDetails ) {

					throw $PSItem

				} Else {

					If (-not($StatusCode)) {

						#Generic failure message if no status code/response
						$ErrorMessage = "Error contacting $($PSItem.TargetObject.RequestUri.AbsoluteUri)"

					} ElseIf ($ErrorDetails) {

						try {

							#Convert ErrorDetails JSON to Object
							$Response = $ErrorDetails | ConvertFrom-Json

							#API Error Message
							$ErrorMessage = "[$StatusCode] $($Response.ErrorMessage)"

							#API Error Code
							$ErrorID = $Response.ErrorCode

							#Inner error details are present
							if ($Response.Details) {

								#Join Inner Error Text to Error Message
								$ErrorMessage = $ErrorMessage, $(($Response.Details | Select-Object -ExpandProperty ErrorMessage) -join ', ') -join ': '

								#Join Inner Error Codes to ErrorID
								$ErrorID = $ErrorID, $(($Response.Details | Select-Object -ExpandProperty ErrorCode) -join ',') -join ','

							}

						} catch {

							#If error converting JSON, return $ErrorDetails
							#replace any new lines or whitespace with single spaces
							$ErrorMessage = $ErrorDetails -replace "(`n|\W+)", ' '
							#Use $StatusCode as ErrorID
							$ErrorID = $StatusCode

						}
					}

				}

			}

			#throw the error
			$PSCmdlet.ThrowTerminatingError(

				[System.Management.Automation.ErrorRecord]::new(

					$ErrorMessage,
					$ErrorID,
					[System.Management.Automation.ErrorCategory]::NotSpecified,
					$PSItem

				)

			)

		} finally {

			#Add Command Data to $psPASSession module scope variable
			$psPASSession.LastCommand = Get-ParentFunction | Select-Object -ExpandProperty CommandData
			$psPASSession.LastCommandResults = $APIResponse
			$psPASSession.LastCommandTime = Get-Date

			#If Session Variable passed as argument
			If ($PSCmdlet.ParameterSetName -eq 'SessionVariable') {

				#Make the WebSession available in the module scope
				$psPASSession.WebSession = $(Get-Variable $(Get-Variable sessionVariable).Value).Value

			}

			#If Command Succeeded
			if ($?) {

				#Status code indicates success
				If ($APIResponse.StatusCode -match '^20\d$') {

					#Pass APIResponse to Get-PASResponse
					$APIResponse | Get-PASResponse

				}

			}

		}

	}

	End { }

}
