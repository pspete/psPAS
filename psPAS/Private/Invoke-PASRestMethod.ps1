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

.EXAMPLE

.INPUTS

.OUTPUTS
Return data from the call to the REST API where content is returned
Will additionally contain a WebSession property containing a WebRequestSession object if SessionVariable
parameter was specified.

.NOTES
SessionVariable/WebSession functionality should be used where the API exists behind a load balancer
to ensure session persistence.

.LINK

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
		[int]$TimeoutSec
	)

	Begin {

		#Get the name of the function which invoked this one
		$CallingFunction = Get-ParentFunction | Select-Object -ExpandProperty FunctionName
		Write-Debug "Function: $($MyInvocation.InvocationName)"
		Write-Debug "Invocation Origin: $CallingFunction"

		#Add ContentType for all function calls
		$PSBoundParameters.Add("ContentType", 'application/json')
		$PSBoundParameters.Add("UseBasicParsing", $true)

		#Bypass strict RFC header parsing in PS Core
		if ($PSVersionTable.PSEdition -eq "Core") {

			$PSBoundParameters.Add("SkipHeaderValidation", $true)
			$PSBoundParameters.Add("SslProtocol", "TLS12")

		}

		#If Tls12 Security Protocol is available
		if(([Net.SecurityProtocolType].GetEnumNames() -contains "Tls12") -and

			#And Tls12 is not already in use
			(-not ([System.Net.ServicePointManager]::SecurityProtocol -match "Tls12"))) {

			Write-Verbose "Setting Security Protocol to TLS12"
			[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

		}

		Else {

			Write-Debug "Security Protocol: $([System.Net.ServicePointManager]::SecurityProtocol)"

		}

	}

	Process {

		try {

			#make web request, splat PSBoundParameters
			$webResponse = Invoke-WebRequest @PSBoundParameters -ErrorAction Stop

			$StatusCode = $webResponse.StatusCode

		}

		catch {

			#Catch any errors, save response
			$StatusCode = $($_.Exception.Response).StatusCode.value__

			Write-Debug $_

			$response = $_

		}

		finally {

			Write-Debug "Status code: $StatusCode"

			if( -not ($StatusCode -match "20*")) {

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

					Write-Error -Message $ErrorMessage -ErrorId $ErrorID

				}

			}

			else {

				#status code is of type 20x
				#If there is a response from the web request
				if($webResponse) {

					<#
                    200 - OK
                    201 - Created
                    202 - Accepted
                    204 - No Content
                    #>

					#If Response has content
					if($webResponse.content) {

						if(($webResponse.headers)["Content-Type"] -match "application/octet-stream") {

							if($($webResponse.content | get-member | select-object -expandproperty typename) -eq "System.Byte" ) {

								$webResponse.content

							}

						}

						elseif(($webResponse.headers)["Content-Type"] -match "application/save") {

							#'application/save' is the Content-Type returned when saving a PSM recording
							if($($webResponse.content | get-member | select-object -expandproperty typename) -eq "System.Byte" ) {

								$webResponse.content

							}

						}

						elseif(($webResponse.headers)["Content-Type"] -match "text/html") {

							Write-Debug "$($webResponse.content)"

							If($webResponse.content -match '^"(.*)"$') {
								#Return only the text between opening and closing quotes
								$matches[1]
							} ElseIf($webResponse.content -match '<HTML>') {
								throw "Guru Meditation - HTML Response Received"
							}

						}

						Elseif(($webResponse.headers)["Content-Type"] -match "application/json") {

							#Create Return Object from Returned JSON
							$PASResponse = ConvertFrom-Json -InputObject $webResponse.content

							#Handle Version 10 Logon Token Return
							If(($CallingFunction -eq "New-PASSession") -and ($PASResponse.length -eq 180)) {

								Write-Verbose "Assigning token to CyberArkLogonResult"
								#If calling function is New-PASSession, and result is a 180 character token
								#Create a new object and assign the token to the CyberArkLogonResult property.
								#This ensures an object is returned instead of a string (which would cause issues).
								$PASResponse = [PSCustomObject]@{

									CyberArkLogonResult = $PASResponse

								}

							}

							#If Session Variable passed as argument
							If($PSBoundParameters.ContainsKey("SessionVariable")) {

								Write-verbose "SessionVariable Passed; Processing WebSession"

								#Add WebSession Object to Return Object
								$PASResponse | Add-ObjectDetail -PropertyToAdd @{

									#WebSession is stored in sessionVariable variable in current scope
									"WebSession" = $(Get-Variable $(Get-Variable sessionVariable).Value).Value

								} -Passthru $false

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
