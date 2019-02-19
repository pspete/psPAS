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
			[PSCustomObject]@{"addsaferesult" = [PSCustomObject]@{"Prop1" = "Val1"; "Prop2" = "Val2"}}
		}

		$InputObj = [pscustomobject]@{
			"sessionToken" = @{"Authorization" = "P_AuthValue"}
			"WebSession"   = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			"BaseURI"      = "https://P_URI"
			"PVWAAppName"  = "P_App"
			"SafeName"     = "SomeName"

		}

		Context "Mandatory Parameters" {

			$Parameters = @{Parameter = 'BaseURI'},
			@{Parameter = 'SessionToken'},
			@{Parameter = 'SafeName'}

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command Add-PASSafe).Parameters["$Parameter"].Attributes.Mandatory | Should Be $true

			}

			It "specifies parameter NumberOfVersionsRetention as mandatory for ParameterSet Versions" {

				(Get-Command Add-PASSafe).Parameters["NumberOfVersionsRetention"].ParameterSets["Versions"].IsMandatory | Should be $true

			}

			It "specifies parameter NumberOfDaysRetention as mandatory for ParameterSet Days" {

				(Get-Command Add-PASSafe).Parameters["NumberOfDaysRetention"].ParameterSets["Days"].IsMandatory | Should be $true

			}

		}

		$response = $InputObj | Add-PASSafe -NumberOfDaysRetention 1

		Context "Input" {

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope Describe

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/WebServices/PIMServices.svc/Safes"

				} -Times 1 -Exactly -Scope Describe

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Method -match 'POST' } -Times 1 -Exactly -Scope Describe

			}

			It "sends request with expected body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody.safe) -ne $null

				} -Times 1 -Exactly -Scope Describe

			}

			It "has a request body with expected number of properties" {

				($Script:RequestBody.safe | Get-Member -MemberType NoteProperty).length | Should Be 2

			}

		}

		Context "Output" {

			it "provides output" {

				$response | Should not BeNullOrEmpty

			}

			It "has output with expected number of properties" {

				($response | Get-Member -MemberType NoteProperty).length | Should Be 7

			}

			it "outputs object with expected typename" {

				$response | get-member | select-object -expandproperty typename -Unique | Should Be psPAS.CyberArk.Vault.Safe

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