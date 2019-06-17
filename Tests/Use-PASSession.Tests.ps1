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

		BeforeEach {
			$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			$session.Headers["Test"] = "SomeValue"

			$InputObject = [PSCustomObject]@{
				PSTypeName      = 'psPAS.CyberArk.Vault.Session'
				User            = "SomeUser"
				BaseURI         = "SomeURL"
				ExternalVersion = "6.6"
				WebSession      = $session
			}

		}

		Context "Standard Operation" {

			BeforeEach {
				$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
				$session.Headers["Test"] = "SomeValue"

				$InputObject = [PSCustomObject]@{
					PSTypeName      = 'psPAS.CyberArk.Vault.Session'
					User            = "SomeUser"
					BaseURI         = "SomeURL"
					ExternalVersion = "6.6"
					WebSession      = $session
				}

			}

			it "invokes set-variable the expected number of times" {
				Mock Set-Variable -MockWith { }
				Use-PASSession -Session $InputObject
				Assert-MockCalled Set-Variable -Times 3 -Exactly -Scope It
			}

		}

	}

}