Describe $($PSCommandPath -replace '.Tests.ps1') {

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

			$Parameters = @{Parameter = 'id' }

			It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command Set-PASReportTask).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}

		Context 'Input' {

			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{'Prop1' = 'VAL1'; 'Prop2' = 'Val2' }
				}

				Mock Get-PASReportTask -MockWith {
					[PSCustomObject]@{
						id                 = 'SomeTaskID'
						folder             = 'SomeFolder'
						type               = 'Report'
						subType            = 'InventoryReports.InventoryReportUI'
						name               = 'OldName'
						keepTaskDefinition = $true
						notifyOnFailure    = $true
						schedule           = [PSCustomObject]@{
							lastGenerationDate = $null
							startTime          = '2025-01-01T02:00:00+02:00'
							recurrence         = [PSCustomObject]@{
								type            = 'Weekly'
								recurrenceValue = 1
								daysOfWeek      = @('Monday', 'Wednesday', 'Friday')
								weekNumber      = 'First'
							}
						}
						subscribers        = @(
							[PSCustomObject]@{ name = 'user1'; type = 'User'; notifyOnSuccess = $true }
						)
						filters            = @(
							[PSCustomObject]@{ name = 'safe'; value = '\\' }
						)
						createdAt          = '2025-01-01T00:00:00Z'
						createdBy          = 'admin'
						lastModifiedAt     = '2025-01-01T00:00:00Z'
						lastModifiedBy     = 'admin'
					}
				}

				$InputObj = [pscustomobject]@{
					'id' = 'SomeTaskID'
				}

				$Script:psPASSession.BaseURI = 'https://SomeURL/SomeApp'
				$psPASSession.ExternalVersion = '0.0'
				$psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			}

			It 'sends request' {

				$InputObj | Set-PASReportTask
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				$InputObj | Set-PASReportTask

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Tasks/SomeTaskID"

				} -Times 1 -Exactly -Scope It

			}

			It 'escapes the id value in the URL' {

				[pscustomobject]@{'id' = 'Some Task ID' } | Set-PASReportTask

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Tasks/Some%20Task%20ID"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				$InputObj | Set-PASReportTask

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected body' {

				$InputObj | Set-PASReportTask

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It 'merges existing task properties into the request body' {

				$InputObj | Set-PASReportTask

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody.type -eq 'Report') -and
					($Script:RequestBody.subType -eq 'InventoryReports.InventoryReportUI') -and
					($Script:RequestBody.name -eq 'OldName') -and
					($Script:RequestBody.keepTaskDefinition -eq $true) -and
					($Script:RequestBody.schedule.recurrence.type -eq 'Weekly')

				} -Times 1 -Exactly -Scope It

			}

			It 'removes read-only properties from the request body' {

				$InputObj | Set-PASReportTask

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody.PSObject.Properties.Name -notcontains 'id') -and
					($Script:RequestBody.PSObject.Properties.Name -notcontains 'folder') -and
					($Script:RequestBody.PSObject.Properties.Name -notcontains 'createdAt') -and
					($Script:RequestBody.PSObject.Properties.Name -notcontains 'createdBy') -and
					($Script:RequestBody.PSObject.Properties.Name -notcontains 'lastModifiedAt') -and
					($Script:RequestBody.PSObject.Properties.Name -notcontains 'lastModifiedBy')

				} -Times 1 -Exactly -Scope It

			}

			It 'updates name when supplied' {

				$InputObj | Set-PASReportTask -name 'NewName'

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					$Script:RequestBody.name -eq 'NewName'

				} -Times 1 -Exactly -Scope It

			}

			It 'retains nested collection properties in the request body' {

				$InputObj | Set-PASReportTask

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody.subscribers[0].name -eq 'user1') -and
					($Script:RequestBody.subscribers[0].notifyOnSuccess -eq $true) -and
					($Script:RequestBody.filters[0].name -eq 'safe')

				} -Times 1 -Exactly -Scope It

			}

			It 'retains the existing schedule when no schedule parameters are supplied' {

				$InputObj | Set-PASReportTask -name 'NewName'

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Body -match '"startTime":\s+"2025-01-01T02:00:00\+02:00"') -and
					($Script:RequestBody.schedule.recurrence.type -eq 'Weekly') -and
					($Script:RequestBody.schedule.recurrence.recurrenceValue -eq 1) -and
					($Script:RequestBody.schedule.recurrence.weekNumber -eq 'First') -and
					(-not (Compare-Object $Script:RequestBody.schedule.recurrence.daysOfWeek @('Monday', 'Wednesday', 'Friday')))

				} -Times 1 -Exactly -Scope It

			}

			It 'updates schedule values when supplied, retaining those which are not' {

				$InputObj | Set-PASReportTask -recurrenceType Monthly -daysOfWeek '2,4'

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody.schedule.recurrence.type -eq 'Monthly') -and
					(-not (Compare-Object $Script:RequestBody.schedule.recurrence.daysOfWeek @(2, 4))) -and
					($Body -match '"startTime":\s+"2025-01-01T02:00:00\+02:00"') -and
					($Script:RequestBody.schedule.recurrence.recurrenceValue -eq 1)

				} -Times 1 -Exactly -Scope It

			}

			It 'sends startTime in expected format when supplied' {

				$InputObj | Set-PASReportTask -startTime $(Get-Date '2026-05-06 03:04:05')

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Body -match '"startTime":\s+"2026-05-06T03:04:05.0000000Z"'

				} -Times 1 -Exactly -Scope It

			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '9.8'
				{ $InputObj | Set-PASReportTask } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

			It 'throws error if task is not found' {
				Mock Get-PASReportTask -MockWith { $null }
				{ Set-PASReportTask -id 'MissingID' } | Should -Throw
			}

		}

		Context 'Output' {

			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{
						id   = 'SomeTaskID'
						name = 'UpdatedName'
					}
				}

				Mock Get-PASReportTask -MockWith {
					[PSCustomObject]@{
						id   = 'SomeTaskID'
						name = 'OldName'
					}
				}

				$Script:psPASSession.BaseURI = 'https://SomeURL/SomeApp'
				$psPASSession.ExternalVersion = '0.0'
				$psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			}

			It 'provides output' {

				$response = Set-PASReportTask -id 'SomeTaskID'
				$response | Should -Not -BeNullOrEmpty

			}

			It 'outputs object with expected typename' {

				$response = Set-PASReportTask -id 'SomeTaskID'
				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Task

			}

		}

	}

}
