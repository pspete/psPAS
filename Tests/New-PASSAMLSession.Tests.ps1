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
	#$Script:BaseURI = "https://SomeURL/SomeApp"
	#$Script:ExternalVersion = "0.0"
	#$Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

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

				(Get-Command New-PASSAMLSession).Parameters["$Parameter"].Attributes.Mandatory | Should Be $true

			}

		}

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
				$Credentials | New-PASSAMLSession -BaseURI "https://P_URI" -PVWAAppName "SomeApp"

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {
				$Credentials | New-PASSAMLSession -BaseURI "https://P_URI" -PVWAAppName "SomeApp"

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "https://P_URI/SomeApp/WebServices/auth/SAML/SAMLAuthenticationService.svc/Logon"

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {
				$Credentials | New-PASSAMLSession -BaseURI "https://P_URI" -PVWAAppName "SomeApp"

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It "sends request with expected body" {
				$Credentials | New-PASSAMLSession -BaseURI "https://P_URI" -PVWAAppName "SomeApp"

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It "has a request body with expected number of properties" {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should Be 0

			}

			It "sends request with expected header" {
				$Credentials | New-PASSAMLSession -BaseURI "https://P_URI" -PVWAAppName "SomeApp"

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Headers -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It "sends header with expected key" {
				$Credentials | New-PASSAMLSession -BaseURI "https://P_URI" -PVWAAppName "SomeApp"

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Headers.keys -eq "Authorization"

				} -Times 1 -Exactly -Scope It

			}

			It "sends header with expected value" {
				$Credentials | New-PASSAMLSession -BaseURI "https://P_URI" -PVWAAppName "SomeApp"

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$EncodedValue = $Headers["Authorization"] -replace "Basic ", ""
					[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($EncodedValue)) -eq "SomeUser:SomePassword"

				} -Times 1 -Exactly -Scope It

			}

			It "calls Get-PASServer" {

				$Credentials | New-PASSAMLSession -BaseURI "https://P_URI" -PVWAAppName "SomeApp"
				Assert-MockCalled Get-PASServer -Times 1 -Exactly -Scope It

			}

			It "skips version check" {

				$Credentials | New-PASSAMLSession -BaseURI "https://P_URI" -PVWAAppName "SomeApp" -SkipVersionCheck
				Assert-MockCalled Get-PASServer -Times 0 -Exactly -Scope It

			}

		}

		Context "Output" {

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

			It "`$Script:ExternalVersion has expected value on Get-PASServer error" {
				Mock Get-PASServer -MockWith {
					throw "Some Error"
				}
				$Credentials | New-PASSAMLSession -BaseURI "https://P_URI" -PVWAAppName "SomeApp" -WarningAction SilentlyContinue
				$Script:ExternalVersion | Should be "0.0"

			}

			It "throws error if authentication request fails" {

				Mock Invoke-PASRestMethod -MockWith { Write-Error -Message "Some Error" -ErrorId 12345 }
				{ $Credentials | New-PASSAMLSession -BaseURI "https://P_URI" -ErrorAction Stop } | Should throw

			}

			It "returns no output if authentication request fails" {

				Mock Invoke-PASRestMethod -MockWith { Write-Error -Message "Some Error" -ErrorId 12345 }
				$Credentials | New-PASSAMLSession -BaseURI "https://P_URI" -ErrorAction SilentlyContinue | Should BeNullOrEmpty

			}

		}

	}

}