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
			"sessionToken"  = @{"Authorization" = "P_AuthValue"}
			"WebSession"    = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			"BaseURI"       = "https://P_URI"
			"PVWAAppName"   = "P_App"
			"LiveSessionId" = "SomeSessionID"

		}

		Context "Mandatory Parameters" {

			$Parameters = @{Parameter = 'BaseURI'},
			@{Parameter = 'SessionToken'},
			@{Parameter = 'LiveSessionId'}

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command Stop-PASPSMSession).Parameters["$Parameter"].Attributes.Mandatory | Should Be $true

			}

		}

		$response = $InputObj | Stop-PASPSMSession

		Context "Input" {

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope Describe

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/api/LiveSessions/SomeSessionID/Terminate"

				} -Times 1 -Exactly -Scope Describe

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Method -match 'POST' } -Times 1 -Exactly -Scope Describe

			}

			It "sends request with no body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Body -eq $null} -Times 1 -Exactly -Scope Describe

			}

			It "throws error if version requirement not met" {
				{$InputObj | Stop-PASPSMSession -ExternalVersion "1.0"} | Should Throw
			}

		}

		Context "Output" {

			it "provides no output" {

				$response | Should Be $null

			}

		}

	}

}