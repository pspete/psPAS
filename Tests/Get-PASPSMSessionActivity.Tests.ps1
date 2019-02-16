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
			@{Parameter = 'liveSessionId'}

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command Get-PASPSMSessionActivity).Parameters["$Parameter"].Attributes.Mandatory | Should Be $true

			}

		}

		Context "Input" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {}

				$InputObj = [pscustomobject]@{
					"sessionToken"  = @{"Authorization" = "P_AuthValue"}
					"WebSession"    = New-Object Microsoft.PowerShell.Commands.WebRequestSession
					"BaseURI"       = "https://P_URI"
					"PVWAAppName"   = "P_App"
					"liveSessionId" = "SomeID"

				}

			}

			It "sends request" {
				$InputObj | Get-PASPSMSessionActivity
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {
				$InputObj | Get-PASPSMSessionActivity
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/API/LiveSessions/SomeID/activities"

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {
				$InputObj | Get-PASPSMSessionActivity
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It "sends request with no body" {
				$InputObj | Get-PASPSMSessionActivity
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Body -eq $null} -Times 1 -Exactly -Scope It

			}

			It "throws error if version requirement not met" {

				{$InputObj | Get-PASPSMSessionActivity -ExternalVersion 10.5} | Should throw

			}

		}

		Context "Output" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[pscustomobject]@{
						"Activities" = [pscustomobject]@{
							"Prop1" = "Value1"
							"Prop2" = "Value2"
							"Prop3" = "Value3"
							"Prop4" = "Value4"
						}
					}
				}

				$InputObj = [pscustomobject]@{
					"sessionToken"  = @{"Authorization" = "P_AuthValue"}
					"WebSession"    = New-Object Microsoft.PowerShell.Commands.WebRequestSession
					"BaseURI"       = "https://P_URI"
					"PVWAAppName"   = "P_App"
					"liveSessionId" = "SomeID"
				}

			}

			it "provides output" {
				$response = $InputObj | Get-PASPSMSessionActivity
				$response | Should not BeNullOrEmpty

			}

			it "outputs object with expected typename" {
				$response = $InputObj | Get-PASPSMSessionActivity
				$response | get-member | select-object -expandproperty typename -Unique | Should Be psPAS.CyberArk.Vault.PSM.Session.Activity

			}

			It "has output with expected number of properties" {
				$response = $InputObj | Get-PASPSMSessionActivity
				($response | Get-Member -MemberType NoteProperty).length | Should Be 9

			}

			$DefaultProps = @{Property = 'sessionToken'},
			@{Property = 'WebSession'},
			@{Property = 'BaseURI'},
			@{Property = 'PVWAAppName'},
			@{Property = 'ExternalVersion'}


			It "returns default property <Property> in response" -TestCases $DefaultProps {
				param($Property)
				($InputObj | Get-PASPSMSessionActivity).$Property | Should Not BeNullOrEmpty

			}

		}

	}

}