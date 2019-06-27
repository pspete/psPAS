#Get Current Directory
$Here = Split-Path -Parent $MyInvocation.MyCommand.Path

#Get Function Name
$FunctionName = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -Replace ".Tests.ps1"

#Assume ModuleName from Repository Root folder
$ModuleName = Split-Path (Split-Path $Here -Parent) -Leaf

#Resolve Path to Module Directory
$ModulePath = Resolve-Path "$Here\..\$ModuleName"

#Define Path to Module Manifest
$ManifestPath = Join-Path "$ModulePath" "$ModuleName.psd1"

if ( -not (Get-Module -Name $ModuleName -All)) {

	Import-Module -Name "$ManifestPath" -ArgumentList $true -Force -ErrorAction Stop

}

Describe $FunctionName {

	InModuleScope $ModuleName {

		Context "Standard Operation" {

			BeforeEach {

				$Response = New-MockObject -Type Microsoft.PowerShell.Commands.WebResponseObject
				$Response | Add-Member -MemberType NoteProperty -Name StatusCode -Value 200 -Force
				$Response | Add-Member -MemberType NoteProperty -Name Headers -Value @{ "Content-Type" = 'application/json; charset=utf-8' } -Force
				$Response | Add-Member -MemberType NoteProperty -Name Content -Value (@{
						"prop1"   = "value1";
						"prop2"   = "value2";
						"prop123" = 123
						"test"    = 321
					} | ConvertTo-Json) -Force

				$Failure = New-MockObject -Type Microsoft.PowerShell.Commands.WebResponseObject
				$Failure | Add-Member -MemberType NoteProperty -Name StatusCode -Value 409 -Force

				Mock Invoke-WebRequest -MockWith {

					return $Response

				}

				$SessionVariable = @{
					"URI"             = "https://CyberArk_URL"
					"Method"          = "GET"
					"SessionVariable" = "varSession"
				}

				$WebSession = @{
					"URI"        = "https://CyberArk_URL"
					"Method"     = "GET"
					"WebSession" = New-Object Microsoft.PowerShell.Commands.WebRequestSession
					"Body"       = "something"
				}

				Set-Variable varSession -Value $(New-Object Microsoft.PowerShell.Commands.WebRequestSession)
				$VarSession.Headers["Test"] = "OK"

			}

			It "does not throw" {

				{ Invoke-PASRestMethod @WebSession -Debug 5>&1 } | Should -Not -Throw

			}
			It "sends request" {

				Invoke-PASRestMethod @WebSession
				Assert-MockCalled "Invoke-WebRequest" -Times 1 -Scope It -Exactly

			}

			if ([Net.SecurityProtocolType].GetEnumNames() -contains "Tls12") {

				It "enforces use of TLS 1.2" {
					[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls11
					Invoke-PASRestMethod @WebSession
					[System.Net.ServicePointManager]::SecurityProtocol | Should Be Tls12
				}

			}

			#PSCore specific
			If ($IsCoreCLR) {

				it "specifies -SslProtocol TLS12" {
					Invoke-PASRestMethod @WebSession
					Assert-MockCalled "Invoke-WebRequest" -Times 1 -Scope It -Exactly -ParameterFilter {
						$SslProtocol -eq "TLS12"
					}
				}

				it "specifies SkipHeaderValidation" {
					Invoke-PASRestMethod @WebSession
					Assert-MockCalled "Invoke-WebRequest" -Times 1 -Scope It -Exactly -ParameterFilter {
						$SkipHeaderValidation -eq $true
					}
				}

			}

			It "sets WebSession variable in the module scope" {
				Invoke-PASRestMethod @SessionVariable
				$Script:WebSession | Should Not BeNullOrEmpty
			}

			It "returns WebSession sessionvariable value" {
				Invoke-PASRestMethod @SessionVariable
				$Script:WebSession.Headers["Test"] | Should Be "OK"
			}

			It "sends output to Get-PASResponse" {
				Mock Get-PASResponse { }
				Invoke-PASRestMethod @WebSession
				Assert-MockCalled "Get-PASResponse" -Times 1 -Scope It -Exactly
			}

			It "does not invoke Get-PASResponse if there an error code indicating failure" {
				Mock Invoke-WebRequest -MockWith {

					return $Failure

				}
				Mock Get-PASResponse { }
				Invoke-PASRestMethod @WebSession
				Assert-MockCalled "Get-PASResponse" -Times 0 -Scope It -Exactly
			}

		}

		Context "Error Handling" {

			BeforeEach {

				$errorDetails = $([pscustomobject]@{"ErrorCode" = "URA999"; "ErrorMessage" = "Some Error Message" } | ConvertTo-Json)
				$statusCode = 400
				$response = New-Object System.Net.Http.HttpResponseMessage $statusCode
				$exception = New-Object Microsoft.PowerShell.Commands.HttpResponseException "$statusCode ($($response.ReasonPhrase))", $response
				$errorCategory = [System.Management.Automation.ErrorCategory]::InvalidOperation
				$errorID = 'WebCmdletWebResponseException,Microsoft.PowerShell.Commands.InvokeWebRequestCommand'
				$targetObject = $null
				$errorRecord = New-Object Management.Automation.ErrorRecord $exception, $errorID, $errorCategory, $targetObject
				$errorRecord.ErrorDetails = $errorDetails

				$WebSession = @{
					"URI"        = "https://CyberArk_URL"
					"Method"     = "GET"
					"WebSession" = New-Object Microsoft.PowerShell.Commands.WebRequestSession
					"Body"       = "something"
				}

			}

			it "catches Uri Format Exceptions" {

				{ Invoke-PASRestMethod -Method GET -URI "/s/r/f/c" } | Should -Throw -ExpectedMessage "Invalid URI: The hostname could not be parsed. Run New-PASSession"
			}

			it "reports generic Http Request Exceptions" {

				$Credentials = New-Object System.Management.Automation.PSCredential ("SomeUser", $(ConvertTo-SecureString "SomePassword" -AsPlainText -Force))
				{ New-PASSession -Credential $Credentials -BaseURI "https://dead.server.no-site.io" } | Should -Throw -ExpectedMessage "Error contacting https://dead.server.no-site.io"

			}

			it "reports expected error message" {

				Mock Invoke-WebRequest { Throw $errorRecord }

				{ Invoke-PASRestMethod @WebSession } | Should -Throw -ExpectedMessage "[400] Some Error Message"

			}

			it "reports http errors not returned as json" {
				$errorDetails = '"ErrorCode" [=] "URA999"[;] "ErrorMessage" [=] "Some Error Message"'
				$errorRecord = New-Object Management.Automation.ErrorRecord $exception, $errorID, $errorCategory, $targetObject
				$errorRecord.ErrorDetails = $errorDetails
				Mock Invoke-WebRequest { Throw $errorRecord }
				{ Invoke-PASRestMethod @WebSession } | Should -Throw
			}

			it "catches other errors" {

				Mock Invoke-WebRequest { Throw "Some Error" }

				{ Invoke-PASRestMethod @WebSession } | Should -Throw -ExpectedMessage "Some Error"

			}

		}

	}

}