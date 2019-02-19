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

		Mock Invoke-PASRestMethod -MockWith {
			[PSCustomObject]@{"Prop1" = "VAL1"; "Prop2" = "Val2"; "Prop3" = "Val3"}
		}

		$InputObj = [pscustomobject]@{
			"sessionToken"        = @{"Authorization" = "P_AuthValue"}
			"WebSession"          = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			"BaseURI"             = "https://P_URI"
			"PVWAAppName"         = "P_App"
			"AccountID"           = "99_9"
			"ConnectionComponent" = "SomeConnectionComponent"

		}

		$AdHocObj = [pscustomobject]@{
			"sessionToken"        = @{"Authorization" = "P_AuthValue"}
			"WebSession"          = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			"BaseURI"             = "https://P_URI"
			"PVWAAppName"         = "P_App"
			"ConnectionComponent" = "SomeConnectionComponent"
			"UserName"            = "SomeUser"
			"secret"              = "SomeSecret" | ConvertTo-SecureString -AsPlainText -Force
			"address"             = "Some.Address"
			"platformID"          = "SomePlatform"

		}

		Context "Mandatory Parameters" {

			$Parameters = @{Parameter = 'BaseURI'},
			@{Parameter = 'SessionToken'},
			@{Parameter = 'AccountID'},
			@{Parameter = 'ConnectionComponent'}

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command Get-PASPSMConnectionParameter).Parameters["$Parameter"].Attributes.Mandatory | Select-Object -Unique | Should Be $true

			}

		}

		$response = $InputObj | Get-PASPSMConnectionParameter -ConnectionMethod RDP

		Context "Input" {

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope Describe

			}

			It "sends request to expected endpoint for PSMConnect" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/API/Accounts/99_9/PSMConnect"

				} -Times 1 -Exactly -Scope Describe

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Method -match 'POST' } -Times 1 -Exactly -Scope Describe

			}

			It "sends request with expected body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope Describe

			}

			It "has a request body with expected number of properties" {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should Be 1

			}

			It "has expected Accept key in header" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Headers["Accept"] -eq 'application/json' } -Times 1 -Exactly -Scope Describe

			}

			It "specifies expected Accept key in header for PSMGW requests" {

				$InputObj | Get-PASPSMConnectionParameter -ConnectionMethod PSMGW

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Headers["Accept"] -eq '* / *' } -Times 1 -Exactly -Scope It

			}

			It "throws error if version requirement not met for RDP connection method" {
				{$InputObj | Get-PASPSMConnectionParameter -ConnectionMethod RDP -ExternalVersion "9.8"} | Should Throw
			}

			It "throws error if version requirement not met for PSMGW connection method" {
				{$InputObj | Get-PASPSMConnectionParameter -ConnectionMethod PSMGW -ExternalVersion "9.10"} | Should Throw
			}

			It "sends request to expected endpoint for AdHocConnect" {

				$AdHocObj | Get-PASPSMConnectionParameter -ConnectionMethod RDP
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/API/Accounts/AdHocConnect"

				} -Times 1 -Exactly -Scope It

			}

			It "throws error if version requirement not met for AdHocConnect" {
				{$AdHocObj | Get-PASPSMConnectionParameter -ConnectionMethod PSMGW -ExternalVersion "10.4"} | Should Throw
			}

		}

		Context "Output" {

			it "provides output" {

				$response | Should not BeNullOrEmpty

			}

			It "has output with expected number of properties" {

				($response | Get-Member -MemberType NoteProperty).length | Should Be 3

			}

			it "outputs object with expected typename" {

				$response | get-member | select-object -expandproperty typename -Unique | Should Be psPAS.CyberArk.Vault.PSM.Connection.RDP

			}

			$DefaultProps = @{Property = 'sessionToken'},
			@{Property = 'WebSession'},
			@{Property = 'BaseURI'},
			@{Property = 'PVWAAppName'}

			It "does not return default property <Property> in response" -TestCases $DefaultProps {
				param($Property)

				$response.$Property | Should Be $null

			}

		}

	}

}