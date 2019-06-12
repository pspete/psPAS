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

		Context "Input" {

			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{"Recordings" = [PSCustomObject]@{"Prop1" = "VAL1"; "Prop2" = "Val2"; "Prop3" = "Val3" } }
				}

				$InputObj = [pscustomobject]@{

					"Limit" = 9

				}

				$Script:BaseURI = "https://SomeURL/SomeApp"
				$Script:ExternalVersion = "0.0"
				$Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			}

			It "sends request" {
				$InputObj | Get-PASPSMRecording
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {
				$InputObj | Get-PASPSMRecording
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/API/Recordings?Limit=9"

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {
				$InputObj | Get-PASPSMRecording
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It "sends request with no body" {
				$InputObj | Get-PASPSMRecording
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint when querying by ID" {

				Get-PASPSMRecording -RecordingId SomeID

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/API/Recordings/SomeID"

				} -Times 1 -Exactly -Scope It

			}

			It "throws error if version requirement not met" {
				{ $InputObj | Get-PASPSMRecording -ExternalVersion "1.0" } | Should Throw
			}

			It "throws error if version requirement not met when querying by ID" {
				{ Get-PASPSMRecording -RecordingId SomeID -ExternalVersion "10.5" } | Should Throw
			}

		}

		Context "Output" {
			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{"Recordings" = [PSCustomObject]@{"Prop1" = "VAL1"; "Prop2" = "Val2"; "Prop3" = "Val3" } }
				}

				$InputObj = [pscustomobject]@{

					"Limit" = 9

				}

				$Script:BaseURI = "https://SomeURL/SomeApp"
				$Script:ExternalVersion = "0.0"
				$Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			}
			it "provides output" {

				$InputObj | Get-PASPSMRecording | Should not BeNullOrEmpty

			}

			It "has output with expected number of properties" {

				($InputObj | Get-PASPSMRecording | Get-Member -MemberType NoteProperty).length | Should Be 3

			}

			it "outputs object with expected typename" {

				$InputObj | Get-PASPSMRecording | get-member | select-object -expandproperty typename -Unique | Should Be psPAS.CyberArk.Vault.PSM.Recording

			}



		}

	}

}