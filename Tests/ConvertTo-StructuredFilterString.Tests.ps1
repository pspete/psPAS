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

			It 'does not throw' {

				{ ConvertTo-StructuredFilterString } | Should -Not -Throw

			}

			It 'produces no output if given no input' {

				ConvertTo-StructuredFilterString | Should -BeNullOrEmpty

			}

			It 'defaults to the EQ operator for a plain scalar value' {

				$Value = @{status = 'Done' } | ConvertTo-StructuredFilterString

				$Value['filter'] | Should -Be 'status EQ Done'

			}

			It 'leaves values with no whitespace unquoted by default' {

				$Value = @{age = 5 } | ConvertTo-StructuredFilterString

				$Value['filter'] | Should -Be 'age EQ 5'

			}

			It 'quotes values containing whitespace automatically' {

				$Value = @{name = 'John Smith' } | ConvertTo-StructuredFilterString

				$Value['filter'] | Should -Be 'name EQ "John Smith"'

			}

			It 'quotes values with no whitespace when QuoteValue is specified' {

				$Value = @{status = 'Done' } | ConvertTo-StructuredFilterString -QuoteValue

				$Value['filter'] | Should -Be 'status EQ "Done"'

			}

			It 'joins multiple key/value pairs with AND by default' {

				$Value = @{status = 'Done'; safe = 'Prod' } | ConvertTo-StructuredFilterString

				$Value['filter'] | Should -Match 'status EQ Done'
				$Value['filter'] | Should -Match 'safe EQ Prod'
				$Value['filter'] | Should -Match ' AND '

			}

			It 'joins multiple key/value pairs with OR when specified' {

				$Value = @{status = 'Done'; safe = 'Prod' } | ConvertTo-StructuredFilterString -LogicalOperator OR

				$Value['filter'] | Should -Match ' OR '
				$Value['filter'] | Should -Not -Match ' AND '

			}

		}

		Context 'Operator prefix parsing' {

			It 'parses the <Prefix> operator prefix' -TestCases @(
				@{Prefix = 'NE'; Expected = 'status NE Done' }
				@{Prefix = 'GT'; Expected = 'status GT Done' }
				@{Prefix = 'GE'; Expected = 'status GE Done' }
				@{Prefix = 'LT'; Expected = 'status LT Done' }
				@{Prefix = 'LE'; Expected = 'status LE Done' }
				@{Prefix = 'CONTAINS'; Expected = 'status CONTAINS Done' }
				@{Prefix = 'NOTCONTAINS'; Expected = 'status NOTCONTAINS Done' }
				@{Prefix = 'STARTSWITH'; Expected = 'status STARTSWITH Done' }
				@{Prefix = 'ENDSWITH'; Expected = 'status ENDSWITH Done' }
			) {

				param($Prefix, $Expected)

				$Value = @{status = "$Prefix Done" } | ConvertTo-StructuredFilterString

				$Value['filter'] | Should -Be $Expected

			}

			It 'parses the operator prefix case-insensitively' {

				$Value = @{status = 'ne Done' } | ConvertTo-StructuredFilterString

				$Value['filter'] | Should -Be 'status NE Done'

			}

			It 'parses IS NULL with no operand' {

				$Value = @{description = 'IS NULL' } | ConvertTo-StructuredFilterString

				$Value['filter'] | Should -Be 'description IS NULL'

			}

			It 'parses IS NOTNULL with no operand' {

				$Value = @{description = 'IS NOTNULL' } | ConvertTo-StructuredFilterString

				$Value['filter'] | Should -Be 'description IS NOTNULL'

			}

		}

		Context 'IN / NOTIN handling' {

			It 'treats an array value as an implicit IN list' {

				$Value = @{safe = 'Safe1', 'Safe2' } | ConvertTo-StructuredFilterString

				$Value['filter'] | Should -Be 'safe IN Safe1,Safe2'

			}

			It 'parses a comma separated IN prefix value' {

				$Value = @{safe = 'IN Safe1,Safe2' } | ConvertTo-StructuredFilterString

				$Value['filter'] | Should -Be 'safe IN Safe1,Safe2'

			}

			It 'parses a comma separated NOTIN prefix value' {

				$Value = @{safe = 'NOTIN Safe1,Safe2' } | ConvertTo-StructuredFilterString

				$Value['filter'] | Should -Be 'safe NOTIN Safe1,Safe2'

			}

			It 'quotes individual list values containing whitespace' {

				$Value = @{safe = 'IN Safe One,Safe2' } | ConvertTo-StructuredFilterString

				$Value['filter'] | Should -Be 'safe IN "Safe One",Safe2'

			}

		}

		Context 'DateTime handling' {

			It 'converts a DateTime value to unix time, defaulting to EQ' {

				$Value = @{modificationTime = $(Get-Date 1/1/2020) } | ConvertTo-StructuredFilterString

				$Value['filter'] | Should -Be 'modificationTime EQ 1577836800'

			}

		}

	}

}
