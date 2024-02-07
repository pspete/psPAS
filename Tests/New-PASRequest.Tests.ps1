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
		BeforeEach {
			Mock Invoke-PASRestMethod -MockWith {
				[PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'val2'; 'PropA' = 'ValA'; 'PropB' = 'ValB'; 'PropC' = 'ValC' }
			}

			$InputObj = [pscustomobject]@{
				'AccountID'              = 'SomeID'
				'Reason'                 =	'Some Important Reason'
				'TicketingSystemName'    = 'SomeName'
				'TicketID'               = 'TicketID123'
				'MultipleAccessRequired' = $true
				'FromDate'               = (Get-Date 1-1-2018)
				'ToDate'                 = (Get-Date 12-12-2018)
				'PSMRemoteMachine'       = 'SomeMachine'
			}

			$response = $InputObj | New-PASRequest

		}

		Context 'Mandatory Parameters' {

			$Parameters = @{Parameter = 'AccountID' }

			It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command New-PASRequest).Parameters["$Parameter"].Attributes.Mandatory | Select-Object -Unique | Should -Be $true

			}

		}

		Context 'Input' {

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/MyRequests"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It 'has a request body with expected number of properties' {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should -Be 8

			}

			It "converts datetime 'FromDate' to expected value" {

				$Script:RequestBody.FromDate | Should -Be 1514764800

			}

			It "converts datetime 'ToDate' to expected value" {

				$Script:RequestBody.ToDate | Should -Be 1544572800

			}

			It 'has a request body with expected ConnectionParams' {

				$Script:RequestBody.ConnectionParams.PSMRemoteMachine.Value | Should -Be 'SomeMachine'

			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '1.0'
				{ $InputObj | New-PASRequest } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

			It 'has request body with expected BulkItems property' {
				$Requests = $InputObj | New-PASRequestObject
				New-PASRequest -BulkItems $Requests

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody).BulkItems -ne $null

				} -Times 1 -Exactly -Scope It


			}

			It 'has BulkItems property with expected format' {

				$Script:RequestBody.BulkItems.Operation | Should -Be 'Add'

			}

			It 'has request body with expected SearchParam' {

				New-PASRequest -Search SomeSearchTerm

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody).BulkFilter -ne $null

				} -Times 1 -Exactly -Scope It
			}

			It 'has FilterParams property with expected format' {
				$Script:RequestBody.BulkFilter.FilterParams.SearchParam.Search | Should -Be 'SomeSearchTerm'
			}

			It 'has request body with expected AccountsFilters' {

				New-PASRequest -SavedFilter Favorites

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody).BulkFilter -ne $null

				} -Times 1 -Exactly -Scope It
			}

			It 'has FilterParams property with expected format' {
				$Script:RequestBody.BulkFilter.FilterParams.AccountsFilters.SavedFilter | Should -Be 'Favorites'
			}

		}

		Context 'Output' {

			It 'provides output' {

				$response | Should -Not -BeNullOrEmpty

			}

			It 'has output with expected number of properties' {

				($response | Get-Member -MemberType NoteProperty).length | Should -Be 5

			}

			It 'outputs object with expected typename' {

				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Request

			}



		}

	}

}