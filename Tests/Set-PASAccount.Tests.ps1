#Get Current Directory
$Here = Split-Path -Parent $MyInvocation.MyCommand.Path

#Get Function Name
$FunctionName = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -Replace ".Tests.ps1"

#Assume ModuleName from Repository Root folder
$ModuleName = Split-Path (Split-Path $Here -Parent) -Leaf

#Resolve Path to Module Directory
$ModulePath = Resolve-Path "$Here\..\$ModuleName"

#Define Path to Module Manifest
$ManifestPath = Join-Path "$ModulePath" "$ModuleName.psd1"

if( -not (Get-Module -Name $ModuleName -All)) {

	Import-Module -Name "$ManifestPath" -ArgumentList $true -Force -ErrorAction Stop

}

BeforeAll {

	$Script:RequestBody = $null

}

AfterAll {

	$Script:RequestBody = $null

}

Describe $FunctionName {

	InModuleScope $ModuleName {

		Context "Mandatory Parameters" {

			$Parameters = @{Parameter = 'BaseURI'},
			@{Parameter = 'SessionToken'},
			@{Parameter = 'AccountID'},
			@{Parameter = 'Folder'},
			@{Parameter = 'AccountName'},
			@{Parameter = 'op'},
			@{Parameter = 'path'},
			@{Parameter = 'operations'}

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command Set-PASAccount).Parameters["$Parameter"].Attributes.Mandatory | Should Be $true

			}

		}

		Context "Input" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {}

				$InputObj = [pscustomobject]@{
					"sessionToken" = @{"Authorization" = "P_AuthValue"}
					"WebSession"   = New-Object Microsoft.PowerShell.Commands.WebRequestSession
					"BaseURI"      = "https://P_URI"
					"PVWAAppName"  = "P_App"
					"AccountID"    = "12_3"
					"Folder"       = "Root"
					"AccountName"  = "Name"
					"Name"         = "SomeName"
					"PolicyID"     = "SomePolicy"
					"Safe"         = "SafeName"
					"Random"       = "Rand"
					"Random1"      = "RandomValue"

				}
				[void]$InputObj.PSObject.TypeNames.Insert(0, "psPAS.CyberArk.Vault.Account")

				$InputObjV10 = [pscustomobject]@{
					"sessionToken" = @{"Authorization" = "P_AuthValue"}
					"WebSession"   = New-Object Microsoft.PowerShell.Commands.WebRequestSession
					"BaseURI"      = "https://P_URI"
					"PVWAAppName"  = "P_App"
					"AccountID"    = "12_3"
				}

				[array]$MultiOps = (
					@{"op" = "add"; "path" = "/addthis"; "value" = "AddValue"},
					@{"op" = "replace"; "path" = "/replace/this/path"; "value" = "ReplaceValue"},
					@{"op" = "remove"; "path" = "/removethispath"}
				)

			}

			It "sends request - V9 ParameterSet" {
				$InputObj | Set-PASAccount -Properties @{"Prop1" = "Val1"; "Prop2" = "Val2"; "Prop3" = "Val3"}
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request - V10SingleOp ParameterSet" {

				$InputObjV10 | Set-PASAccount -op Add -path "/somepath" -value SomeValue
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request - V10MultiOp ParameterSet" {

				$InputObjV10 | Set-PASAccount -operations $MultiOps
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint - V9 ParameterSet" {
				$InputObj | Set-PASAccount -Properties @{"Prop1" = "Val1"; "Prop2" = "Val2"; "Prop3" = "Val3"}
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/WebServices/PIMServices.svc/Accounts/12_3"

				} -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint - V10SingleOp ParameterSet" {
				$InputObjV10 | Set-PASAccount -op Remove -path "/somepath" -value SomeValue
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/api/Accounts/12_3"

				} -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint - V10MultiOp ParameterSet" {
				$InputObjV10 | Set-PASAccount -operations $MultiOps
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/api/Accounts/12_3"

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method - V9 ParameterSet" {
				$InputObj | Set-PASAccount -Properties @{"Prop1" = "Val1"; "Prop2" = "Val2"; "Prop3" = "Val3"}
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Method -match 'PUT' } -Times 1 -Exactly -Scope It

			}

			It "uses expected method - V10SingleOp ParameterSet" {
				$InputObjV10 | Set-PASAccount -op Replace -path "/somepath" -value SomeValue
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Method -match 'PATCH' } -Times 1 -Exactly -Scope It

			}

			It "uses expected method - V10MultiOp ParameterSet" {
				$InputObjV10 | Set-PASAccount -operations $MultiOps
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Method -match 'PATCH' } -Times 1 -Exactly -Scope It

			}

			It "sends request with expected body - V9 ParameterSet" {
				$InputObj | Set-PASAccount -Properties @{"Prop1" = "Val1"; "Prop2" = "Val2"; "Prop3" = "Val3"}
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					($Body | ConvertFrom-Json | select-Object -ExpandProperty Accounts) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It "sends request with expected body - V10SingleOp ParameterSet" {
				$InputObjV10 | Set-PASAccount -op Replace -path "/somepath" -value SomeValue
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					($Body | ConvertFrom-Json) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It "sends request with expected body - V10MultiOp ParameterSet" {
				$InputObjV10 | Set-PASAccount -operations $MultiOps
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					($Body | ConvertFrom-Json) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It "has a request body with expected number of properties - V9 ParameterSet" {
				$InputObj | Set-PASAccount -Properties @{"Prop1" = "Val1"; "Prop2" = "Val2"; "Prop3" = "Val3"}
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					($Body | ConvertFrom-Json | select-Object -ExpandProperty Accounts | Get-Member -MemberType NoteProperty).length -eq 4

				} -Times 1 -Exactly -Scope It
			}

			It "has a request body with expected number of properties - V10SingleOp ParameterSet" {
				$InputObjV10 | Set-PASAccount -op Replace -path "/somepath" -value SomeValue
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					(($Body | ConvertFrom-Json)[0] | Get-Member -MemberType NoteProperty).length -eq 3

				} -Times 1 -Exactly -Scope It
			}

			It "has a request body with expected number of properties - V10MultiOp ParameterSet" {
				$InputObjV10 | Set-PASAccount -operations $MultiOps
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					(($Body | ConvertFrom-Json)[0] | Get-Member -MemberType NoteProperty).length -eq 3
					(($Body | ConvertFrom-Json)[1] | Get-Member -MemberType NoteProperty).length -eq 3
					(($Body | ConvertFrom-Json)[2] | Get-Member -MemberType NoteProperty).length -eq 3

				} -Times 1 -Exactly -Scope It
			}

			It "has a request body with expected number of nested properties - V9 ParameterSet" {

				$InputObj | Set-PASAccount -Properties @{"Prop1" = "Val1"; "Prop2" = "Val2"; "Prop3" = "Val3"}

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					($Body | ConvertFrom-Json | select-Object -ExpandProperty Accounts | Select-Object -ExpandProperty Properties).count -eq 5


				} -Times 1 -Exactly -Scope It

			}

			It "throws error if version requirement not met" {

				{$InputObjV10 | Set-PASAccount -op Replace -path "/somepath" -value SomeValue -ExternalVersion 1.2} | Should throw

			}

		}

		Context "Output" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[pscustomobject]@{
						"UpdateAccountResult" = [pscustomobject]@{
							"Prop1" = "Value1"
							"Prop2" = "Value2"
							"Prop3" = "Value3"
							"Prop4" = "Value4"
						}
					}
				}

				$InputObj = [pscustomobject]@{
					"sessionToken" = @{"Authorization" = "P_AuthValue"}
					"WebSession"   = New-Object Microsoft.PowerShell.Commands.WebRequestSession
					"BaseURI"      = "https://P_URI"
					"PVWAAppName"  = "P_App"
					"AccountID"    = "12_3"
					"Folder"       = "Root"
					"AccountName"  = "Name"
					"Name"         = "SomeName"
					"PolicyID"     = "SomePolicy"
					"Safe"         = "SafeName"
					"Random"       = "Rand"
					"Random1"      = "RandomValue"

				}
				[void]$InputObj.PSObject.TypeNames.Insert(0, "psPAS.CyberArk.Vault.Account")

				$InputObjV10 = [pscustomobject]@{
					"sessionToken" = @{"Authorization" = "P_AuthValue"}
					"WebSession"   = New-Object Microsoft.PowerShell.Commands.WebRequestSession
					"BaseURI"      = "https://P_URI"
					"PVWAAppName"  = "P_App"
					"AccountID"    = "12_3"
				}

			}

			it "provides output - V9 ParameterSet" {
				$response = $InputObj | Set-PASAccount -Properties @{"Prop1" = "Val1"; "Prop2" = "Val2"; "Prop3" = "Val3"}
				$response | Should not BeNullOrEmpty

			}

			it "provides output - V10 ParameterSet" {
				$response = $InputObjV10 | Set-PASAccount -op Replace -path "/somepath" -value SomeValue
				$response | Should not BeNullOrEmpty

			}

			It "has output with expected number of properties - V9 ParameterSet" {
				$response = $InputObj | Set-PASAccount -Properties @{"Prop1" = "Val1"; "Prop2" = "Val2"; "Prop3" = "Val3"}
				($response | Get-Member -MemberType NoteProperty).length | Should Be 10

			}

			It "has output with expected number of properties - V10 ParameterSet" {
				$response = $InputObjV10 | Set-PASAccount -op Replace -path "/somepath" -value SomeValue
				($response | Get-Member -MemberType NoteProperty).length | Should Be 7

			}

			it "outputs object with expected typename - V9 ParameterSet" {
				$response = $InputObj | Set-PASAccount -Properties @{"Prop1" = "Val1"; "Prop2" = "Val2"; "Prop3" = "Val3"}
				$response | get-member | select-object -expandproperty typename -Unique | Should Be psPAS.CyberArk.Vault.Account

			}

			it "outputs object with expected typename - V10 ParameterSet" {
				$response = $InputObjV10 | Set-PASAccount -op Replace -path "/somepath" -value SomeValue
				$response | get-member | select-object -expandproperty typename -Unique | Should Be psPAS.CyberArk.Vault.Account.V10

			}

			$DefaultProps = @{Property = 'sessionToken'},
			@{Property = 'WebSession'},
			@{Property = 'BaseURI'},
			@{Property = 'PVWAAppName'},
			@{Property = 'AccountID'},
			@{Property = 'ExternalVersion'}


			It "returns default property <Property> in response" -TestCases $DefaultProps {
				param($Property)
				($InputObj | Set-PASAccount -Properties @{"Prop1" = "Val1"; "Prop2" = "Val2"; "Prop3" = "Val3"}).$Property | Should Not BeNullOrEmpty

			}

		}

	}

}