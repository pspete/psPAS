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
			[PSCustomObject]@{"Recordings" = [PSCustomObject]@{"Prop1" = "VAL1"; "Prop2" = "Val2"; "Prop3" = "Val3"}}
		}

		$InputObj = [pscustomobject]@{
			"sessionToken" = @{"Authorization" = "P_AuthValue"}
			"WebSession"   = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			"BaseURI"      = "https://P_URI"
			"PVWAAppName"  = "P_App"
			"Limit"        = 9

		}

		$InputObjV10 = [pscustomobject]@{
			"sessionToken" = @{"Authorization" = "P_AuthValue"}
			"WebSession"   = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			"BaseURI"      = "https://P_URI"
			"PVWAAppName"  = "P_App"

		}

		Context "Mandatory Parameters" {

			$Parameters = @{Parameter = 'BaseURI'},
			@{Parameter = 'SessionToken'}

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command Get-PASPSMRecording).Parameters["$Parameter"].Attributes.Mandatory | Should Be $true

			}

		}

		$response = $InputObj | Get-PASPSMRecording

		Context "Input" {

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope Describe

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/API/Recordings?Limit=9"

				} -Times 1 -Exactly -Scope Describe

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Method -match 'GET' } -Times 1 -Exactly -Scope Describe

			}

			It "sends request with no body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Body -eq $null} -Times 1 -Exactly -Scope Describe

			}

			It "sends request to expected endpoint when querying by ID" {

				$InputObjV10 | Get-PASPSMRecording -RecordingId SomeID

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObjV10.BaseURI)/$($InputObjV10.PVWAAppName)/API/Recordings/SomeID"

				} -Times 1 -Exactly -Scope It

			}

			It "throws error if version requirement not met" {
				{$InputObj | Get-PASPSMRecording -ExternalVersion "1.0"} | Should Throw
			}

			It "throws error if version requirement not met when querying by ID" {
				{$InputObjV10 | Get-PASPSMRecording -RecordingId SomeID -ExternalVersion "10.5"} | Should Throw
			}

		}

		Context "Output" {

			it "provides output" {

				$response | Should not BeNullOrEmpty

			}

			It "has output with expected number of properties" {

				($response | Get-Member -MemberType NoteProperty).length | Should Be 8

			}

			it "outputs object with expected typename" {

				$response | get-member | select-object -expandproperty typename -Unique | Should Be psPAS.CyberArk.Vault.PSM.Recording

			}

			$DefaultProps = @{Property = 'sessionToken'},
			@{Property = 'WebSession'},
			@{Property = 'BaseURI'},
			@{Property = 'PVWAAppName'},
			@{Property = 'ExternalVersion'}

			It "returns default property <Property> in response" -TestCases $DefaultProps {
				param($Property)

				$response.$Property | Should Not BeNullOrEmpty

			}

		}

	}

}