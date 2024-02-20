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

			$Parameters = @{Parameter = 'GroupID' },
			@{Parameter = 'Member' }

			It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command Remove-PASGroupMember ).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}

		Context 'Input' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith { }
				$psPASSession.ExternalVersion = '0.0'
			}

			It 'sends request' {
				Remove-PASGroupMember -GroupID X1_Y2 -Member TargetUser
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {
				Remove-PASGroupMember -GroupID X1_Y2 -Member TargetUser
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/UserGroups/X1_Y2/members/TargetUser/"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {
				Remove-PASGroupMember -GroupID X1_Y2 -Member TargetUser
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'DELETE' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {
				Remove-PASGroupMember -GroupID X1_Y2 -Member TargetUser
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '1.2'

				{ Remove-PASGroupMember -GroupID X1_Y2 -Member TargetUser } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

		Context 'Output' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith { }
			}

			It 'provides no output' {
				$response = Remove-PASGroupMember -GroupID X1_Y2 -Member TargetUser
				$response | Should -BeNullOrEmpty

			}

		}

	}

}