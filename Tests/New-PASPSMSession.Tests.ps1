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

			$Parameters = @{Parameter = 'AccountID' },
			@{Parameter = 'ConnectionComponent' }

			It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command New-PASPSMSession).Parameters["$Parameter"].Attributes.Mandatory | Select-Object -Unique | Should -Be $true

			}

		}

		Context 'Input' {

			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{'Prop1' = 'VAL1'; 'Prop2' = 'Val2'; 'Prop3' = 'Val3' }
				}

				$InputObj = [pscustomobject]@{

					'AccountID'           = '99_9'
					'ConnectionComponent' = 'SomeConnectionComponent'

				}

				$AdHocObj = [pscustomobject]@{
					'ConnectionComponent' = 'SomeConnectionComponent'
					'UserName'            = 'SomeUser'
					'secret'              = 'SomeSecret' | ConvertTo-SecureString -AsPlainText -Force
					'address'             = 'Some.Address'
					'platformID'          = 'SomePlatform'

				}

				$Script:psPASSession.BaseURI = 'https://SomeURL/SomeApp'
				$psPASSession.ExternalVersion = '0.0'
				$psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

				Mock Out-PASFile -MockWith { }
			}

			It 'throws if path is invalid' {
				{ $InputObj | New-PASPSMSession -ConnectionMethod RDP -Path A:\test.txt } | Should -Throw
			}

			It 'sends request' {

				$InputObj | New-PASPSMSession -ConnectionMethod RDP

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint for PSMConnect' {

				$InputObj | New-PASPSMSession -ConnectionMethod RDP

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Accounts/99_9/PSMConnect"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				$InputObj | New-PASPSMSession -ConnectionMethod RDP

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected body' {

				$InputObj | New-PASPSMSession -ConnectionMethod RDP -PSMRemoteMachine 'SomeMachine'

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It 'has a request body with expected number of properties' {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should -Be 2

			}

			It 'has a request body with expected ConnectionParams' {

				$Script:RequestBody.ConnectionParams.PSMRemoteMachine.Value | Should -Be 'SomeMachine'

			}

			It 'has expected Accept key in header' {

				$InputObj | New-PASPSMSession -ConnectionMethod RDP

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$WebSession.Headers['Accept'] -eq 'application/octet-stream' } -Times 1 -Exactly -Scope It

			}

			It 'specifies expected Accept key in header for PSMGW requests' {

				$InputObj | New-PASPSMSession -ConnectionMethod PSMGW

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$WebSession.Headers['Accept'] -eq '* / *' } -Times 1 -Exactly -Scope It

			}

			It 'throws error if version requirement not met for RDP connection method' {
				$psPASSession.ExternalVersion = '9.8'
				{ $InputObj | New-PASPSMSession -ConnectionMethod RDP } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

			It 'throws error if version requirement not met for PSMGW connection method' {

				$psPASSession.ExternalVersion = '9.10'
				{ $InputObj | New-PASPSMSession -ConnectionMethod PSMGW } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

			It 'sends request to expected endpoint for AdHocConnect' {

				$AdHocObj | New-PASPSMSession -ConnectionMethod RDP -PSMRemoteMachine 'SomeServer'
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Accounts/AdHocConnect"

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected PSMConnectPrerequisites ConnectionComponent for AdHocConnect' {

				$AdHocObj | New-PASPSMSession -ConnectionMethod RDP -PSMRemoteMachine 'SomeServer'
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
					$RequestBody = $Body | ConvertFrom-Json
					$RequestBody.PSMConnectPrerequisites.ConnectionComponent -eq 'SomeConnectionComponent'
				} -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected PSMConnectPrerequisites ConnectionParams for AdHocConnect' {

				$AdHocObj | New-PASPSMSession -ConnectionMethod RDP -PSMRemoteMachine 'SomeServer'
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
					$RequestBody = $Body | ConvertFrom-Json
					$RequestBody.PSMConnectPrerequisites.ConnectionParams.PSMRemoteMachine.value -eq 'SomeServer'
				} -Times 1 -Exactly -Scope It

			}

			It 'throws error if version requirement not met for AdHocConnect' {
				$psPASSession.ExternalVersion = '10.4'
				{ $AdHocObj | New-PASPSMSession -ConnectionMethod PSMGW } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

		#TODO Test RDP/PSMGW Invoke-Item + Related Files

	}

}