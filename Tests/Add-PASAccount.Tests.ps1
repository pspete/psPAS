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

			$Parameters = @{Parameter = 'password' }

			It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command Add-PASAccount).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

			It 'specifies parameter userName as mandatory for ParameterSet Gen1' {

				(Get-Command Add-PASAccount).Parameters['UserName'].ParameterSets['Gen1'].IsMandatory | Should -Be $true

			}
			It 'specifies parameter SafeName as mandatory for ParameterSet Gen1' {

				(Get-Command Add-PASAccount).Parameters['SafeName'].ParameterSets['Gen1'].IsMandatory | Should -Be $true

			}
			It 'specifies parameter SafeName as mandatory for ParameterSet Gen2' {

				(Get-Command Add-PASAccount).Parameters['SafeName'].ParameterSets['Gen2'].IsMandatory | Should -Be $true

			}
			It 'specifies parameter platformID as mandatory for ParameterSet Gen1' {

				(Get-Command Add-PASAccount).Parameters['platformID'].ParameterSets['Gen1'].IsMandatory | Should -Be $true

			}
			It 'specifies parameter platformID as mandatory for ParameterSet Gen2' {

				(Get-Command Add-PASAccount).Parameters['platformID'].ParameterSets['Gen2'].IsMandatory | Should -Be $true

			}

		}

		Context 'Input' {

			BeforeEach {

				$secureString = $('P_Password' | ConvertTo-SecureString -AsPlainText -Force)
				Mock Invoke-PASRestMethod -MockWith {
					Write-Output @{ }
				}

				$InputObj = [pscustomobject]@{
					'safeName'              = 'P_Safe'
					'platformID'            = 'P_Platform'
					'password'              = $secureString
					'userName'              = 'P_UserName'
					'Port'                  = 1234
					'ExtraPass1Name'        = 'P_ExtP1'
					'DynamicProperties'     = @{'TestKey' = 'TestVal'; 'TestKey1' = 'TestVal'; 'TestKey2' = 'TestVal' }
					'address'               = '10.10.10.10'
					'accountName'           = 'SomeName'
					'disableAutoMgmt'       = $true
					'disableAutoMgmtReason' = 'SomeReason'
					'groupName'             = 'SomeGroup'
					'groupPlatformID'       = 'GPlatform'
					'ExtraPass1Folder'      = 'Root'
					'ExtraPass1Safe'        = 'Safe1'
					'ExtraPass3Name'        = 'SomeName'
					'ExtraPass3Folder'      = 'Root'
					'ExtraPass3Safe'        = 'SomeSafe'
				}

				$InputObjV10 = [pscustomobject]@{
					'address'                          = 'someaddress'
					'SafeName'                         = 'SomeSafe'
					'PlatformID'                       = 'SomePlatform'
					'userName'                         = 'SomeUser'
					'secret'                           = $secureString
					'automaticManagementEnabled'       = $true
					'remoteMachines'                   = 'someMachine'
					'accessRestrictedToRemoteMachines' = $false
				}
				$psPASSession.ExternalVersion = '0.0'

			}

			It 'sends request' {

				$InputObj | Add-PASAccount

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint - V9 ParameterSet' {

				$InputObj | Add-PASAccount

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/WebServices/PIMServices.svc/Account"

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint - V10 ParameterSet' {

				$InputObjV10 | Add-PASAccount

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/Accounts"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				$InputObj | Add-PASAccount

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected body - V9 ParameterSet' {

				$InputObj | Add-PASAccount

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					($Body | ConvertFrom-Json | Select-Object -ExpandProperty Account) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It 'has a request body with expected number of properties - V9 ParameterSet' {

				$InputObj | Add-PASAccount

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
					($Body | ConvertFrom-Json | Select-Object -ExpandProperty Account | Get-Member -MemberType NoteProperty).length -eq 11
				} -Times 1 -Exactly -Scope It
			}

			It 'has expected number of nested properties - V9 ParameterSet' {
				$InputObj | Add-PASAccount

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					($Body | ConvertFrom-Json | Select-Object -ExpandProperty Account | Select-Object -ExpandProperty Properties).count -eq 10

				} -Times 1 -Exactly -Scope It
			}

			It 'sends request with expected body - V10 ParameterSet' {

				$InputObjV10 | Add-PASAccount

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					($Body | ConvertFrom-Json) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It 'has a request body with expected number of properties - V10 ParameterSet' {

				$InputObjV10 | Add-PASAccount

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
					($Body | ConvertFrom-Json | Get-Member -MemberType NoteProperty).length -eq 7
				} -Times 1 -Exactly -Scope It

			}

			It 'has expected number of RemoteMachine nested properties - V10 ParameterSet' {
				$InputObjV10 | Add-PASAccount

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					($Body | ConvertFrom-Json | Select-Object -ExpandProperty remoteMachinesAccess | Get-Member -MemberType NoteProperty).length -eq 2

				} -Times 1 -Exactly -Scope It

			}

			It 'has expected number of secretManagement nested properties - V10 ParameterSet' {

				$InputObjV10 | Add-PASAccount

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					($Body | ConvertFrom-Json | Select-Object -ExpandProperty secretManagement | Get-Member -MemberType NoteProperty).length -eq 1

				} -Times 1 -Exactly -Scope It

			}

			It 'throws error if version requirement not met' {

				$psPASSession.ExternalVersion = '1.0'
				{ $InputObjV10 | Add-PASAccount } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'

			}

		}

		Context 'Output' {

			BeforeEach {

				$secureString = $('P_Password' | ConvertTo-SecureString -AsPlainText -Force)
				Mock Invoke-PASRestMethod -MockWith {
					$result = [pscustomobject]@{
						'Prop1' = 'Val1'
						'Prop2' = 'Val2'
						'Prop3' = 'Val3'
					}

					$result
				}

				$InputObj = [pscustomobject]@{
					'address'                    = 'someaddress'
					'SafeName'                   = 'SomeSafe'
					'PlatformID'                 = 'SomePlatform'
					'userName'                   = 'SomeUser'
					'secret'                     = $secureString
					'automaticManagementEnabled' = $true
					'remoteMachines'             = 'someMachine'
				}
				$psPASSession.ExternalVersion = '0.0'

			}

			It 'provides no output - V9 ParameterSet' {

				$InputObj = [pscustomobject]@{
					'safeName'              = 'P_Safe'
					'platformID'            = 'P_Platform'
					'password'              = $secureString
					'userName'              = 'P_UserName'
					'Port'                  = 1234
					'ExtraPass1Name'        = 'P_ExtP1'
					'DynamicProperties'     = @{'TestKey' = 'TestVal'; 'TestKey1' = 'TestVal'; 'TestKey2' = 'TestVal' }
					'address'               = '10.10.10.10'
					'accountName'           = 'SomeName'
					'disableAutoMgmt'       = $true
					'disableAutoMgmtReason' = 'SomeReason'
					'groupName'             = 'SomeGroup'
					'groupPlatformID'       = 'GPlatform'
					'ExtraPass1Folder'      = 'Root'
					'ExtraPass1Safe'        = 'Safe1'
					'ExtraPass3Name'        = 'SomeName'
					'ExtraPass3Folder'      = 'Root'
					'ExtraPass3Safe'        = 'SomeSafe'
				}
				$response = $InputObj | Add-PASAccount
				$response | Should -BeNullOrEmpty

			}

			It 'provides output - V10 ParameterSet' {
				$response = $InputObj | Add-PASAccount
				$response | Should -Not -BeNullOrEmpty

			}

			It 'outputs object with expected typename - v10 parameterset' {
				Mock Invoke-PASRestMethod -MockWith {
					[pscustomobject]@{
						'Count' = 30
						'Value' = [pscustomobject]@{'Prop1' = 'Val1' }
					}
				}
				$response = $InputObj | Add-PASAccount
				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Account.V10

			}



		}
		#>
	}



}