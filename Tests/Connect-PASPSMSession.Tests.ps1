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

}

AfterAll {

	$Script:RequestBody = $null

}

Describe $FunctionName {

	InModuleScope $ModuleName {



		Context "Mandatory Parameters" {

			$Parameters = @{Parameter = 'SessionId' },
			@{Parameter = 'ConnectionMethod' }

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command Connect-PASPSMSession).Parameters["$Parameter"].Attributes.Mandatory | Select-Object -Unique | Should Be $true

			}

		}

		Context "Input" {

			BeforeEach {

				$Script:BaseURI = "https://SomeURL/SomeApp"
				$Script:ExternalVersion = "0.0"
				$Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

				Mock Invoke-PASRestMethod -MockWith {

					[PSCustomObject]@{"Prop1" = "VAL1"; "Prop2" = "Val2"; "Prop3" = "Val3" }
				}

				$InputObj = [pscustomobject]@{

					"SessionId"        = "SomeSession"
					"ConnectionMethod" = "RDP"

				}

			}

			It "sends request" {
				$InputObj | Connect-PASPSMSession
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint for PSMConnect" {
				$InputObj | Connect-PASPSMSession
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/API/LiveSessions/SomeSession/monitor"

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {
				$InputObj | Connect-PASPSMSession
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It "sends request with no body" {
				$InputObj | Connect-PASPSMSession
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Body -eq $null

				} -Times 1 -Exactly -Scope It

			}

			It "has expected Accept key in header" {
				$InputObj | Connect-PASPSMSession
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$WebSession.Headers["Accept"] -eq 'application/json'

				} -Times 1 -Exactly -Scope It

			}

			It "specifies expected Accept key in header for PSMGW requests" {

				$InputObj | Connect-PASPSMSession -ConnectionMethod PSMGW

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$WebSession.Headers["Accept"] -eq '* / *'

				} -Times 1 -Exactly -Scope It

			}

			It "throws error if version requirement not met" {
				{ $InputObj | Connect-PASPSMSession -ConnectionMethod RDP -ExternalVersion "9.8" } | Should Throw
			}

		}

		Context "Output" {

			BeforeEach {

				$Script:BaseURI = "https://SomeURL/SomeApp"
				$Script:ExternalVersion = "0.0"
				$Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

				Mock Invoke-PASRestMethod -MockWith {

					[PSCustomObject]@{"Prop1" = "VAL1"; "Prop2" = "Val2"; "Prop3" = "Val3" }
				}

				$InputObj = [pscustomobject]@{

					"SessionId"        = "SomeSession"
					"ConnectionMethod" = "RDP"

				}

			}

			it "provides output" {

				$InputObj | Connect-PASPSMSession | Should not BeNullOrEmpty

			}

			It "has output with expected number of properties" {

				($InputObj | Connect-PASPSMSession | Get-Member -MemberType NoteProperty).length | Should Be 3

			}

			it "outputs object with expected typename" {

				$InputObj | Connect-PASPSMSession | get-member | select-object -expandproperty typename -Unique | Should Be System.Management.Automation.PSCustomObject

			}



		}

	}

}