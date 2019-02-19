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
			@{Parameter = 'SessionToken'},
			@{Parameter = 'Id'},
			@{Parameter = 'TargetPlatformId'},
			@{Parameter = 'TargetSafeName'},
			@{Parameter = 'SystemTypeFilter'}

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command Set-PASOnboardingRule ).Parameters["$Parameter"].Attributes.Mandatory | Should Be $true

			}

		}

		Context "Input" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {}

				$InputObj = [pscustomobject]@{
					"sessionToken"     = @{"Authorization" = "P_AuthValue"}
					"WebSession"       = New-Object Microsoft.PowerShell.Commands.WebRequestSession
					"BaseURI"          = "https://P_URI"
					"PVWAAppName"      = "P_App"
					"SystemTypeFilter" = "Windows"
					"TargetSafeName"   = "SomeSafe"
					"TargetPlatformId" = "SomePlatform"
					"Id"               = "123"

				}

			}

			It "sends request" {
				$InputObj | Set-PASOnboardingRule
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {
				$InputObj | Set-PASOnboardingRule
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/api/AutomaticOnboardingRules/123"

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {
				$InputObj | Set-PASOnboardingRule
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Method -match 'PUT' } -Times 1 -Exactly -Scope It

			}

			It "sends request with expected body" {
				$InputObj | Set-PASOnboardingRule
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
					($Body) -ne $null
				} -Times 1 -Exactly -Scope It

			}

			It "has a request body with expected number of properties" {
				$InputObj | Set-PASOnboardingRule
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					($Body | ConvertFrom-Json | Get-Member -MemberType NoteProperty).length -eq 3

				} -Times 1 -Exactly -Scope It
			}

			It "throws error if version requirement not met" {

				{$InputObj | Set-PASOnboardingRule -ExternalVersion 1.2} | Should throw

			}

		}

		Context "Output" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {

					[pscustomobject]@{
						"Prop1" = "Value1"
						"Prop2" = "Value2"
						"Prop3" = "Value3"
						"Prop4" = "Value4"
					}



				}


				$InputObj = [pscustomobject]@{
					"sessionToken"     = @{"Authorization" = "P_AuthValue"}
					"WebSession"       = New-Object Microsoft.PowerShell.Commands.WebRequestSession
					"BaseURI"          = "https://P_URI"
					"PVWAAppName"      = "P_App"
					"SystemTypeFilter" = "Windows"
					"TargetSafeName"   = "SomeSafe"
					"TargetPlatformId" = "SomePlatform"
					"Id"               = "123"

				}

			}

			it "provides output" {
				$response = $InputObj | Set-PASOnboardingRule
				$response | Should Not BeNullOrEmpty

			}

			it "outputs object with expected typename" {
				$response = $InputObj | Set-PASOnboardingRule
				$response | get-member | select-object -expandproperty typename -Unique | Should Be psPAS.CyberArk.Vault.OnboardingRule

			}

			$DefaultProps = @{Property = 'sessionToken'},
			@{Property = 'WebSession'},
			@{Property = 'BaseURI'},
			@{Property = 'PVWAAppName'},
			@{Property = 'ExternalVersion'}


			It "returns default property <Property> in response" -TestCases $DefaultProps {
				param($Property)
				($InputObj | Set-PASOnboardingRule).$Property | Should Not BeNullOrEmpty

			}

		}

	}

}