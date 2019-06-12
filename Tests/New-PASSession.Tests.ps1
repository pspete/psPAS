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

BeforeAll {

	$Script:RequestBody = $null

}

AfterAll {

	$Script:RequestBody = $null

}

Describe $FunctionName {

	InModuleScope $ModuleName {

		Context "Mandatory Parameters" {

			$Parameters = @{Parameter = 'BaseURI' },
			@{Parameter = 'Credential' }

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command New-PASSession).Parameters["$Parameter"].Attributes.Mandatory | Select-Object -Unique | Should Be $true

			}

		}

		$response =

		Context "Input" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{
						"CyberArkLogonResult" = "AAAAAAA\\\REEEAAAAALLLLYYYYY\\\\LOOOOONNNNGGGGG\\\ACCCCCEEEEEEEESSSSSSS\\\\\\TTTTTOOOOOKKKKKEEEEEN"
					}
				}

				Mock Get-PASServer -MockWith {
					[PSCustomObject]@{
						ExternalVersion = "6.6.6"
					}
				}

				Mock Set-Variable -MockWith { }

				$Credentials = New-Object System.Management.Automation.PSCredential ("SomeUser", $(ConvertTo-SecureString "SomePassword" -AsPlainText -Force))

				$NewPass = ConvertTo-SecureString "SomeNewPassword" -AsPlainText -Force

				$Script:ExternalVersion = "0.0"
				$Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

			}

			It "sends request" {
				$Credentials | New-PASSession -BaseURI "https://P_URI" -PVWAAppName "SomeApp" -newPassword $NewPass -UseV9API
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {
				$Credentials | New-PASSession -BaseURI "https://P_URI" -PVWAAppName "SomeApp" -newPassword $NewPass -UseV9API
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "https://P_URI/SomeApp/WebServices/auth/Cyberark/CyberArkAuthenticationService.svc/Logon"

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {
				$Credentials | New-PASSession -BaseURI "https://P_URI" -PVWAAppName "SomeApp" -newPassword $NewPass -UseV9API
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It "sends request with expected body" {
				$Credentials | New-PASSession -BaseURI "https://P_URI" -PVWAAppName "SomeApp" -newPassword $NewPass -UseV9API
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It "has a request body with expected number of properties" {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should Be 3

			}

			It "sends expected username in request" {

				$Script:RequestBody.username | Should Be SomeUser

			}

			It "sends expected password in request" {

				$Script:RequestBody.password | Should Be SomePassword

			}

			It "sends expected new password in request" {

				$Script:RequestBody.newpassword | Should Be SomeNewPassword

			}

			It "sends request to expected v10 URL for CyberArk Authentication" {

				$Credentials | New-PASSession -BaseURI "https://P_URI" -type CyberArk
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "https://P_URI/PasswordVault/api/AUTH/CyberArk/Logon"

				} -Times 1 -Exactly -Scope It

			}

			It "sends request to v10 URL for CyberArk Authentication by default" {

				$Credentials | New-PASSession -BaseURI "https://P_URI"
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "https://P_URI/PasswordVault/api/AUTH/CyberArk/Logon"

				} -Times 1 -Exactly -Scope It

			}

			It "sends request to expected v10 URL for LDAP Authentication" {

				$Credentials | New-PASSession -BaseURI "https://P_URI" -type LDAP
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "https://P_URI/PasswordVault/api/AUTH/LDAP/Logon"

				} -Times 1 -Exactly -Scope It

			}

			It "sends request to expected v10 URL for RADIUS Authentication" {

				$Credentials | New-PASSession -BaseURI "https://P_URI" -type RADIUS
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "https://P_URI/PasswordVault/api/AUTH/RADIUS/Logon"

				} -Times 1 -Exactly -Scope It

			}

			It "sends request to expected v10 URL for WINDOWS Authentication" {

				New-PASSession -BaseURI "https://P_URI" -UseDefaultCredentials
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "https://P_URI/PasswordVault/api/Auth/Windows/Logon"

				} -Times 1 -Exactly -Scope It

			}

			It "`$Script:ExternalVersion has expected value on Get-PASServer error" {
				Mock Get-PASServer -MockWith {
					throw "Some Error"
				}
				$Credentials | New-PASSession -BaseURI "https://P_URI" -PVWAAppName "SomeApp" -WarningAction SilentlyContinue
				$Script:ExternalVersion | Should be "0.0"

			}

			It "calls Get-PASServer" {

				$Credentials | New-PASSession -BaseURI "https://P_URI" -type LDAP
				Assert-MockCalled Get-PASServer -Times 1 -Exactly -Scope It

			}

			It "skips version check" {

				$Credentials | New-PASSession -BaseURI "https://P_URI" -type LDAP -SkipVersionCheck
				Assert-MockCalled Get-PASServer -Times 0 -Exactly -Scope It

			}



		}

		Context "Output" {



		}

	}

}
