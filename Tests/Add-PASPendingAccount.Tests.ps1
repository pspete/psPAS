#Get Current Directory
$Here = Split-Path -Parent $MyInvocation.MyCommand.Path

#Get Function Name
$FunctionName = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -Replace ".Tests.ps1"

#Assume ModuleName from Repo Root folder
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
			Write-Output @{}
		}

		$InputObj = [pscustomobject]@{
			"sessionToken"            = @{"Authorization" = "P_AuthValue"}
			"WebSession"              = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			"BaseURI"                 = "https://P_URI"
			"PVWAAppName"             = "P_App"
			"UserName"                = "SomeUser"
			"Address"                 = "SomeAddress"
			"AccountDiscoveryDate"    = "2018-02-22T22:22:22Z"
			"OSType"                  = "Windows"
			"AccountEnabled"          = "enabled"
			"AccountOSGroups"         = "SomeGroup"
			"AccountType"             = "local"
			"DiscoveryPlatformType"   = "SomePlatform"
			"Domain"                  = "SomeDomain"
			"LastLogonDate"           = "2017-12-31T23:59:59Z"
			"LastPasswordSet"         = "1995-05-06T20:20:00Z"
			"PasswordNeverExpires"    = $true
			"OSVersion"               = "SomeValue"
			"OU"                      = "SomeOU"
			"AccountCategory"         = "privileged"
			"AccountCategoryCriteria" = "some;category"
			"UserDisplayName"         = "DisplayThis"
			"AccountDescription"      = "SomeDescription"
			"AccountExpirationDate"   = "2020-01-01T00:00:00Z"
			"UID"                     = "0"
			"GID"                     = "0"
			"MachineOSFamily"         = "Workstation"
		}

		Context "Mandatory Parameters" {
			$Parameters = @{Parameter = 'BaseURI'},
			@{Parameter = 'SessionToken'},
			@{Parameter = 'UserName'},
			@{Parameter = 'Address'},
			@{Parameter = 'AccountDiscoveryDate'},
			@{Parameter = 'AccountEnabled'}

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {
				param($Parameter)

				(Get-Command Add-PASPendingAccount).Parameters["$Parameter"].Attributes.Mandatory | Should Be $true

			}

		}

		$response = $InputObj | Add-PASPendingAccount -verbose

		Context "Input" {

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope Describe

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled 'Invoke-PASRestMethod' -ParameterFilter {

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/WebServices/PIMServices.svc/PendingAccounts"

				} -Times 1 -Exactly -Scope Describe

			}

			It "sends request using expected method" {

				Assert-MockCalled 'Invoke-PASRestMethod' -ParameterFilter {$Method -match 'POST' } -Times 1 -Exactly -Scope Describe

			}

			It "sends request with expected body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody.pendingAccount) -ne $null

				} -Times 1 -Exactly -Scope Describe

			}

			It "has a request body with expected number of properties" {

				($Script:RequestBody.pendingAccount | Get-Member -MemberType NoteProperty).length | Should Be 21

			}

		}

		Context "Output" {

			it "provides no output" {

				$response | Should BeNullOrEmpty

			}

		}

	}

}