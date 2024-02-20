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

		Context 'General' {

			BeforeEach {

				$InputObj = [pscustomobject]@{
					'Count'    = 30
					'nextLink' = 'SomeLink'
					'Value'    = @([pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' })
				}

				Mock Invoke-PASRestMethod -MockWith {
					if ($script:iteration -lt 10) {
						[pscustomobject]@{
							'Count'    = 30
							'nextLink' = 'SomeLink'
							'Value'    = @([pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' })
						}
						$script:iteration++
					} else {
						[pscustomobject]@{
							'Count' = 30
							'Value' = @([pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' })
						}
					}
				}
				$script:iteration = 1

			}

			It 'does not throw' {

				{ Get-NextLink } | Should -Not -Throw

			}

			It 'produces no output if given no input' {

				Get-NextLink | Should -BeNullOrEmpty

			}

			It 'processes NextLink' {

				$InputObj | Get-NextLink
				Assert-MockCalled Invoke-PASRestMethod -Times 10 -Exactly -Scope It

			}

			It 'includes SavedFilter in request' {

				$InputObj | Get-NextLink -SavedFilter SomeFilter
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/SomeLink&SavedFilter=SomeFilter"

				} -Times 10 -Exactly -Scope It
			}

			It 'outputs expected number of results' {

				$results = $InputObj | Get-NextLink
				$results.count | Should -Be 99

			}

		}

	}

}