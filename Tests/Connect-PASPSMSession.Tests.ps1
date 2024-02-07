Describe $($PSCommandPath -Replace '.Tests.ps1') {

	BeforeAll {
		#Get Current Directory
		$Here = Split-Path -Parent $PSCommandPath

		#Assume ModuleName from Repository Root folder
		$ModuleName = Split-Path (Split-Path $Here -Parent) -Leaf

		#Resolve Path to Module Directory
		$ModulePath = Resolve-Path "$Here\..\$ModuleName"

		#Define Path to Module Manifest
		$ManifestPath = Join-Path "$ModulePath" "$ModuleName.psd1"

		if ( -not (Get-Module -Name $ModuleName -All)) {

			Import-Module -Name "$ManifestPath" -ArgumentList $true -Force -ErrorAction Stop

		}

		$Script:RequestBody = $null
		$psPASSession = [ordered]@{
			BaseURI            = 'https://SomeURL/SomeApp'
			User               = $null
			ExternalVersion    = [System.Version]'0.0'
			WebSession         = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			StartTime          = $null
			ElapsedTime        = $null
			LastCommand        = $null
			LastCommandTime    = $null
			LastCommandResults = $null
		}

		New-Variable -Name psPASSession -Value $psPASSession -Scope Script -Force

	}


	AfterAll {

		$Script:RequestBody = $null

	}

	InModuleScope $(Split-Path (Split-Path (Split-Path -Parent $PSCommandPath) -Parent) -Leaf ) {

		Context 'Mandatory Parameters' {

			$Parameters = @{Parameter = 'SessionId' },
			@{Parameter = 'ConnectionMethod' }

			It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command Connect-PASPSMSession).Parameters["$Parameter"].Attributes.Mandatory | Select-Object -Unique | Should -Be $true

			}

		}

		Context 'Input' {

			BeforeEach {

				$Script:psPASSession.BaseURI = 'https://SomeURL/SomeApp'
				$psPASSession.ExternalVersion = '0.0'
				$psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

				Mock Invoke-PASRestMethod -MockWith {

					[PSCustomObject]@{'Prop1' = 'VAL1'; 'Prop2' = 'Val2'; 'Prop3' = 'Val3' }
				}

				$InputObj = [pscustomobject]@{

					'SessionId'        = 'SomeSession'
					'ConnectionMethod' = 'RDP'

				}

			}

			It 'sends request' {
				$InputObj | Connect-PASPSMSession
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint for PSMConnect' {
				$InputObj | Connect-PASPSMSession
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/LiveSessions/SomeSession/monitor"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {
				$InputObj | Connect-PASPSMSession
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {
				$InputObj | Connect-PASPSMSession
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Body -eq $null

				} -Times 1 -Exactly -Scope It

			}

			It 'has expected Accept key in header' {
				$InputObj | Connect-PASPSMSession
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$WebSession.Headers['Accept'] -eq 'application/json'

				} -Times 1 -Exactly -Scope It

			}

			It 'specifies expected Accept key in header for PSMGW requests' {

				$InputObj | Connect-PASPSMSession -ConnectionMethod PSMGW

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$WebSession.Headers['Accept'] -eq '* / *'

				} -Times 1 -Exactly -Scope It

			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '9.8'
				{ $InputObj | Connect-PASPSMSession -ConnectionMethod RDP } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

		Context 'Output' {

			BeforeEach {

				$Script:psPASSession.BaseURI = 'https://SomeURL/SomeApp'
				$psPASSession.ExternalVersion = '0.0'
				$psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

				Mock Invoke-PASRestMethod -MockWith {

					[PSCustomObject]@{'Prop1' = 'VAL1'; 'Prop2' = 'Val2'; 'Prop3' = 'Val3' }
				}

				$InputObj = [pscustomobject]@{

					'SessionId'        = 'SomeSession'
					'ConnectionMethod' = 'RDP'

				}

			}

			It 'provides output' {

				$InputObj | Connect-PASPSMSession | Should -Not -BeNullOrEmpty

			}

			It 'has output with expected number of properties' {

				($InputObj | Connect-PASPSMSession | Get-Member -MemberType NoteProperty).length | Should -Be 3

			}

			It 'outputs object with expected typename' {

				$InputObj | Connect-PASPSMSession | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be System.Management.Automation.PSCustomObject

			}



		}

	}

}