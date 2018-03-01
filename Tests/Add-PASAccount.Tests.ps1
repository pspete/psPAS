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

	Import-Module -Name "$ManifestPath" -Force -ErrorAction Stop

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
			"Safe"                  = "P_Safe"
			"platformID"            = "P_Platform"
			"password"              = $("P_Password" | ConvertTo-SecureString -AsPlainText -Force)
			"username"              = "P_UserName"
			"sessionToken"          = @{"Authorization" = "P_AuthValue"}
			"WebSession"            = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			"BaseURI"               = "https://P_URI"
			"PVWAAppName"           = "P_App"
			"Port"                  = 1234
			"ExtraPass1Name"        = "P_ExtP1"
			"DynamicProperties"     = @{"TestKey" = "TestVal"; "TestKey1" = "TestVal"; "TestKey2" = "TestVal"}
			"address"               = "10.10.10.10"
			"accountName"           = "SomeName"
			"disableAutoMgmt"       = $true
			"disableAutoMgmtReason" = "SomeReason"
			"groupName"             = "SomeGroup"
			"groupPlatformID"       = "GPlatform"
			"ExtraPass1Folder"      = "Root"
			"ExtraPass1Safe"        = "Safe1"
			"ExtraPass3Name"        = "SomeName"
			"ExtraPass3Folder"      = "Root"
			"ExtraPass3Safe"        = "SomeSafe"
		}

		Context "Mandatory Parameters" {

			$Parameters = @{Parameter = 'BaseURI'},
			@{Parameter = 'SessionToken'},
			@{Parameter = 'safe'},
			@{Parameter = 'platformID'},
			@{Parameter = 'password'},
			@{Parameter = 'username'}

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				{((Get-Command $FunctionName).Parameters["$Parameter"].Attributes).Mandatory} |
					Should Be $true

			}

		}

		$response = $InputObj | Add-PASAccount -verbose

		Context "Input" {

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope Describe

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/WebServices/PIMServices.svc/Account"

				} -Times 1 -Exactly -Scope Describe

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Method -match 'POST' } -Times 1 -Exactly -Scope Describe

			}

			It "sends request with expected body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody.Account) -ne $null

				} -Times 1 -Exactly -Scope Describe

			}

			It "has a request body with expected number of properties" {

				($Script:RequestBody.Account | Get-Member -MemberType NoteProperty).length | Should Be 11

			}

			It "has expected number of nested properties" {

				($Script:RequestBody.Account.Properties).count | Should Be 10

			}

		}

		Context "Output" {

			it "provides no output" {

				$response | Should BeNullOrEmpty

			}

		}

	}

}