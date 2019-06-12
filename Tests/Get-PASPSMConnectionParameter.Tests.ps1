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

if ( -not (Get-Module -Name $ModuleName -All)) {

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

			$Parameters = @{Parameter = 'AccountID' },
			@{Parameter = 'ConnectionComponent' }

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command Get-PASPSMConnectionParameter).Parameters["$Parameter"].Attributes.Mandatory | Select-Object -Unique | Should Be $true

			}

		}

		Context "Input" {

			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{"Prop1" = "VAL1"; "Prop2" = "Val2"; "Prop3" = "Val3" }
				}

				$InputObj = [pscustomobject]@{

					"AccountID"           = "99_9"
					"ConnectionComponent" = "SomeConnectionComponent"

				}

				$AdHocObj = [pscustomobject]@{
					"ConnectionComponent" = "SomeConnectionComponent"
					"UserName"            = "SomeUser"
					"secret"              = "SomeSecret" | ConvertTo-SecureString -AsPlainText -Force
					"address"             = "Some.Address"
					"platformID"          = "SomePlatform"

				}

				$Script:BaseURI = "https://SomeURL/SomeApp"
				$Script:ExternalVersion = "0.0"
				$Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			}

			It "sends request" {

				$InputObj | Get-PASPSMConnectionParameter -ConnectionMethod RDP

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint for PSMConnect" {

				$InputObj | Get-PASPSMConnectionParameter -ConnectionMethod RDP

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/API/Accounts/99_9/PSMConnect"

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {

				$InputObj | Get-PASPSMConnectionParameter -ConnectionMethod RDP

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It "sends request with expected body" {

				$InputObj | Get-PASPSMConnectionParameter -ConnectionMethod RDP

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It "has a request body with expected number of properties" {

				$InputObj | Get-PASPSMConnectionParameter -ConnectionMethod RDP

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should Be 1

			}

			It "has expected Accept key in header" {

				$InputObj | Get-PASPSMConnectionParameter -ConnectionMethod RDP

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$WebSession.Headers["Accept"] -eq 'application/json' } -Times 1 -Exactly -Scope It

			}

			It "specifies expected Accept key in header for PSMGW requests" {

				$InputObj | Get-PASPSMConnectionParameter -ConnectionMethod PSMGW

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$WebSession.Headers["Accept"] -eq '* / *' } -Times 1 -Exactly -Scope It

			}

			It "throws error if version requirement not met for RDP connection method" {
				$Script:ExternalVersion = "9.8"
				{ $InputObj | Get-PASPSMConnectionParameter -ConnectionMethod RDP } | Should Throw
				$Script:ExternalVersion = "0.0"
			}

			It "throws error if version requirement not met for PSMGW connection method" {

				$Script:ExternalVersion = "9.10"
				{ $InputObj | Get-PASPSMConnectionParameter -ConnectionMethod PSMGW } | Should Throw
				$Script:ExternalVersion = "0.0"
			}

			It "sends request to expected endpoint for AdHocConnect" {

				$AdHocObj | Get-PASPSMConnectionParameter -ConnectionMethod RDP
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/API/Accounts/AdHocConnect"

				} -Times 1 -Exactly -Scope It

			}

			It "throws error if version requirement not met for AdHocConnect" {
				$Script:ExternalVersion = "10.4"
				{ $AdHocObj | Get-PASPSMConnectionParameter -ConnectionMethod PSMGW } | Should Throw
				$Script:ExternalVersion = "0.0"
			}

		}

		Context "Output" {

			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{"Prop1" = "VAL1"; "Prop2" = "Val2"; "Prop3" = "Val3" }
				}

				$InputObj = [pscustomobject]@{

					"AccountID"           = "99_9"
					"ConnectionComponent" = "SomeConnectionComponent"

				}

				$AdHocObj = [pscustomobject]@{
					"ConnectionComponent" = "SomeConnectionComponent"
					"UserName"            = "SomeUser"
					"secret"              = "SomeSecret" | ConvertTo-SecureString -AsPlainText -Force
					"address"             = "Some.Address"
					"platformID"          = "SomePlatform"

				}

				$Script:BaseURI = "https://SomeURL/SomeApp"
				$Script:ExternalVersion = "0.0"
				$Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			}

			it "provides output" {

				$InputObj | Get-PASPSMConnectionParameter -ConnectionMethod RDP | Should not BeNullOrEmpty

			}

			It "has output with expected number of properties" {

				($InputObj | Get-PASPSMConnectionParameter -ConnectionMethod RDP | Get-Member -MemberType NoteProperty).length | Should Be 3

			}

			it "outputs object with expected typename" {

				$InputObj | Get-PASPSMConnectionParameter -ConnectionMethod RDP | get-member | select-object -expandproperty typename -Unique | Should Be psPAS.CyberArk.Vault.PSM.Connection.RDP

			}



		}

	}

}