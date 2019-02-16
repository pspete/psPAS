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

		Mock Invoke-PASRestMethod -MockWith {

		}

		$InputObj = [pscustomobject]@{
			"sessionToken" = @{"Authorization" = "P_AuthValue"}
			"WebSession"   = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			"BaseURI"      = "https://P_URI"
			"PVWAAppName"  = "P_App"
			"AccountID"    = "99_9"

		}

		Context "Mandatory Parameters" {

			$Parameters = @{Parameter = 'BaseURI'},
			@{Parameter = 'SessionToken'},
			@{Parameter = 'UpdateVaultOnly'},
			@{Parameter = 'SetNextPassword'},
			@{Parameter = 'AccountID'}

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command Invoke-PASCredChange).Parameters["$Parameter"].Attributes.Mandatory | Should Be $true

			}

			It "specifies parameter NewCredentials as mandatory for ParameterSet Password/Update" {

				(Get-Command Invoke-PASCredChange).Parameters["NewCredentials"].ParameterSets["Password/Update"].IsMandatory | Should be $true

			}

			It "specifies parameter NewCredentials as mandatory for ParameterSet SetNextPassword" {

				(Get-Command Invoke-PASCredChange).Parameters["NewCredentials"].ParameterSets["SetNextPassword"].IsMandatory | Should be $true

			}

		}

		$response = $InputObj | Invoke-PASCredChange -ChangeCredsForGroup $true #-verbose

		Context "Input - Change ParameterSet" {

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope Describe

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/API/Accounts/99_9/Change"

				} -Times 1 -Exactly -Scope Describe

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Method -match 'POST' } -Times 1 -Exactly -Scope Describe

			}

			It "sends request with expected body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope Describe

			}

			It "has a request body with expected number of properties" {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should Be 1

			}

			It "throws error if version requirement not met" {
				{$InputObj | Invoke-PASCredChange -ChangeCredsForGroup $true -ExternalVersion "1.0"} | Should Throw
			}

		}

		Context "Input - Password/Update ParameterSet" {

			$newcreds = "test" | ConvertTo-SecureString -AsPlainText -Force
			$response = $InputObj | Invoke-PASCredChange -ChangeCredsForGroup $true -UpdateVaultOnly -NewCredentials $newcreds

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope Context

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/API/Accounts/99_9/Password/Update"

				} -Times 1 -Exactly -Scope Context

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Method -match 'POST' } -Times 1 -Exactly -Scope Context

			}

			It "sends request with expected body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope Context

			}

			It "has a request body with expected number of properties" {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should Be 2

			}

			It "throws error if version requirement not met" {
				{$InputObj | Invoke-PASCredChange -ChangeCredsForGroup $true -UpdateVaultOnly -NewCredentials $newcreds -ExternalVersion "9.11"} | Should Throw
			}

		}

		Context "Input - SetNextPassword ParameterSet" {

			$newcreds = "test" | ConvertTo-SecureString -AsPlainText -Force
			$response = $InputObj | Invoke-PASCredChange -SetNextPassword -NewCredentials $newcreds

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope Context

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/API/Accounts/99_9/SetNextPassword"

				} -Times 1 -Exactly -Scope Context

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Method -match 'POST' } -Times 1 -Exactly -Scope Context

			}

			It "sends request with expected body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope Context

			}

			It "has a request body with expected number of properties" {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should Be 1

			}

			It "throws error if version requirement not met" {
				{$InputObj | Invoke-PASCredChange -SetNextPassword -NewCredentials $newcreds -ExternalVersion "9.11"} | Should Throw
			}

		}

		Context "Output" {

			it "provides no output" {

				$response | Should BeNullOrEmpty

			}

		}

	}

}