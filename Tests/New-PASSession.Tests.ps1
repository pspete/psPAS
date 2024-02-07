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
		$Script:psPASSession.BaseURI = 'https://SomeURL/SomeApp'
		$psPASSession.ExternalVersion = '0.0'

	}

	InModuleScope $(Split-Path (Split-Path (Split-Path -Parent $PSCommandPath) -Parent) -Leaf ) {

		Context 'Mandatory Parameters' {

			$Parameters = @{Parameter = 'BaseURI' }

			It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command New-PASSession).Parameters["$Parameter"].Attributes.Mandatory | Select-Object -Unique | Should -Be $true

			}

		}

		Context 'Input' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{
						'CyberArkLogonResult' = 'AAAAAAA\\\REEEAAAAALLLLYYYYY\\\\LOOOOONNNNGGGGG\\\ACCCCCEEEEEEEESSSSSSS\\\\\\TTTTTOOOOOKKKKKEEEEEN'
					}
				}

				Mock Get-PASServer -MockWith {
					[PSCustomObject]@{
						ExternalVersion = '6.6.6'
					}
				}

				Mock Get-PASLoggedOnUser -MockWith {
					@{'UserName' = 'SomeUser' }
				}

				Mock Set-Variable -MockWith { }

				$Credentials = New-Object System.Management.Automation.PSCredential ('SomeUser', $(ConvertTo-SecureString 'SomePassword' -AsPlainText -Force))

				$NewPass = ConvertTo-SecureString 'SomeNewPassword' -AsPlainText -Force

				$psPASSession.ExternalVersion = '0.0'
				$psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

			}

			It 'sends request' {
				$Credentials | New-PASSession -BaseURI 'https://P_URI' -PVWAAppName 'SomeApp' -newPassword $NewPass -UseClassicAPI
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {
				$Credentials | New-PASSession -BaseURI 'https://P_URI' -PVWAAppName 'SomeApp' -newPassword $NewPass -UseClassicAPI
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq 'https://P_URI/SomeApp/WebServices/auth/Cyberark/CyberArkAuthenticationService.svc/Logon'

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {
				$Credentials | New-PASSession -BaseURI 'https://P_URI' -PVWAAppName 'SomeApp' -newPassword $NewPass -UseClassicAPI
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected body' {
				$Credentials | New-PASSession -BaseURI 'https://P_URI' -PVWAAppName 'SomeApp' -newPassword $NewPass -UseClassicAPI
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It 'has a request body with expected number of properties' {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should -Be 3

			}

			It 'sends expected username in request' {

				$Script:RequestBody.username | Should -Be SomeUser

			}

			It 'sends expected password in request' {

				$Script:RequestBody.password | Should -Be SomePassword

			}

			It 'sends expected new password in request' {

				$Script:RequestBody.newpassword | Should -Be SomeNewPassword

			}

			It 'sends request with password value when OTP is used via classic API' {
				$Credentials | New-PASSession -BaseURI 'https://P_URI' -UseClassicAPI -useRadiusAuthentication $true -OTP 987654 -OTPMode Append
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					$Script:RequestBody.password -eq 'SomePassword,987654'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request with password value when OTP is used via V10 API' {
				$Credentials | New-PASSession -BaseURI 'https://P_URI' -type RADIUS -OTP 987654 -OTPMode Append
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					$Script:RequestBody.password -eq 'SomePassword,987654'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request with password value when RadiusChallenge is Password' {
				$Credentials | New-PASSession -BaseURI 'https://P_URI' -type RADIUS -OTP 987654 -OTPMode Challenge -RadiusChallenge Password
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					$Script:RequestBody.password -eq '987654'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request with password value when OTPDelimiter is specified' {
				$Credentials | New-PASSession -BaseURI 'https://P_URI' -type RADIUS -OTP 987654 -OTPMode Append -OTPDelimiter '#'
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					$Script:RequestBody.password -eq 'SomePassword#987654'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request with password value when null OTPDelimiter is specified' {
				$Credentials | New-PASSession -BaseURI 'https://P_URI' -type RADIUS -OTP 987654 -OTPMode Append -OTPDelimiter $null
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					$Script:RequestBody.password -eq 'SomePassword987654'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request with password value when empty OTPDelimiter is specified' {
				$Credentials | New-PASSession -BaseURI 'https://P_URI' -type RADIUS -OTP 987654 -OTPMode Append -OTPDelimiter ''
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					$Script:RequestBody.password -eq 'SomePassword987654'

				} -Times 1 -Exactly -Scope It

			}


			It 'sends request with concurrentSession value when specified' {


				New-PASSession -BaseURI 'https://P_URI' -type LDAP -Credential $Credentials -concurrentSession $true
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					$Script:RequestBody.concurrentSession -eq $true

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected v10 URL for CyberArk Authentication' {

				$RandomString = 'ZDE0YTY3MzYtNTk5Ni00YjFiLWFhMWUtYjVjMGFhNjM5MmJiOzY0MjY0NkYyRkE1NjY3N0M7MDAwMDAwMDI4ODY3MDkxRDUzMjE3NjcxM0ZBODM2REZGQTA2MTQ5NkFCRTdEQTAzNzQ1Q0JDNkRBQ0Q0NkRBMzRCODcwNjA0MDAwMDAwMDA7'


				Mock Invoke-PASRestMethod -MockWith {

					$RandomString

				}

				$Credentials | New-PASSession -BaseURI 'https://P_URI' -type CyberArk
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq 'https://P_URI/PasswordVault/api/AUTH/CyberArk/Logon'

				} -Times 1 -Exactly -Scope It

			}

			It 'sets expected authorization header' {

				$RandomString = 'ZDE0YTY3MzYtNTk5Ni00YjFiLWFhMWUtYjVjMGFhNjM5MmJiOzY0MjY0NkYyRkE1NjY3N0M7MDAwMDAwMDI4ODY3MDkxRDUzMjE3NjcxM0ZBODM2REZGQTA2MTQ5NkFCRTdEQTAzNzQ1Q0JDNkRBQ0Q0NkRBMzRCODcwNjA0MDAwMDAwMDA7'


				Mock Invoke-PASRestMethod -MockWith {

					$RandomString

				}

				$Credentials | New-PASSession -BaseURI 'https://P_URI'
				$psPASSession.WebSession.Headers['Authorization'] | Should -Be $RandomString

			}

			It 'sends request to v10 URL for CyberArk Authentication by default' {

				$Credentials | New-PASSession -BaseURI 'https://P_URI'
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq 'https://P_URI/PasswordVault/api/AUTH/CyberArk/Logon'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected URL if trailing slash is included by user' {

				$Credentials | New-PASSession -BaseURI 'https://P_URI/'
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq 'https://P_URI/PasswordVault/api/AUTH/CyberArk/Logon'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected URL if PasswordVault is included by user' {

				$Credentials | New-PASSession -BaseURI 'https://P_URI/PasswordVault'
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq 'https://P_URI/PasswordVault/api/AUTH/CyberArk/Logon'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected URL if PasswordVault and trailing slash are included by user' {

				$Credentials | New-PASSession -BaseURI 'https://P_URI/PasswordVault/'
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq 'https://P_URI/PasswordVault/api/AUTH/CyberArk/Logon'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected v10 URL for LDAP Authentication' {

				$Credentials | New-PASSession -BaseURI 'https://P_URI' -type LDAP
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq 'https://P_URI/PasswordVault/api/AUTH/LDAP/Logon'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected v10 URL for RADIUS Authentication' {

				$Credentials | New-PASSession -BaseURI 'https://P_URI' -type RADIUS
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq 'https://P_URI/PasswordVault/api/AUTH/RADIUS/Logon'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected v10 URL for WINDOWS Authentication' {

				$Credentials | New-PASSession -BaseURI 'https://P_URI' -type Windows
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq 'https://P_URI/PasswordVault/api/Auth/Windows/Logon'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected v10 URL for WINDOWS Integrated Authentication' {

				New-PASSession -BaseURI 'https://P_URI' -UseDefaultCredentials
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq 'https://P_URI/PasswordVault/api/Auth/Windows/Logon'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected URL for SAML Authentication' {

				New-PASSession -BaseURI 'https://P_URI' -SAMLResponse 'SomeSAMLToken' -UseGen1API

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq 'https://P_URI/PasswordVault/WebServices/auth/SAML/SAMLAuthenticationService.svc/Logon'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends expected header for SAML Authentication' {

				New-PASSession -BaseURI 'https://P_URI' -SAMLResponse 'SomeSAMLToken' -UseGen1API

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Headers['Authorization'] -eq 'SomeSAMLToken'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected URL for Shared Authentication' {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{
						'LogonResult' = 'AAAAAAA\\\REEEAAAAALLLLYYYYY\\\\LOOOOONNNNGGGGG\\\ACCCCCEEEEEEEESSSSSSS\\\\\\TTTTTOOOOOKKKKKEEEEEN'
					}
				}

				New-PASSession -BaseURI 'https://P_URI' -UseSharedAuthentication

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq 'https://P_URI/PasswordVault/WebServices/auth/Shared/RestfulAuthenticationService.svc/Logon'

				} -Times 1 -Exactly -Scope It

			}

			It 'sets expected shared authentication authorization header' {

				$RandomString = 'ZDE0YTY3MzYtNTk5Ni00YjFiLWFhMWUtYjVjMGFhNjM5MmJiOzY0MjY0NkYyRkE1NjY3N0M7MDAwMDAwMDI4ODY3MDkxRDUzMjE3NjcxM0ZBODM2REZGQTA2MTQ5NkFCRTdEQTAzNzQ1Q0JDNkRBQ0Q0NkRBMzRCODcwNjA0MDAwMDAwMDA7'


				Mock Invoke-PASRestMethod -MockWith {

					$RandomString

				}

				New-PASSession -BaseURI 'https://P_URI' -UseSharedAuthentication
				$psPASSession.WebSession.Headers['Authorization'] | Should -Be $RandomString

			}

			It 'includes expected certificate thumbprint in request' {

				New-PASSession -BaseURI 'https://P_URI' -UseSharedAuthentication -CertificateThumbprint 'SomeCertificateThumbprint'

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$CertificateThumbprint -eq 'SomeCertificateThumbprint'

				} -Times 1 -Exactly -Scope It

			}

			It 'includes expected certificate in request' {

				$certificate = Get-ChildItem -Path Cert:\CurrentUser\My\ | Select-Object -First 1
				New-PASSession -BaseURI 'https://P_URI' -UseSharedAuthentication -Certificate $certificate

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Certificate -eq $certificate

				} -Times 1 -Exactly -Scope It

			}

			It 'includes expected credential for Windows Auth' {


				New-PASSession -BaseURI 'https://P_URI' -type Windows -Credential $Credentials
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Credential -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It 'ExternalVersion has expected value on Get-PASServer error' {
				Mock Get-PASServer -MockWith {
					throw 'Some Error'
				}

				$Credentials | New-PASSession -BaseURI 'https://P_URI' -PVWAAppName 'SomeApp' -WarningAction SilentlyContinue
				$psPASSession.ExternalVersion | Should -Be '0.0'

			}

			It 'calls Get-PASServer' {

				$Credentials | New-PASSession -BaseURI 'https://P_URI' -type LDAP
				Assert-MockCalled Get-PASServer -Times 1 -Exactly -Scope It

			}

			It 'skips version check' {

				$Credentials | New-PASSession -BaseURI 'https://P_URI' -type LDAP -SkipVersionCheck
				Assert-MockCalled Get-PASServer -Times 0 -Exactly -Scope It

			}

			It 'sets expected authorization header' {

				$Credentials | New-PASSession -BaseURI 'https://P_URI'
				$psPASSession.WebSession.Headers['Authorization'] | Should -Be 'AAAAAAA\\\REEEAAAAALLLLYYYYY\\\\LOOOOONNNNGGGGG\\\ACCCCCEEEEEEEESSSSSSS\\\\\\TTTTTOOOOOKKKKKEEEEEN'

			}

		}

		Context 'Radius Challenge' {

			BeforeEach {

				if ($IsCoreCLR) {
					$errorDetails = $([pscustomobject]@{'ErrorCode' = 'ITATS542I'; 'ErrorMessage' = 'Some Radius Message' } | ConvertTo-Json)
					$statusCode = 500
					$response = New-Object System.Net.Http.HttpResponseMessage $statusCode
					$exception = New-Object Microsoft.PowerShell.Commands.HttpResponseException "$statusCode ($($response.ReasonPhrase))", $response
					$errorCategory = [System.Management.Automation.ErrorCategory]::InvalidOperation
					$errorID = 'ITATS542I'
					$targetObject = $null
					$errorRecord = New-Object Management.Automation.ErrorRecord $exception, $errorID, $errorCategory, $targetObject
					$errorRecord.ErrorDetails = $errorDetails
				}
				Mock -CommandName Invoke-WebRequest -ParameterFilter { $SessionVariable -eq 'PASSession' } -MockWith { Throw $errorRecord }
				Mock -CommandName Invoke-WebRequest -ParameterFilter { $WebSession -eq $psPASSession.WebSession } -MockWith { [PSCustomObject]@{'CyberArkLogonResult' = 'AAAAAAA\\\REEEAAAAALLLLYYYYY\\\\LOOOOONNNNGGGGG\\\ACCCCCEEEEEEEESSSSSSS\\\\\\TTTTTOOOOOKKKKKEEEEEN' } }

				Mock Read-Host -MockWith {
					return '123456'
				}
				Mock Get-Variable -MockWith { }
				Mock Get-PASServer -MockWith {
					[PSCustomObject]@{
						ExternalVersion = '6.6.6'
					}
				}

				Mock Get-PASLoggedOnUser -MockWith {
					@{'UserName' = 'SomeUser' }
				}

				$Credentials = New-Object System.Management.Automation.PSCredential ('SomeUser', $(ConvertTo-SecureString 'SomePassword' -AsPlainText -Force))

				$psPASSession.ExternalVersion = '0.0'
				$psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

			}

			It 'sends expected number of requests when exception ITATS542I is raised' {
				if ($IsCoreCLR) {
					$Credentials | New-PASSession -BaseURI 'https://P_URI' -type RADIUS -OTP 123456 -OTPMode Challenge
					Assert-MockCalled Invoke-WebRequest -Times 2 -Exactly -Scope It
				} Else { Set-ItResult -Inconclusive }
			}

			It 'sends expected OTP value for Radius Challenge' {
				if ($IsCoreCLR) {
					$Credentials | New-PASSession -BaseURI 'https://P_URI' -type RADIUS -OTP 987654 -OTPMode Challenge

					Assert-MockCalled Invoke-WebRequest -ParameterFilter {

						$Script:RequestBody = $Body | ConvertFrom-Json

						$Script:RequestBody.password -eq 'SomePassword'

					} -Times 1 -Exactly -Scope It

					Assert-MockCalled Invoke-WebRequest -ParameterFilter {

						$Script:RequestBody = $Body | ConvertFrom-Json

						$Script:RequestBody.password -eq '987654'

					} -Times 1 -Exactly -Scope It
				} Else { Set-ItResult -Inconclusive }
			}

			It 'sends expected password value as radius challenge' {
				if ($IsCoreCLR) {
					$Credentials | New-PASSession -BaseURI 'https://P_URI' -type RADIUS -OTP 987654 -OTPMode Challenge -RadiusChallenge Password

					Assert-MockCalled Invoke-WebRequest -ParameterFilter {

						$Script:RequestBody = $Body | ConvertFrom-Json

						$Script:RequestBody.password -eq '987654'

					} -Times 1 -Exactly -Scope It

					Assert-MockCalled Invoke-WebRequest -ParameterFilter {

						$Script:RequestBody = $Body | ConvertFrom-Json

						$Script:RequestBody.password -eq 'SomePassword'

					} -Times 1 -Exactly -Scope It
				} Else { Set-ItResult -Inconclusive }
			}

			It 'prompts for OTP value' {
				if ($IsCoreCLR) {
					$Credentials | New-PASSession -BaseURI 'https://P_URI' -type RADIUS -OTPMode Challenge
					Assert-MockCalled Read-Host -Times 1 -Exactly -Scope It
				} Else { Set-ItResult -Inconclusive }
			}

			It 'relay RADIUS response as prompt' {
				if ($IsCoreCLR) {

					$Credentials | New-PASSession -BaseURI 'https://P_URI' -type RADIUS -OTPMode Challenge
					Assert-MockCalled Read-Host -ParameterFilter {

						$Prompt -eq '[500] Some Radius Message'

					} -Times 1 -Exactly -Scope It
				} Else { Set-ItResult -Inconclusive }
			}

			It 'throws if error code does not indicate Radius Challenge' {
				if ($IsCoreCLR) {
					$errorDetails = $([pscustomobject]@{'ErrorCode' = 'ITATS123I'; 'ErrorMessage' = 'Some Message' } | ConvertTo-Json)
					$statusCode = 500
					$response = New-Object System.Net.Http.HttpResponseMessage $statusCode
					$exception = New-Object Microsoft.PowerShell.Commands.HttpResponseException "$statusCode ($($response.ReasonPhrase))", $response
					$errorCategory = [System.Management.Automation.ErrorCategory]::InvalidOperation
					$errorID = 'WebCmdletWebResponseException,Microsoft.PowerShell.Commands.InvokeWebRequestCommand'
					$targetObject = $null
					$errorRecord = New-Object Management.Automation.ErrorRecord $exception, $errorID, $errorCategory, $targetObject
					$errorRecord.ErrorDetails = $errorDetails

					Mock -CommandName Invoke-WebRequest -ParameterFilter { $SessionVariable -eq 'PASSession' } -MockWith { Throw $errorRecord }

					{ $Credentials | New-PASSession -BaseURI 'https://P_URI' -type RADIUS -OTPMode Append -OTP 123456 } | Should -Throw
				} Else { Set-ItResult -Inconclusive }
			}

			It "prompts for OTP if parameter value for $OTP is 'passcode'" {
				if ($IsCoreCLR) {
					$Credentials | New-PASSession -BaseURI 'https://P_URI' -type RADIUS -OTP passcode -OTPMode Challenge
					Assert-MockCalled Read-Host -Times 1 -Exactly -Scope It
				} Else { Set-ItResult -Inconclusive }
			}

			It 'prompts for response to multiple challenge levels' {

				$Script:counter = 0
				if ($IsCoreCLR) {
					Mock -CommandName Invoke-PASRestMethod {
						If ($Script:counter -lt 4) {
							$Script:counter++
							Throw $errorRecord
						} ElseIf ($Script:counter -ge 5) {

							Return [PSCustomObject]@{'CyberArkLogonResult' = 'AAAAAAA\\\REEEAAAAALLLLYYYYY\\\\LOOOOONNNNGGGGG\\\ACCCCCEEEEEEEESSSSSSS\\\\\\TTTTTOOOOOKKKKKEEEEEN' }

						}

					} -ParameterFilter { $Uri -eq 'https://P_URI/PasswordVault/api/Auth/RADIUS/Logon' }

					$Credentials | New-PASSession -BaseURI 'https://P_URI' -type RADIUS

					Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

						$URI -eq 'https://P_URI/PasswordVault/api/Auth/RADIUS/Logon'

					} -Times 5 -Exactly -Scope It

				} Else { Set-ItResult -Inconclusive }

			}

		}

		Context 'Windows + Radius' {

			BeforeEach {

				Mock Get-PASLoggedOnUser -MockWith {
					@{'UserName' = 'SomeUser' }
				}

				if ($IsCoreCLR) {
					$errorDetails1 = $([pscustomobject]@{'ErrorCode' = 'ITATS542I'; 'ErrorMessage' = 'Some Radius Message' } | ConvertTo-Json)
					$errorDetails2 = $([pscustomobject]@{'ErrorCode' = 'ITATS555E'; 'ErrorMessage' = 'Some Error Message' } | ConvertTo-Json)
					$statusCode = 500
					$response = New-Object System.Net.Http.HttpResponseMessage $statusCode
					$exception = New-Object Microsoft.PowerShell.Commands.HttpResponseException "$statusCode ($($response.ReasonPhrase))", $response
					$errorCategory = [System.Management.Automation.ErrorCategory]::InvalidOperation
					$errorID1 = 'ITATS542I'
					$errorID2 = 'ITATS555E'
					$targetObject = $null
					$errorRecord1 = New-Object Management.Automation.ErrorRecord $exception, $errorID1, $errorCategory, $targetObject
					$errorRecord2 = New-Object Management.Automation.ErrorRecord $exception, $errorID2, $errorCategory, $targetObject
					$errorRecord1.ErrorDetails = $errorDetails1
					$errorRecord2.ErrorDetails = $errorDetails2
				}
				$Script:counter = 0

				$RandomString = 'ZDE0YTY3MzYtNTk5Ni00YjFiLWFhMWUtYjVjMGFhNjM5MmJiOzY0MjY0NkYyRkE1NjY3N0M7MDAwMDAwMDI4ODY3MDkxRDUzMjE3NjcxM0ZBODM2REZGQTA2MTQ5NkFCRTdEQTAzNzQ1Q0JDNkRBQ0Q0NkRBMzRCODcwNjA0MDAwMDAwMDA7'

				Mock -CommandName Invoke-PASRestMethod {
					If ($Script:counter -eq 0) {
						$Script:counter++
						Throw $errorRecord1
					} ElseIf ($Script:counter -ge 1) {

						return $RandomString

					}

				} -ParameterFilter { $Uri -eq 'https://P_URI/PasswordVault/api/Auth/RADIUS/Logon' }

				Mock -CommandName Invoke-PASRestMethod { return @{UserName = 'AUserName' } } -ParameterFilter { $Uri -eq 'https://P_URI/PasswordVault/api/Auth/Windows/Logon' }

				Mock Set-Variable -MockWith { }
				Mock Get-Variable -MockWith { }
				Mock Get-PASServer -MockWith {
					[PSCustomObject]@{
						ExternalVersion = '6.6.6'
					}
				}

				$Credentials = New-Object System.Management.Automation.PSCredential ('SomeUser', $(ConvertTo-SecureString 'SomePassword' -AsPlainText -Force))

				$psPASSession.ExternalVersion = '0.0'
				$psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

			}

			It 'throws if no session token is returned after successful IIS authentication' {
				if ($IsCoreCLR) {
					{ $Credentials | New-PASSession -BaseURI 'https://P_URI' -type Windows } | Should -Throw
				} Else { Set-ItResult -Inconclusive }
			}

			It 'sends expected number of requests for Windows Auth + RADIUS' {
				if ($IsCoreCLR) {
					$Credentials | New-PASSession -BaseURI 'https://P_URI' -type Windows -OTP 123456 -OTPMode Challenge

					Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

						$URI -eq 'https://P_URI/PasswordVault/api/Auth/Windows/Logon'

					} -Times 1 -Exactly -Scope It

					Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

						$URI -eq 'https://P_URI/PasswordVault/api/Auth/RADIUS/Logon'

					} -Times 2 -Exactly -Scope It
				} Else { Set-ItResult -Inconclusive }
			}

			It 'throws if RADIUS challenge fails' {
				if ($IsCoreCLR) {
					Mock -CommandName Invoke-PASRestMethod {
						If ($Script:counter -eq 0) {
							$Script:counter++
							Throw $errorRecord1
						} ElseIf ($Script:counter -ge 1) {

							Throw $errorRecord2

						}

					} -ParameterFilter { $Uri -eq 'https://P_URI/PasswordVault/api/Auth/RADIUS/Logon' }

					{ $Credentials | New-PASSession -BaseURI 'https://P_URI' -type Windows -OTP 123456 -OTPMode Challenge } | Should -Throw

					Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

						$URI -eq 'https://P_URI/PasswordVault/api/Auth/Windows/Logon'

					} -Times 1 -Exactly -Scope It

					Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

						$URI -eq 'https://P_URI/PasswordVault/api/Auth/RADIUS/Logon'

					} -Times 2 -Exactly -Scope It

				} Else { Set-ItResult -Inconclusive }

			}

		}

		Context 'SAML' {

			BeforeEach {

				Mock Get-PASLoggedOnUser -MockWith {
					@{'UserName' = 'SomeUser' }
				}

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{
						'CyberArkLogonResult' = 'AAAAAAA\\\REEEAAAAALLLLYYYYY\\\\LOOOOONNNNGGGGG\\\ACCCCCEEEEEEEESSSSSSS\\\\\\TTTTTOOOOOKKKKKEEEEEN'
					}
				}

				Mock Get-PASServer -MockWith {
					[PSCustomObject]@{
						ExternalVersion = '6.6.6'
					}
				}

				Mock Set-Variable -MockWith { }

				$psPASSession.ExternalVersion = '0.0'
				$psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

				Mock Get-PASSAMLResponse -MockWith {

					'ThisIsTheSAMLResponse'

				}

			}

			It 'sends request' {
				New-PASSession -BaseURI 'https://P_URI' -SAMLAuth
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'gets IdP SAML response' {

				New-PASSession -BaseURI 'https://P_URI' -SAMLAuth
				Assert-MockCalled Get-PASSAMLResponse -Times 1 -Exactly -Scope It

			}

			It 'sends expected request to expected endpoint' {

				New-PASSession -BaseURI 'https://P_URI' -SAMLAuth
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq 'https://P_URI/PasswordVault/api/Auth/SAML/Logon'
					$ContentType -eq 'application/x-www-form-urlencoded'
					$Body['SAMLResponse'] -eq 'ThisIsTheSAMLResponse'
					$Body['apiUse'] -eq $true

				} -Times 1 -Exactly -Scope It

			}

			It 'throws if saml response is error' {

				Mock Get-PASSAMLResponse -MockWith {

					Throw 'ThisIsTheSAMLResponse'

				}

				{ New-PASSession -BaseURI 'https://P_URI' -SAMLAuth } | Should -Throw

			}

			It 'sends request when samlresponse provided' {
				New-PASSession -BaseURI 'https://P_URI' -SAMLAuth
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'does not invoke Get-PASSAMLResponse' {

				New-PASSession -BaseURI 'https://P_URI' -SAMLResponse 'SomeSAMLResponse'
				Assert-MockCalled Get-PASSAMLResponse -Times 0 -Exactly -Scope It

			}

			It 'sends expected SAMLResponse to expected endpoint' {

				New-PASSession -BaseURI 'https://P_URI' -SAMLResponse 'SomeSAMLResponse'
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq 'https://P_URI/PasswordVault/api/Auth/SAML/Logon'
					$ContentType -eq 'application/x-www-form-urlencoded'
					$Body['SAMLResponse'] -eq 'SomeSAMLResponse'
					$Body['apiUse'] -eq $true

				} -Times 1 -Exactly -Scope It

			}

			It 'sets expected authorization header' {

				New-PASSession -BaseURI 'https://P_URI' -SAMLResponse 'SomeSAMLResponse'
				$psPASSession.WebSession.Headers['Authorization'] | Should -Be 'AAAAAAA\\\REEEAAAAALLLLYYYYY\\\\LOOOOONNNNGGGGG\\\ACCCCCEEEEEEEESSSSSSS\\\\\\TTTTTOOOOOKKKKKEEEEEN'

			}

		}

		Context 'SharedServices-URL-ServiceUser' {

			BeforeEach {

				Mock Get-PASLoggedOnUser -MockWith {
					@{'UserName' = 'SomeUser' }
				}

				function New-IDPlatformToken {
					[CmdletBinding()]
					param($tenant_url,
						$Credential)
				}
				$mockResult = New-Object -TypeName Microsoft.PowerShell.Commands.WebRequestSession


				$mockGetWebSessionMethod = {
					# count the invocation and store it on the mock object
					# to avoid using script:scoped variables
					$this.GetWebSessionInvoked++

					# return the result object as the real method would
					$mockResult
				}

				$mockIDSessionObject = [PSCustomObject] @{
					GetWebSessionInvoked = 0
					'access_token'       = 'AAAAAAA\\\REEEAAAAALLLLYYYYY\\\\LOOOOONNNNGGGGG\\\ACCCCCEEEEEEEESSSSSSS\\\\\\TTTTTOOOOOKKKKKEEEEEN'
					'token_type'         = 'Bearer'
				}

				$mockIDSessionObject | Add-Member -MemberType ScriptMethod -Name GetWebSession -Value $mockGetWebSessionMethod
				Mock New-IDPlatformToken { $mockIDSessionObject }

				Mock Get-PASServer -MockWith {
					[PSCustomObject]@{
						ExternalVersion = '0.0'
					}
				}

				Mock Get-Module -MockWith {}

				Mock Import-Module -MockWith {}

				$Credentials = New-Object System.Management.Automation.PSCredential ('SomeUser', $(ConvertTo-SecureString 'SomePassword' -AsPlainText -Force))

				$psPASSession.ExternalVersion = '0.0'
				$psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

			}

			It 'sends request' {
				$Credentials | New-PASSession -IdentityTenantURL 'https://Some.Identity.Portal/' -PrivilegeCloudURL 'https://Some.PCloud.Portal/PasswordVault' -ServiceUser
				Assert-MockCalled New-IDPlatformToken -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected tenant_url' {
				$Credentials | New-PASSession -IdentityTenantURL 'https://Some.Identity.Portal' -PrivilegeCloudURL 'https://Some.PCloud.Portal/' -ServiceUser
				Assert-MockCalled New-IDPlatformToken -ParameterFilter {

					$tenant_url -eq 'https://Some.Identity.Portal'

				} -Times 1 -Exactly -Scope It

			}

			It 'sets expected BaseURI' {

				$Credentials | New-PASSession -IdentityTenantURL 'https://Some.Identity.Portal/' -PrivilegeCloudURL 'https://Some.PCloud.Portal/PasswordVault' -ServiceUser
				$Script:psPASSession.BaseURI | Should -Be 'https://Some.PCloud.Portal/PasswordVault'

			}

			It 'sets expected authorization header' {

				$Credentials | New-PASSession -IdentityTenantURL 'https://Some.Identity.Portal/' -PrivilegeCloudURL 'https://Some.PCloud.Portal/PasswordVault' -ServiceUser
				$psPASSession.WebSession.Headers['Authorization'] | Should -Be 'Bearer AAAAAAA\\\REEEAAAAALLLLYYYYY\\\\LOOOOONNNNGGGGG\\\ACCCCCEEEEEEEESSSSSSS\\\\\\TTTTTOOOOOKKKKKEEEEEN'

			}

		}

		Context 'SharedServices-Subdomain-ServiceUser' {

			BeforeEach {

				Mock Get-PASLoggedOnUser -MockWith {
					@{'UserName' = 'SomeUser' }
				}

				function New-IDPlatformToken {
					[CmdletBinding()]
					param($tenant_url,
						$Credential)
				}
				$mockResult = New-Object -TypeName Microsoft.PowerShell.Commands.WebRequestSession


				$mockGetWebSessionMethod = {
					# count the invocation and store it on the mock object
					# to avoid using script:scoped variables
					$this.GetWebSessionInvoked++

					# return the result object as the real method would
					$mockResult
				}

				$mockIDSessionObject = [PSCustomObject] @{
					GetWebSessionInvoked = 0
					'access_token'       = 'AAAAAAA\\\REEEAAAAALLLLYYYYY\\\\LOOOOONNNNGGGGG\\\ACCCCCEEEEEEEESSSSSSS\\\\\\TTTTTOOOOOKKKKKEEEEEN'
					'token_type'         = 'Bearer'
				}

				$mockIDSessionObject | Add-Member -MemberType ScriptMethod -Name GetWebSession -Value $mockGetWebSessionMethod
				Mock New-IDPlatformToken { $mockIDSessionObject }

				Mock Get-PASServer -MockWith {
					[PSCustomObject]@{
						ExternalVersion = '0.0'
					}
				}

				Mock Find-SharedServicesURL -MockWith {

					[pscustomobject]@{
						identity_user_portal = [pscustomobject]@{api = 'https://SomeSubDomain.id.cyberark.cloud' }
						pcloud               = [pscustomobject]@{api = 'https://SomeSubDomain.privilegecloud.cyberark.cloud' }
					}

				}

				Mock Get-Module -MockWith {}

				Mock Import-Module -MockWith {}

				$Credentials = New-Object System.Management.Automation.PSCredential ('SomeUser', $(ConvertTo-SecureString 'SomePassword' -AsPlainText -Force))

				$psPASSession.ExternalVersion = '0.0'
				$psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

			}

			It 'sends request' {
				$Credentials | New-PASSession -TenantSubdomain SomeSubDomain -ServiceUser
				Assert-MockCalled New-IDPlatformToken -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected tenant_url' {
				$Credentials | New-PASSession -TenantSubdomain SomeSubDomain -ServiceUser
				Assert-MockCalled New-IDPlatformToken -ParameterFilter {

					$tenant_url -eq 'https://SomeSubDomain.id.cyberark.cloud'

				} -Times 1 -Exactly -Scope It

			}

			It 'sets expected BaseURI' {

				$Credentials | New-PASSession -TenantSubdomain SomeSubDomain -ServiceUser
				$Script:psPASSession.BaseURI | Should -Be 'https://SomeSubDomain.privilegecloud.cyberark.cloud/PasswordVault'

			}

			It 'sets expected BaseURI when identity subdomain specified' {

				$Credentials | New-PASSession -TenantSubdomain SomeSubDomain -ServiceUser
				$Script:psPASSession.BaseURI | Should -Be 'https://SomeSubDomain.privilegecloud.cyberark.cloud/PasswordVault'

			}

			It 'sets expected authorization header' {

				$Credentials | New-PASSession -TenantSubdomain SomeSubDomain -ServiceUser
				$psPASSession.WebSession.Headers['Authorization'] | Should -Be 'Bearer AAAAAAA\\\REEEAAAAALLLLYYYYY\\\\LOOOOONNNNGGGGG\\\ACCCCCEEEEEEEESSSSSSS\\\\\\TTTTTOOOOOKKKKKEEEEEN'

			}

		}

		Context 'SharedServices-URL-IdentityUser' {

			BeforeEach {

				Mock Get-PASLoggedOnUser -MockWith {
					@{'UserName' = 'SomeUser' }
				}

				function New-IDSession {
					[CmdletBinding()]
					param($tenant_url,
						$Credential)
				}
				$mockResult = New-Object -TypeName Microsoft.PowerShell.Commands.WebRequestSession

				$mockGetWebSessionMethod = {
					# count the invocation and store it on the mock object
					# to avoid using script:scoped variables
					$this.GetWebSessionInvoked++

					# return the result object as the real method would
					$mockResult
				}

				$mockIDSessionObject = [PSCustomObject] @{
					GetWebSessionInvoked = 0
					'Token'              = 'AAAAAAA\\\REEEAAAAALLLLYYYYY\\\\LOOOOONNNNGGGGG\\\ACCCCCEEEEEEEESSSSSSS\\\\\\TTTTTOOOOOKKKKKEEEEEN'
				}

				$mockIDSessionObject | Add-Member -MemberType ScriptMethod -Name GetWebSession -Value $mockGetWebSessionMethod
				Mock New-IDSession { $mockIDSessionObject }

				Mock Get-PASServer -MockWith {
					[PSCustomObject]@{
						ExternalVersion = '0.0'
					}
				}

				Mock Get-Module -MockWith {}

				Mock Import-Module -MockWith {}

				$Credentials = New-Object System.Management.Automation.PSCredential ('SomeUser', $(ConvertTo-SecureString 'SomePassword' -AsPlainText -Force))

				$psPASSession.ExternalVersion = '0.0'
				$psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

			}

			It 'sends request' {

				$Credentials | New-PASSession -IdentityTenantURL 'https://SomeIdentityPortal.id.cyberark.cloud/' -PrivilegeCloudURL 'https://Some.PCloud.Portal/PasswordVault' -IdentityUser
				Assert-MockCalled New-IDSession -Times 1 -Exactly -Scope It -ModuleName psPAS

			}

			It 'sends request to expected tenant_url' {
				$Credentials | New-PASSession -IdentityTenantURL 'https://SomeIdentityPortal.id.cyberark.cloud' -PrivilegeCloudURL 'https://Some.PCloud.Portal/' -IdentityUser
				Assert-MockCalled New-IDSession -ParameterFilter {

					$tenant_url -eq 'https://SomeIdentityPortal.id.cyberark.cloud'

				} -Times 1 -Exactly -Scope It

			}

			It 'sets expected default BaseURI' {

				$Credentials | New-PASSession -IdentityTenantURL 'https://SomeIdentityPortal.id.cyberark.cloud/' -PrivilegeCloudURL 'https://SomeIdentityPortal.privilegecloud.cyberark.cloud/' -IdentityUser
				$Script:psPASSession.BaseURI | Should -Be 'https://SomeIdentityPortal.privilegecloud.cyberark.cloud/PasswordVault'

			}

			It 'sets expected custom BaseURI' {

				$Credentials | New-PASSession -IdentityTenantURL 'https://SomeIdentityPortal.id.cyberark.cloud/' -PrivilegeCloudURL 'https://Some.PCloud.Portal/' -IdentityUser
				$Script:psPASSession.BaseURI | Should -Be 'https://Some.PCloud.Portal/PasswordVault'

			}

			It 'sets expected authorization header' {

				$Credentials | New-PASSession -IdentityTenantURL 'https://SomeIdentityPortal.id.cyberark.cloud/' -PrivilegeCloudURL 'https://Some.PCloud.Portal/' -IdentityUser
				$psPASSession.WebSession.Headers['Authorization'] | Should -Be 'Bearer AAAAAAA\\\REEEAAAAALLLLYYYYY\\\\LOOOOONNNNGGGGG\\\ACCCCCEEEEEEEESSSSSSS\\\\\\TTTTTOOOOOKKKKKEEEEEN'

			}

		}

		Context 'SharedServices-Subdomain-IdentityUser' {

			BeforeEach {

				Mock Get-PASLoggedOnUser -MockWith {
					@{'UserName' = 'SomeUser' }
				}

				function New-IDSession {
					[CmdletBinding()]
					param($tenant_url,
						$Credential)
				}
				$mockResult = New-Object -TypeName Microsoft.PowerShell.Commands.WebRequestSession


				$mockGetWebSessionMethod = {
					# count the invocation and store it on the mock object
					# to avoid using script:scoped variables
					$this.GetWebSessionInvoked++

					# return the result object as the real method would
					$mockResult
				}

				$mockIDSessionObject = [PSCustomObject] @{
					GetWebSessionInvoked = 0
					'Token'              = 'AAAAAAA\\\REEEAAAAALLLLYYYYY\\\\LOOOOONNNNGGGGG\\\ACCCCCEEEEEEEESSSSSSS\\\\\\TTTTTOOOOOKKKKKEEEEEN'
				}

				$mockIDSessionObject | Add-Member -MemberType ScriptMethod -Name GetWebSession -Value $mockGetWebSessionMethod
				Mock New-IDSession { $mockIDSessionObject }

				Mock Get-PASServer -MockWith {
					[PSCustomObject]@{
						ExternalVersion = '0.0'
					}
				}

				Mock Get-Module -MockWith {}

				Mock Import-Module -MockWith {}

				Mock Find-SharedServicesURL -MockWith {

					[pscustomobject]@{
						identity_user_portal = [pscustomobject]@{api = 'https://SomeSubDomain.id.cyberark.cloud' }
						pcloud               = [pscustomobject]@{api = 'https://SomeSubDomain.privilegecloud.cyberark.cloud' }
					}

				}

				$Credentials = New-Object System.Management.Automation.PSCredential ('SomeUser', $(ConvertTo-SecureString 'SomePassword' -AsPlainText -Force))

				$psPASSession.ExternalVersion = '0.0'
				$psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

			}

			It 'sends request' {
				$Credentials | New-PASSession -TenantSubdomain SomeSubDomain -IdentityUser
				Assert-MockCalled New-IDSession -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected tenant_url' {
				$Credentials | New-PASSession -TenantSubdomain SomeSubDomain -IdentityUser
				Assert-MockCalled New-IDSession -ParameterFilter {

					$tenant_url -eq 'https://SomeSubDomain.id.cyberark.cloud'

				} -Times 1 -Exactly -Scope It

			}

			It 'sets expected BaseURI' {

				$Credentials | New-PASSession -TenantSubdomain SomeSubDomain -IdentityUser
				$Script:psPASSession.BaseURI | Should -Be 'https://SomeSubDomain.privilegecloud.cyberark.cloud/PasswordVault'

			}

			It 'sets expected authorization header' {

				$Credentials | New-PASSession -TenantSubdomain SomeSubDomain -IdentityUser
				$psPASSession.WebSession.Headers['Authorization'] | Should -Be 'Bearer AAAAAAA\\\REEEAAAAALLLLYYYYY\\\\LOOOOONNNNGGGGG\\\ACCCCCEEEEEEEESSSSSSS\\\\\\TTTTTOOOOOKKKKKEEEEEN'

			}

		}

	}

}
