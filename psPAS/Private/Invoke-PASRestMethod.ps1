function Invoke-PASRestMethod {
	<#
.SYNOPSIS
Wrapper for Invoke-WebRequest to call REST method via API

.DESCRIPTION
Sends requests to web services, and where appropriate returns structured data.
Acts as wrapper for the Invoke-WebRequest CmdLet so that status codes can be
queried and acted on.
All requests are sent with ContentType=application/json.
If the sessionVariable parameter is passed, the function will return a WebSession
object to be used on subsequent calls to the web service.

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
so will be returned as a WebSession property in the output object.
Cannot be specified with WebSession

.PARAMETER WebSession
Accepts a WebRequestSession object containing session details
Cannot be specified with SessionVariable

.PARAMETER UseDefaultCredentials
See Invoke-WebRequest
Used for Integrated Auth

.PARAMETER TimeoutSec
See Invoke-WebRequest
Specify a timeout value in seconds

.PARAMETER CertificateThumbprint
See Invoke-WebRequest
The thumbprint of the certificate to use for client certificate authentication.

.EXAMPLE

.INPUTS

.OUTPUTS
Return data from the call to the REST API where content is returned
Will additionally set a WebSession variable in the Module Scope containing a
WebRequestSession object if the SessionVariable parameter was specified.

#>
	[CmdletBinding(DefaultParameterSetName = "WebSession")]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateSet('GET', 'POST', 'PUT', 'DELETE', 'PATCH')]
		[String]$Method,

		[Parameter(Mandatory = $true)]
		[String]$URI,

		[Parameter(Mandatory = $false)]
		[String]$Body,

		[Parameter(Mandatory = $false)]
		[hashtable]$Headers,

		[Parameter(
			Mandatory = $false,
			ParameterSetName = "SessionVariable"
		)]
		[String]$SessionVariable,

		[Parameter(
			Mandatory = $false,
			ParameterSetName = "WebSession"
		)]
		[Microsoft.PowerShell.Commands.WebRequestSession]$WebSession,

		[Parameter(Mandatory = $false)]
		[switch]$UseDefaultCredentials,

		[Parameter(Mandatory = $false)]
		[int]$TimeoutSec,

		[Parameter(Mandatory = $false)]
		[string]$CertificateThumbprint
	)

	Begin {

		#Get the name of the function which invoked this one
		$CallingFunction = Get-ParentFunction | Select-Object -ExpandProperty FunctionName

		#Add ContentType for all function calls
		$PSBoundParameters.Add("ContentType", 'application/json')
		$PSBoundParameters.Add("UseBasicParsing", $true)

		#Bypass strict RFC header parsing in PS Core
		if ($PSVersionTable.PSEdition -eq "Core") {

			$PSBoundParameters.Add("SkipHeaderValidation", $true)
			$PSBoundParameters.Add("SslProtocol", "TLS12")

		}

		#If Tls12 Security Protocol is available
		if (([Net.SecurityProtocolType].GetEnumNames() -contains "Tls12") -and

			#And Tls12 is not already in use
			(-not ([System.Net.ServicePointManager]::SecurityProtocol -match "Tls12"))) {

			[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

		}

	}

	Process {

		#Show sanitised request body if in debug mode
		If ([System.Management.Automation.ActionPreference]::SilentlyContinue -ne $DebugPreference) {

			If ($PSBoundParameters.ContainsKey("Body")) {

				Write-Debug "[Body] $(Hide-SecretValue -InputValue $Body)"

			}

		}

		try {

			#make web request, splat PSBoundParameters
			$webResponse = Invoke-WebRequest @PSBoundParameters -ErrorAction Stop

			$StatusCode = $webResponse.StatusCode

		}

		catch {

			#Catch any errors, save response
			$StatusCode = $($_.Exception.Response).StatusCode.value__

			$response = $_

		}

		finally {

			Write-Debug "[Status Code] $StatusCode"

			if ( -not ($StatusCode -match "20*")) {

				#Non 20X Status Codes & No Status Code
				<#
                    400 - Bad Request
                    401 - Unauthorised
                    403 - Forbidden
                    409 - already exists (CONFLICT)
					404 - not found
					500 - server error
					503 - service unavailable
				#>

				Try {

					$response = $response | ConvertFrom-Json
					$ErrorMessage = "[$StatusCode] $($response.ErrorMessage)"
					$ErrorID = $response.ErrorCode

				} Catch {

					$ErrorMessage = $response -replace "`n", " "
					$ErrorID = $StatusCode

				} Finally {

					$PSCmdlet.WriteError(
						[System.Management.Automation.ErrorRecord]::new(
							$ErrorMessage,
							$ErrorID,
							[System.Management.Automation.ErrorCategory]::NotSpecified,
							$response
						)
					)

				}

			}

			else {

				#status code is of type 20x
				#If there is a response from the web request
				if ($webResponse) {

					<#
                    200 - OK
                    201 - Created
                    202 - Accepted
                    204 - No Content
                    #>

					#If Response has content
					if ($webResponse.content) {

						if (($webResponse.headers)["Content-Type"] -match "application/octet-stream") {

							if ($($webResponse.content | get-member | select-object -expandproperty typename) -eq "System.Byte" ) {

								$webResponse.content

							}

						}

						elseif (($webResponse.headers)["Content-Type"] -match "application/save") {

							#'application/save' is the Content-Type returned when saving a PSM recording
							if ($($webResponse.content | get-member | select-object -expandproperty typename) -eq "System.Byte" ) {

								$webResponse.content

							}

						}

						elseif (($webResponse.headers)["Content-Type"] -match "text/html") {

							If ($webResponse.content -match '^"(.*)"$') {
								#Return only the text between opening and closing quotes
								$matches[1]
							} ElseIf ($webResponse.content -match '<HTML>') {

								$PSCmdlet.ThrowTerminatingError(
									[System.Management.Automation.ErrorRecord]::new(
										"$CallingFunction : Guru Meditation - HTML Response Received",
										$StatusCode,
										[System.Management.Automation.ErrorCategory]::NotSpecified,
										$webResponse
									)
								)
							}

						}

						Elseif (($webResponse.headers)["Content-Type"] -match "application/json") {

							#Create Return Object from Returned JSON
							$PASResponse = ConvertFrom-Json -InputObject $webResponse.content

							#Handle Logon Token Return
							If ($CallingFunction -eq "New-PASSession") {

								#Version 10
								If ($PASResponse.length -eq 180) {

									#If calling function is New-PASSession, and result is a 180 character string
									#Create a new object and assign the token to the CyberArkLogonResult property.
									$PASResponse = [PSCustomObject]@{

										CyberArkLogonResult = $PASResponse

									}

								}

								#Shared Auth
								If ($PASResponse.LogonResult) {

									#If calling function is New-PASSession, and result has a LogonResult property.
									#Create a new object and assign the LogonResult value to the CyberArkLogonResult property.
									$PASResponse = [PSCustomObject]@{

										CyberArkLogonResult = $PASResponse.LogonResult

									}

								}

							}

							#If Session Variable passed as argument
							If ($PSCmdlet.ParameterSetName -eq "SessionVariable") {

								#Make WebSession available in module scope
								Set-Variable -Name WebSession -Value $(Get-Variable $(Get-Variable sessionVariable).Value).Value -Scope Script

							}

							#Return Object
							$PASResponse

						}

						Else {

							throw $([System.Text.Encoding]::ASCII.GetString($($webResponse.content)))

						}

					}

				}

			}

		}

	}

}
