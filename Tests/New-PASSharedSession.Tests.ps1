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

			$Parameters = @{Parameter = 'BaseURI' }

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command New-PASSharedSession).Parameters["$Parameter"].Attributes.Mandatory | Should Be $true

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
				New-PASSharedSession -BaseURI "https://P_URI" -PVWAAppName "SomeApp"
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {
				New-PASSharedSession -BaseURI "https://P_URI" -PVWAAppName "SomeApp"
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "https://P_URI/SomeApp/WebServices/auth/Shared/RestfulAuthenticationService.svc/Logon"

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {
				New-PASSharedSession -BaseURI "https://P_URI" -PVWAAppName "SomeApp"
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It "sends request with expected body" {
				New-PASSharedSession -BaseURI "https://P_URI" -PVWAAppName "SomeApp"
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It "has a request body with expected number of properties" {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should Be 0

			}

			It "calls Get-PASServer" {

				New-PASSharedSession -BaseURI "https://P_URI" -PVWAAppName "SomeApp"
				Assert-MockCalled Get-PASServer -Times 1 -Exactly -Scope It

			}

			It "skips version check" {

				New-PASSharedSession -BaseURI "https://P_URI" -PVWAAppName "SomeApp" -SkipVersionCheck
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
				New-PASSharedSession -BaseURI "https://P_URI" -PVWAAppName "SomeApp" -WarningAction SilentlyContinue
				$Script:ExternalVersion | Should be "0.0"

			}

			It "throws error if authentication request fails" {

				Mock Invoke-PASRestMethod -MockWith { Write-Error -Message "Some Error" -ErrorId 12345 }
				{ New-PASSharedSession -BaseURI "https://P_URI" -ErrorAction Stop } | Should throw

			}

			It "returns no output if authentication request fails" {

				Mock Invoke-PASRestMethod -MockWith { Write-Error -Message "Some Error" -ErrorId 12345 }
				New-PASSharedSession -BaseURI "https://P_URI" -ErrorAction SilentlyContinue | Should BeNullOrEmpty

			}

		}

	}

}