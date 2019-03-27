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

if( -not (Get-Module -Name $ModuleName -All)) {

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

			$Parameters = @{Parameter = 'BaseURI'},
			@{Parameter = 'SessionToken'}

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command Get-PASDirectory).Parameters["$Parameter"].Attributes.Mandatory | Should Be $true

			}

		}

		Context "Input" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{"Prop1" = "Val1"; "Prop2" = "Val2"}
				}

				$InputObj = [pscustomobject]@{
					"sessionToken" = @{"Authorization" = "P_AuthValue"}
					"WebSession"   = New-Object Microsoft.PowerShell.Commands.WebRequestSession
					"BaseURI"      = "https://P_URI"
					"PVWAAppName"  = "P_App"

				}

				$response = $InputObj | Get-PASDirectory -id SomeDir

			}

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/api/Configuration/LDAP/Directories/SomeDir/"

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It "sends request with no body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Body -eq $null} -Times 1 -Exactly -Scope It

			}

			It "throws error if version requirement not met" {
				{$InputObj | Get-PASDirectory -ExternalVersion "1.0"} | Should Throw
			}

		}

		Context "Output" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{"Prop1" = "Val1"; "Prop2" = "Val2"}
				}

				$InputObj = [pscustomobject]@{
					"sessionToken" = @{"Authorization" = "P_AuthValue"}
					"WebSession"   = New-Object Microsoft.PowerShell.Commands.WebRequestSession
					"BaseURI"      = "https://P_URI"
					"PVWAAppName"  = "P_App"

				}

				$response = $InputObj | Get-PASDirectory -id SomeDir

			}

			it "provides output" {

				$response | Should not BeNullOrEmpty

			}

			It "has output with expected number of properties" {

				($response | Get-Member -MemberType NoteProperty).length | Should Be 7

			}

			it "outputs object with expected typename" {

				$response | get-member | select-object -expandproperty typename -Unique | Should Be psPAS.CyberArk.Vault.Directory.Extended

			}

			it "outputs object with expected typename" {

				$response = $InputObj | Get-PASDirectory

				$response | get-member | select-object -expandproperty typename -Unique | Should Be psPAS.CyberArk.Vault.Directory

			}

			$DefaultProps = @{Property = 'sessionToken'},
			@{Property = 'WebSession'},
			@{Property = 'BaseURI'},
			@{Property = 'PVWAAppName'},
			@{Property = 'ExternalVersion'}

			It "returns default property <Property> in response" -TestCases $DefaultProps {
				param($Property)

				$response.$Property | Should Not BeNullOrEmpty

			}

		}

	}

}