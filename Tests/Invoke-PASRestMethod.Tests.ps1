Describe $($PSCommandPath -Replace '.Tests.ps1') {

	BeforeAll {
		#Get Current Directory
		$Here = Split-Path -Parent $PSCommandPath

		#Assume ModuleName from Repository Root folder
		$ModuleName = Split-Path (Split-Path $Here -Parent) -Leaf

		#Resolve Path to Module Directory
		$ModulePath = Resolve-Path "$Here\..\$ModuleName"

		#Define Path to Module Manifest
		$ManifestPath = Join-Path "$ModulePath" "$ModuleName.psd1"

		if ( -not (Get-Module -Name $ModuleName -All)) {

			Import-Module -Name "$ManifestPath" -ArgumentList $true -Force -ErrorAction Stop

		}

		$Script:RequestBody = $null
		$psPASSession = [ordered]@{
			BaseURI            = 'https://SomeURL/SomeApp'
			User               = $null
			ExternalVersion    = [System.Version]'0.0'
			WebSession         = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			StartTime          = $null
			ElapsedTime        = $null
			LastCommand        = $null
			LastCommandTime    = $null
			LastCommandResults = $null
		}

		New-Variable -Name psPASSession -Value $psPASSession -Scope Script -Force

	}


	AfterAll {

		$Script:RequestBody = $null

	}

	InModuleScope $(Split-Path (Split-Path (Split-Path -Parent $PSCommandPath) -Parent) -Leaf ) {

		Context 'Standard Operation' {

			BeforeEach {

				$Response = New-MockObject -Type Microsoft.PowerShell.Commands.WebResponseObject
				$Response | Add-Member -MemberType NoteProperty -Name StatusCode -Value 200 -Force
				$Response | Add-Member -MemberType NoteProperty -Name Headers -Value @{ 'Content-Type' = 'application/json; charset=utf-8' } -Force
				$Response | Add-Member -MemberType NoteProperty -Name Content -Value (@{
						'prop1'   = 'value1'
						'prop2'   = 'value2'
						'prop123' = 123
						'test'    = 321
					} | ConvertTo-Json) -Force

				$Failure = New-MockObject -Type Microsoft.PowerShell.Commands.WebResponseObject
				$Failure | Add-Member -MemberType NoteProperty -Name StatusCode -Value 409 -Force

				Mock Invoke-WebRequest -MockWith {

					return $Response

				}

				Mock Skip-CertificateCheck -MockWith { }

				$SessionVariable = @{
					'URI'             = 'https://CyberArk_URL'
					'Method'          = 'GET'
					'SessionVariable' = 'varSession'
				}

				$WebSession = @{
					'URI'        = 'https://CyberArk_URL'
					'Method'     = 'GET'
					'WebSession' = New-Object Microsoft.PowerShell.Commands.WebRequestSession
					'Body'       = 'something'
				}

				Set-Variable varSession -Value $(New-Object Microsoft.PowerShell.Commands.WebRequestSession)
				$VarSession.Headers['Test'] = 'OK'

			}

			It 'does not throw' {

				{ $DebugPreference = 'Continue'
					Invoke-PASRestMethod @WebSession 5>&1
					$DebugPreference = 'SilentlyContinue' } | Should -Not -Throw

			}
			It 'sends request' {

				Invoke-PASRestMethod @WebSession
				Assert-MockCalled 'Invoke-WebRequest' -Times 1 -Scope It -Exactly

			}

			if ([Net.SecurityProtocolType].GetEnumNames() -contains 'Tls12') {

				It 'enforces use of TLS 1.2' {
					[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls11
					Invoke-PASRestMethod @WebSession
					[System.Net.ServicePointManager]::SecurityProtocol | Should -Be Tls12
				}

			}

			It 'specifies -SslProtocol TLS12' {

				If ($IsCoreCLR) {

					Mock Test-IsCoreCLR -MockWith { return $true }
					Mock Invoke-WebRequest -MockWith { }
					Invoke-PASRestMethod @WebSession
					Assert-MockCalled 'Invoke-WebRequest' -Times 1 -Scope It -Exactly -ParameterFilter {
						$SslProtocol -eq 'TLS12'
					}
				} else { Set-ItResult -Inconclusive }
			}

			It 'specifies SkipHeaderValidation' {

				If ($IsCoreCLR) {
					Mock Test-IsCoreCLR -MockWith { return $true }
					Mock Invoke-WebRequest -MockWith { }

					Invoke-PASRestMethod @WebSession
					Assert-MockCalled 'Invoke-WebRequest' -Times 1 -Scope It -Exactly -ParameterFilter {
						$SkipHeaderValidation -eq $true
					}
				} else { Set-ItResult -Inconclusive }
			}

			It 'invokes Skip-CertificateCheck when run from PowerShell' {
				Mock Test-IsCoreCLR -MockWith { return $false }
				Invoke-PASRestMethod @WebSession -SkipCertificateCheck
				Assert-MockCalled 'Skip-CertificateCheck' -Times 1 -Scope It -Exactly
			}

			It 'uses parameter SkipCertificateCheck when run from PWSH' {

				If ($IsCoreCLR) {
					Mock Test-IsCoreCLR -MockWith { return $true }

					Mock Invoke-WebRequest -MockWith { }
					Invoke-PASRestMethod @WebSession -SkipCertificateCheck
					Assert-MockCalled 'Invoke-WebRequest' -Times 1 -Scope It -Exactly -ParameterFilter {
						$SkipCertificateCheck -eq $true
					}
				} else { Set-ItResult -Inconclusive }
			}

			It 'Skips Certificate Validation when run from PWSH' {
				If ($IsCoreCLR) {

					Mock Test-IsCoreCLR -MockWith { return $true }
					Mock Invoke-WebRequest -MockWith { }
					$Script:SkipCertificateCheck = $true
					Invoke-PASRestMethod @WebSession
					Assert-MockCalled 'Invoke-WebRequest' -Times 1 -Scope It -Exactly -ParameterFilter {
						$SkipCertificateCheck -eq $true
					}

				} else { Set-ItResult -Inconclusive }
			}


			It 'sets WebSession variable in the module scope' {
				Invoke-PASRestMethod @SessionVariable
				$psPASSession.WebSession | Should -Not -BeNullOrEmpty
			}

			It 'returns WebSession sessionvariable value' {
				Invoke-PASRestMethod @SessionVariable
				$psPASSession.WebSession.Headers['Test'] | Should -Be 'OK'
			}

			It 'sends output to Get-PASResponse' {
				Mock Get-PASResponse { }
				Invoke-PASRestMethod @WebSession
				Assert-MockCalled 'Get-PASResponse' -Times 1 -Scope It -Exactly
			}

			It 'does not invoke Get-PASResponse if there an error code indicating failure' {
				Mock Invoke-WebRequest -MockWith {

					return $Failure

				}
				Mock Get-PASResponse { }
				Invoke-PASRestMethod @WebSession
				Assert-MockCalled 'Get-PASResponse' -Times 0 -Scope It -Exactly
			}

		}

		Context 'Error Handling' {

			BeforeEach {

				If ($IsCoreCLR) {
					$errorDetails = $([pscustomobject]@{'ErrorCode' = 'URA999'; 'ErrorMessage' = 'Some Error Message' } | ConvertTo-Json)
					$statusCode = 400
					$response = New-Object System.Net.Http.HttpResponseMessage $statusCode
					$exception = New-Object Microsoft.PowerShell.Commands.HttpResponseException "$statusCode ($($response.ReasonPhrase))", $response
					$errorCategory = [System.Management.Automation.ErrorCategory]::InvalidOperation
					$errorID = 'WebCmdletWebResponseException,Microsoft.PowerShell.Commands.InvokeWebRequestCommand'
					$targetObject = $null
					$errorRecord = New-Object Management.Automation.ErrorRecord $exception, $errorID, $errorCategory, $targetObject
					$errorRecord.ErrorDetails = $errorDetails
				}

				$WebSession = @{
					'URI'        = 'https://CyberArk_URL'
					'Method'     = 'GET'
					'WebSession' = New-Object Microsoft.PowerShell.Commands.WebRequestSession
					'Body'       = 'something'
				}

			}

			It 'catches Uri Format Exceptions' {

				{ Invoke-PASRestMethod -Method GET -URI '/s/r/f/c' } | Should -Throw -ExpectedMessage 'Invalid URI: The hostname could not be parsed. Run New-PASSession'
			}

			It 'reports generic Http Request Exceptions' {

				$Credentials = New-Object System.Management.Automation.PSCredential ('SomeUser', $(ConvertTo-SecureString 'SomePassword' -AsPlainText -Force))
				{ New-PASSession -Credential $Credentials -BaseURI 'https://dead.server.no-site.io' } | Should -Throw

			}

			It 'reports expected error message' {
				If ($IsCoreCLR) {
					Mock Invoke-WebRequest { Throw $errorRecord }

					{ Invoke-PASRestMethod @WebSession } | Should -Throw
				} Else { Set-ItResult -Inconclusive }

			}

			It 'reports http errors not returned as json' {
				If ($IsCoreCLR) {
					$errorDetails = '"ErrorCode" [=] "URA999"[;] "ErrorMessage" [=] "Some Error Message"'
					$errorRecord = New-Object Management.Automation.ErrorRecord $exception, $errorID, $errorCategory, $targetObject
					$errorRecord.ErrorDetails = $errorDetails
					Mock Invoke-WebRequest { Throw $errorRecord }
					{ Invoke-PASRestMethod @WebSession } | Should -Throw
				} Else { Set-ItResult -Inconclusive }
			}

			It 'reports inner error messages' {
				If ($IsCoreCLR) {
					$Details = [pscustomobject]@{'ErrorCode' = 'URA666'; 'ErrorMessage' = 'Some Inner Error' }
					$errorDetails = $([pscustomobject]@{'ErrorCode' = 'URA999'; 'ErrorMessage' = 'Some Error Message' ; 'Details' = $Details } | ConvertTo-Json)
					$errorRecord = New-Object Management.Automation.ErrorRecord $exception, $errorID, $errorCategory, $targetObject
					$errorRecord.ErrorDetails = $errorDetails
					Mock Invoke-WebRequest { Throw $errorRecord }
					{ Invoke-PASRestMethod @WebSession } | Should -Throw
				} Else { Set-ItResult -Inconclusive }
			}

			It 'catches other errors' {
				If ($IsCoreCLR) {
					$errorDetails = $null
					$errorRecord = New-Object Management.Automation.ErrorRecord $exception, $errorID, $errorCategory, $targetObject
					$errorRecord.ErrorDetails = $errorDetails
					Mock Invoke-WebRequest { Throw $errorRecord }

					{ Invoke-PASRestMethod @WebSession } | Should -Throw
				} Else { Set-ItResult -Inconclusive }

			}

			It 'reports privilege cloud errors with error + error_description properties' {
				If ($IsCoreCLR) {
					$targetObject = [pscustomobject]@{'RequestUri' = [pscustomobject]@{'Host' = 'https://subdomain.id.cyberark.cloud' } }
					$errorDetails = $([pscustomobject]@{'error' = 'access_denied'; 'error_description' = 'invalid client creds or client not allowed' } | ConvertTo-Json)
					$errorRecord = New-Object Management.Automation.ErrorRecord $exception, $errorID, $errorCategory, $targetObject
					$errorRecord.ErrorDetails = $errorDetails
					Mock Invoke-WebRequest { Throw $errorRecord }
					{ Invoke-PASRestMethod @WebSession } | Should -Throw 'invalid client creds or client not allowed'
				} Else { Set-ItResult -Inconclusive }
			}

			It 'reports privilege cloud errors with ErrorMessage + ErrorCode properties' {
				If ($IsCoreCLR) {
					$targetObject = [pscustomobject]@{'RequestUri' = [pscustomobject]@{'Host' = 'https://subdomain.id.cyberark.cloud' } }
					$errorDetails = $([pscustomobject]@{'ErrorCode' = 'access_denied'; 'ErrorMessage' = 'invalid client creds or client not allowed' } | ConvertTo-Json)
					$errorRecord = New-Object Management.Automation.ErrorRecord $exception, $errorID, $errorCategory, $targetObject
					$errorRecord.ErrorDetails = $errorDetails
					Mock Invoke-WebRequest { Throw $errorRecord }
					{ Invoke-PASRestMethod @WebSession } | Should -Throw 'invalid client creds or client not allowed'
				} Else { Set-ItResult -Inconclusive }
			}

			It 'reports privilege cloud errors  not returned as json' {
				If ($IsCoreCLR) {
					$errorDetails = 'Some Error Message'
					$errorRecord = New-Object Management.Automation.ErrorRecord $exception, $errorID, $errorCategory, $targetObject
					$errorRecord.ErrorDetails = $errorDetails
					Mock Invoke-WebRequest { Throw $errorRecord }
					{ Invoke-PASRestMethod @WebSession } | Should -Throw 'Some Error Message'
				} Else { Set-ItResult -Inconclusive }
			}

		}

	}

}