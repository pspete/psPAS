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
				Write-Output 'Added'
			}

			$InputObj = [pscustomobject]@{
				'GroupName' = 'SomeGroup'
				'UserName'  = 'SomeUser'

			}

			$InputObjV10 = [pscustomobject]@{
				'memberId'   = 'someName'
				'memberType' = 'domain'
				'domainName' = 'SomeDomain'
				'groupId'    = '1234'

			}
		}
		Context 'Mandatory Parameters' {

			$Parameters = @{Parameter = 'GroupName' },
			@{Parameter = 'UserName' }

			It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command Add-PASGroupMember).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}

		Context 'Input' {

			It 'sends request' {

				$InputObj | Add-PASGroupMember

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				$InputObj | Add-PASGroupMember

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/WebServices/PIMServices.svc/Groups/SomeGroup/Users/"

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint - V10' {

				$InputObjV10 | Add-PASGroupMember

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/UserGroups/$($InputObjV10.groupId)/Members"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				$InputObj | Add-PASGroupMember

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'uses expected method - V10' {

				$InputObjV10 | Add-PASGroupMember

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected body' {

				$InputObj | Add-PASGroupMember

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It 'has a request body with expected number of properties' {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should -Be 1

			}

			It 'sends request with expected body - v10' {

				$InputObjV10 | Add-PASGroupMember

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It 'has a request body with expected number of properties - V10' {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should -Be 3

			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '1.0'

				$psPASSession.ExternalVersion = '1.0'

				{ $InputObjV10 | Add-PASGroupMember } | Should -Throw

				$psPASSession.ExternalVersion = '0.0'

			}

		}

		Context 'Output' {

			It 'provides output' {
				$response = $InputObj | Add-PASGroupMember
				$response | Should -Not -BeNullOrEmpty

			}

		}

	}

}