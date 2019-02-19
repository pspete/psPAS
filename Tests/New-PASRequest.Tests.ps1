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
			[PSCustomObject]@{"Prop1" = "Val1"; "Prop2" = "val2"; "PropA" = "ValA"; "PropB" = "ValB"; "PropC" = "ValC"}
		}

		$InputObj = [pscustomobject]@{
			"sessionToken"        = @{"Authorization" = "P_AuthValue"}
			"WebSession"          = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			"BaseURI"             = "https://P_URI"
			"PVWAAppName"         = "P_App"
			"AccountID"           = "SomeID"
			"Reason"              =	"Some Important Reason"
			"TicketingSystemName" = "SomeName"
			"TicketID"            = "TicketID123"
			"MultipleAccess"      = $true
			"FromDate"            = (Get-Date 1-1-2018)
			"ToDate"              = (Get-Date 12-12-2018)
		}

		Context "Mandatory Parameters" {

			$Parameters = @{Parameter = 'BaseURI'},
			@{Parameter = 'SessionToken'},
			@{Parameter = 'AccountID'}

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command New-PASRequest).Parameters["$Parameter"].Attributes.Mandatory | Should Be $true

			}

		}

		$response = $InputObj | New-PASRequest

		Context "Input" {

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope Describe

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/API/MyRequests"

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

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should Be 7

			}

			It "converts datetime 'FromDate' to expected value" {

				$Script:RequestBody.FromDate | Should Be 1514764800

			}

			It "converts datetime 'ToDate' to expected value" {

				$Script:RequestBody.ToDate | Should Be 1544572800

			}

			It "throws error if version requirement not met" {
				{$InputObj | New-PASRequest -ExternalVersion "1.0"} | Should Throw
			}

		}

		Context "Output" {

			it "provides output" {

				$response | Should not BeNullOrEmpty

			}

			It "has output with expected number of properties" {

				($response | Get-Member -MemberType NoteProperty).length | Should Be 10

			}

			it "outputs object with expected typename" {

				$response | get-member | select-object -expandproperty typename -Unique | Should Be psPAS.CyberArk.Vault.Request

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