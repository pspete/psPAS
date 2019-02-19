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
			"AppID"        = "SomeApplication"
			"AuthValue"    = "SomePath"

		}

		Context "Mandatory Parameters" {

			$Parameters = @{Parameter = 'BaseURI'},
			@{Parameter = 'SessionToken'},
			@{Parameter = 'AppID'},
			@{Parameter = 'AuthType'},
			@{Parameter = 'AuthValue'}

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command Add-PASApplicationAuthenticationMethod).Parameters["$Parameter"].Attributes.Mandatory | Should Be $true

			}

		}

		$response = $InputObj | Add-PASApplicationAuthenticationMethod -AuthType path -IsFolder $true -AllowInternalScripts $true

		Context "Input" {

			It "validates authType parameter" {

				{$InputObj | Add-PASApplicationAuthenticationMethod -AuthType InvalidAuthType} | Should throw

			}

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope Describe

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/WebServices/PIMServices.svc/Applications/SomeApplication/Authentications"

				} -Times 1 -Exactly -Scope Describe

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Method -match 'POST' } -Times 1 -Exactly -Scope Describe

			}

			It "sends request with expected body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody.authentication) -ne $null

				} -Times 1 -Exactly -Scope Describe

			}

			It "has dynamic parameter 'IsFolder' when authtype path is specified" {

				$Script:RequestBody.authentication.IsFolder | Should Be $true

			}

			It "has dynamic parameter 'AllowInternalScripts' when authtype path is specified" {

				$Script:RequestBody.authentication.AllowInternalScripts | Should Be $true

			}

			It "has a request body with expected number of properties" {

				($Script:RequestBody.authentication | Get-Member -MemberType NoteProperty).length | Should Be 5

			}

			It "has dynamic parameter 'Comment' when authtype 'hash' is specified" {

				$InputObj | Add-PASApplicationAuthenticationMethod -AuthType hash -Comment "Some Comment"

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$RequestBody = $Body | ConvertFrom-Json

					($RequestBody.authentication.Comment) -eq "Some Comment"

				} -Times 1 -Exactly -Scope It

			}

			It "has dynamic parameter 'comment' when authtype 'certificateserialnumber' is specified" {

				$InputObj | Add-PASApplicationAuthenticationMethod -AuthType certificateserialnumber -Comment "Some Other Comment"

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$RequestBody = $Body | ConvertFrom-Json

					($RequestBody.authentication.Comment) -eq "Some Other Comment"

				} -Times 1 -Exactly -Scope It

			}

			It "throws if dynamic parameter 'comment' is specified with incorrect authtype" {

				{$InputObj | Add-PASApplicationAuthenticationMethod -AuthType path -Comment "Some Random Comment"} | Should Throw

			}

		}

		Context "Output" {

			it "provides no output" {

				$response | Should BeNullOrEmpty

			}

		}

	}

}