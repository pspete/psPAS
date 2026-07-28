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

		Context 'Input - Legacy' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {

					[PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2'; 'Prop3' = 123 }

				}

				Mock Add-ObjectDetail -MockWith {}

				$InputObj = [pscustomobject]@{
					'Name' = 'SomeName'

				}

				$response = $InputObj | Get-PASPlatform -Verbose

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Platforms/SomeName/"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '1.0'
				{ $InputObj | Get-PASPlatform } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

		Context 'Input - 11.4' {
			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {

					[PSCustomObject]@{
						'Platforms' = [PSCustomObject]@{
							'Prop1' = 'Val1'; 'Prop2' = 'Val2'; 'Prop3' = 123
						}
					}

				}

				Mock Add-ObjectDetail -MockWith {}

				Get-PASPlatform

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 2 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 2 -Exactly -Scope It

			}

			It 'sends request to expected endpoint - target' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Platforms/targets"

				} -Scope It -Times 1 -Exactly

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Platforms?PlatformType=Regular"

				} -Scope It -Times 1 -Exactly

			}

			It 'sends request to expected endpoint - dependent' {

				Get-PASPlatform -DependentPlatform

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Platforms/dependents"

				} -Scope It

			}

			It 'sends request to expected endpoint - group' {

				Get-PASPlatform -GroupPlatform

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Platforms/groups"

				} -Scope It -Times 1 -Exactly

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Platforms?PlatformType=Group"

				} -Scope It -Times 1 -Exactly

			}

			It 'sends request to expected endpoint - rotational group' {

				Get-PASPlatform -RotationalGroup

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Platforms/rotationalGroups"

				} -Scope It

			}

			It 'sends request with no body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 2 -Exactly -Scope It

			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '11.3'
				{ Get-PASPlatform } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

		Context 'Input - target-details (15.2)' {

			BeforeEach {

				$psPASSession.ExternalVersion = '15.2'

				Mock Invoke-PASRestMethod -MockWith {

					[PSCustomObject]@{
						'general' = [PSCustomObject]@{
							'name' = [PSCustomObject]@{
								'value'      = 'SomePlatform'
								'description' = ''
								'isDefault'  = $false
								'isReadOnly' = $true
							}
						}
					}

				}

				Mock Add-ObjectDetail -MockWith {}

				Get-PASPlatform -ID 123

			}

			AfterEach {

				$psPASSession.ExternalVersion = '0.0'

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Platforms/targets/123/settings"

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint - with scope' {

				Get-PASPlatform -ID 123 -Scope 'policy/general'

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Platforms/targets/123/settings?scope=policy%2Fgeneral"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '15.1'
				{ Get-PASPlatform -ID 123 } | Should -Throw
			}

			It 'throws error if not self-hosted' {
				$psPASSession.BaseURI = 'https://SomeURL.cyberark.cloud'
				{ Get-PASPlatform -ID 123 } | Should -Throw
				$psPASSession.BaseURI = 'https://SomeURL/SomeApp'
			}

			It 'flattens settings without error when a section contains an array value' {

				#Regression test: array-valued sections (e.g. additionalPolicySettings/linkedAccounts)
				#must not be treated as objects to recurse into - .NET arrays expose a self-referencing
				#SyncRoot property which previously caused unbounded recursion (CallDepthOverflow)
				Mock Invoke-PASRestMethod -MockWith {

					[PSCustomObject]@{
						'general' = [PSCustomObject]@{
							'name' = [PSCustomObject]@{ 'value' = 'SomePlatform'; 'description' = ''; 'isDefault' = $false; 'isReadOnly' = $true }
						}
						'policy'  = [PSCustomObject]@{
							'additionalPolicySettings' = [PSCustomObject]@{
								'customParameters' = @(
									[PSCustomObject]@{
										'name'  = [PSCustomObject]@{ 'value' = 'Param1'; 'description' = ''; 'isDefault' = $false; 'isReadOnly' = $false }
										'value' = [PSCustomObject]@{ 'value' = 'Val1'; 'description' = ''; 'isDefault' = $false; 'isReadOnly' = $false }
									},
									[PSCustomObject]@{
										'name'  = [PSCustomObject]@{ 'value' = 'Param2'; 'description' = ''; 'isDefault' = $false; 'isReadOnly' = $false }
										'value' = [PSCustomObject]@{ 'value' = 'Val2'; 'description' = ''; 'isDefault' = $false; 'isReadOnly' = $false }
									}
								)
							}
						}
					}

				}

				Mock Add-ObjectDetail -MockWith { $InputObject }

				$result = Get-PASPlatform -ID 123

				$result.general.name | Should -Be 'SomePlatform'
				$result.policy.additionalPolicySettings.customParameters.Count | Should -Be 2
				$result.policy.additionalPolicySettings.customParameters[0].name | Should -Be 'Param1'
				$result.policy.additionalPolicySettings.customParameters[1].value | Should -Be 'Val2'

			}

			It 'flattens settings without error when a section contains a null or scalar value' {

				#Regression test: not every settings property is wrapped in a {value, isReadOnly} object -
				#null sections and raw scalar values must be passed through as-is rather than recursed into.
				Mock Invoke-PASRestMethod -MockWith {

					[PSCustomObject]@{
						'general' = [PSCustomObject]@{
							'name'         = [PSCustomObject]@{ 'value' = 'SomePlatform'; 'description' = ''; 'isDefault' = $false; 'isReadOnly' = $true }
							'emptySection' = $null
							'rawScalar'    = 'JustAString'
						}
					}

				}

				Mock Add-ObjectDetail -MockWith { $InputObject }

				$result = Get-PASPlatform -ID 123

				$result.general.name | Should -Be 'SomePlatform'
				$result.general.emptySection | Should -BeNullOrEmpty
				$result.general.rawScalar | Should -Be 'JustAString'

			}

			It 'provides tab completion for the Scope parameter using values from the API' {

				#Regression test: the completer scriptblock is invoked by the completion engine
				#outside of the module's own session state, so it must not rely on module-private
				#commands (e.g. Invoke-PASRestMethod) being directly resolvable from within it.
				Mock Get-PASPlatformTargetScope -MockWith {
					@('general', 'policy', 'policy/general', 'policy/cpmPlugin', 'policy/additionalPolicySettings')
				}

				$Completer = (Get-Command Get-PASPlatform).Parameters['Scope'].Attributes |
					Where-Object { $PSItem -is [System.Management.Automation.ArgumentCompleterAttribute] }

				$CompletionResults = & $Completer.ScriptBlock 'Get-PASPlatform' 'Scope' 'policy/c' $null @{ ID = 123 }

				$CompletionResults.CompletionText | Should -Be 'policy/cpmPlugin'

			}

		}

		Context 'Output Formatting' {

			BeforeEach {

				Mock Add-ObjectDetail -MockWith {
					param($InputObject, $typename)
					$InputObject | ForEach-Object {
						if ($typename) { $_.PSObject.TypeNames.Insert(0, $typename) }
						$_
					}
				}

			}

			It 'sets typename to Basic when Total is 0' {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{ Total = 0; Platforms = @([PSCustomObject]@{PlatformID = 'Plat1' }) }
				}

				$result = Get-PASPlatform

				$result | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be 'psPAS.CyberArk.Vault.Platform.Basic'

			}

			$TypeNameCases = @{Switch = @{ }; Expected = 'psPAS.CyberArk.Vault.Platform.Targets' },
			@{Switch = @{GroupPlatform = $true }; Expected = 'psPAS.CyberArk.Vault.Platform.Groups' },
			@{Switch = @{DependentPlatform = $true }; Expected = 'psPAS.CyberArk.Vault.Platform.Dependents' },
			@{Switch = @{RotationalGroup = $true }; Expected = 'psPAS.CyberArk.Vault.Platform.RotationalGroups' }

			It 'sets typename to <Expected> when Total is greater than 0' -TestCases $TypeNameCases {

				param($Switch, $Expected)

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{ Total = 1; Platforms = @([PSCustomObject]@{PlatformID = 'Plat1' }) }
				}

				$result = Get-PASPlatform @Switch

				$result | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be $Expected

			}

			It 'flattens the Details property and sets expected typename for a single platform response' {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{
						'PlatformID' = 'SomePlatform'
						'Details'    = [PSCustomObject]@{ 'Prop1' = 'Val1' }
					}
				}

				$result = Get-PASPlatform -Name 'SomePlatform'

				$result.PlatformID | Should -Be 'SomePlatform'
				$result.Prop1 | Should -Be 'Val1'
				$result.PSObject.Properties.Name | Should -Not -Contain 'Details'
				$result | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be 'psPAS.CyberArk.Vault.Platform.Details'

			}

			It 'includes filter and search parameters in a targets request' {

				Mock Invoke-PASRestMethod -MockWith { [PSCustomObject]@{ Total = 0; Platforms = @() } }

				Get-PASPlatform -Active $true -Search 'foo'

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					($URI -match 'search=foo') -and ($URI -match 'filter=Active')

				} -Scope It

			}

			It 'includes the search parameter in a group platforms request' {

				Mock Invoke-PASRestMethod -MockWith { [PSCustomObject]@{ Total = 0; Platforms = @() } }

				Get-PASPlatform -GroupPlatform -Search 'foo'

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -match 'search=foo'

				} -Scope It

			}

		}

	}

}