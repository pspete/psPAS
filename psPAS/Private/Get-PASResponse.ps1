function Get-PASResponse {
	<#
	.SYNOPSIS
	Receives and returns the content of the web response from the CyberArk API

	.DESCRIPTION
	Accepts a WebResponseObject.
	By default returns the Content property passed in the output of Invoke-PASRestMethod.
	Processes the API response as required depending on the format of the response, and
	the format required by the functions which initiated the request.

	.PARAMETER APIResponse
	A WebResponseObject, as returned form the PAS API using Invoke-WebRequest

	.EXAMPLE
	$WebResponseObject | Get-PASResponse

	Parses, if required, and returns, the content property of $WebResponseObject

	#>
	[CmdletBinding()]
	[OutputType('System.Object')]
	param(
		[parameter(
			Position = 0,
			Mandatory = $true,
			ValueFromPipeline = $true)]
		[ValidateNotNullOrEmpty()]
		[Microsoft.PowerShell.Commands.WebResponseObject]$APIResponse

	)

	BEGIN {

		#Get the name of the first function in the invocation stack
		$CommandOrigin = Get-ParentFunction -Scope 3 | Select-Object -ExpandProperty FunctionName

	}#begin

	PROCESS {

		if ($APIResponse.Content) {

			#Default Response - Return Content
			$PASResponse = $APIResponse.Content

			#get response content type
			$ContentType = $APIResponse.Headers["Content-Type"]

			#handle content type
			switch ($ContentType) {

				'application/octet-stream' {

					#'application/octet-stream' is expected for files returned in web requests
					if ($($PASResponse | Get-Member | Select-Object -ExpandProperty typename) -eq "System.Byte" ) {

						#return content and headers
						$PASResponse = $APIResponse | Select-Object Content, Headers

					}

				}

				'application/save' {

					#'application/save' is expected for PSM recordings returned in web requests
					if ($($PASResponse | Get-Member | Select-Object -ExpandProperty typename) -eq "System.Byte" ) {

						#return content and headers
						$PASResponse = $APIResponse | Select-Object Content, Headers

					}

				}

				'text/html; charset=utf-8' {

					#text/html response is expected from the Password/Retrieve Uri path.
					If ($PASResponse -match '^"(.*)"$') {

						#Return only the text between opening and closing quotes
						$PASResponse = $matches[1]

					} ElseIf ($PASResponse -match '<HTML>') {

						#Fail if HTML received from API

						$PSCmdlet.ThrowTerminatingError(

							[System.Management.Automation.ErrorRecord]::new(

								"Guru Meditation - HTML Response Received",
								$StatusCode,
								[System.Management.Automation.ErrorCategory]::NotSpecified,
								$APIResponse

							)

						)

					}

				}

				'application/json; charset=utf-8' {

					#application/json content expected for most responses.

					#Create Return Object from Returned JSON
					$PASResponse = ConvertFrom-Json -InputObject $APIResponse.Content

					#Handle Logon Token Return
					If ($CommandOrigin -eq "New-PASSession") {

						#Classic API returns the auth token in the CyberArkLogonResult property
						#Other auth methods/endpoints need further processing to assign the auth
						#token to a property named CyberArkLogonResult.

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

						#?SAML Auth?

					}

				}

			}

			#Return PASResponse
			$PASResponse

		}

	}#process

	END {	}#end

}