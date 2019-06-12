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
	$Script:BaseURI = "https://SomeURL/SomeApp"
	$Script:ExternalVersion = "0.0"
	$Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

}

AfterAll {

	$Script:RequestBody = $null

}

Describe $FunctionName {

	InModuleScope $ModuleName {

		Mock Invoke-PASRestMethod -MockWith {
			[PSCustomObject]@{
				"MyRequests"       = [PSCustomObject]@{"Prop1" = "Val1"; "Prop2" = "val2" }
				"IncomingRequests" = [PSCustomObject]@{"PropA" = "ValA"; "PropB" = "ValB"; "PropC" = "ValC" }
			}
		}

		Context "Mandatory Parameters" {

			$Parameters = @{Parameter = 'RequestType' },
			@{Parameter = 'OnlyWaiting' },
			@{Parameter = 'Expired' }

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command Get-PASRequest).Parameters["$Parameter"].Attributes.Mandatory | Should Be $true

			}

		}

		Context "Input - MyRequests" {

			Get-PASRequest -RequestType MyRequests -OnlyWaiting $true -Expired $true

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope Context

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/API/MyRequests?onlywaiting=true&expired=true"

				} -Times 1 -Exactly -Scope Context

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope Context

			}

			It "sends request with no body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope Context

			}

			It "throws error if version requirement not met" {
				{ Get-PASRequest -RequestType MyRequests -OnlyWaiting $true -Expired $true -ExternalVersion "1.0" } | Should Throw
			}

		}

		Context "Input - IncomingRequests" {

			Get-PASRequest -RequestType IncomingRequests -OnlyWaiting $true -Expired $true

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope Context

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/API/IncomingRequests?onlywaiting=true&expired=true"

				} -Times 1 -Exactly -Scope Context

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope Context

			}

			It "sends request with no body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope Context

			}

		}

		Context "Output - MyRequests" {

			$response = Get-PASRequest -RequestType MyRequests -OnlyWaiting $true -Expired $false

			it "provides output" {

				$response | Should not BeNullOrEmpty

			}

			It "has output with expected number of properties" {

				($response | Get-Member -MemberType NoteProperty).length | Should Be 2

			}

			it "outputs object with expected typename" {

				$response | get-member | select-object -expandproperty typename -Unique | Should Be psPAS.CyberArk.Vault.Request.Details

			}



		}

		Context "Output - IncomingRequests" {

			$response = Get-PASRequest -RequestType IncomingRequests -OnlyWaiting $true -Expired $false

			it "provides output" {

				$response | Should not BeNullOrEmpty

			}

			It "has output with expected number of properties" {

				($response | Get-Member -MemberType NoteProperty).length | Should Be 3

			}

			it "outputs object with expected typename" {

				$response | get-member | select-object -expandproperty typename -Unique | Should Be psPAS.CyberArk.Vault.Request.Details

			}



		}

	}

}