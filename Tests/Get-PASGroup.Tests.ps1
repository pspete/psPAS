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

				(Get-Command Get-PASGroup).Parameters["$Parameter"].Attributes.Mandatory | Should Be $true

			}

		}

		Context "Input" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {}

				$InputObj = [pscustomobject]@{
					"sessionToken" = @{"Authorization" = "P_AuthValue"}
					"WebSession"   = New-Object Microsoft.PowerShell.Commands.WebRequestSession
					"BaseURI"      = "https://P_URI"
					"PVWAAppName"  = "P_App"

				}

			}

			It "sends request" {
				$InputObj | Get-PASGroup
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {
				$InputObj | Get-PASGroup
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/API/UserGroups?"

				} -Times 1 -Exactly -Scope It

			}

			It "sends request with expected query" {
				$InputObj | Get-PASGroup -filter "groupType eq Directory" -search "Search Term"
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					($URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/API/UserGroups?search=Search%20Term&filter=groupType%20eq%20Directory") -or ($URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/API/UserGroups?filter=groupType%20eq%20Directory&search=Search%20Term")

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {
				$InputObj | Get-PASGroup
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It "sends request with no body" {
				$InputObj | Get-PASGroup
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Body -eq $null} -Times 1 -Exactly -Scope It

			}

			It "throws error if version requirement not met" {

				{$InputObj | Get-PASGroup -ExternalVersion 1.2} | Should throw

			}

		}

		Context "Output" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[pscustomobject]@{
						"value" = [pscustomobject]@{
							"Prop1" = "Value1"
							"Prop2" = "Value2"
							"Prop3" = "Value3"
							"Prop4" = "Value4"
						}
					}
				}

				$InputObj = [pscustomobject]@{
					"sessionToken" = @{"Authorization" = "P_AuthValue"}
					"WebSession"   = New-Object Microsoft.PowerShell.Commands.WebRequestSession
					"BaseURI"      = "https://P_URI"
					"PVWAAppName"  = "P_App"
				}

			}

			it "provides output" {
				$response = $InputObj | Get-PASGroup
				$response | Should not BeNullOrEmpty

			}

			It "has output with expected number of properties" {
				$response = $InputObj | Get-PASGroup
				($response | Get-Member -MemberType NoteProperty).length | Should Be 9

			}

			$DefaultProps = @{Property = 'sessionToken'},
			@{Property = 'WebSession'},
			@{Property = 'BaseURI'},
			@{Property = 'PVWAAppName'},
			@{Property = 'ExternalVersion'}


			It "returns default property <Property> in response" -TestCases $DefaultProps {
				param($Property)
				($InputObj | Get-PASGroup).$Property | Should Not BeNullOrEmpty

			}

		}

	}

}