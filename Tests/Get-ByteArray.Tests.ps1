#Get Current Directory
$Here = Split-Path -Parent $MyInvocation.MyCommand.Path

#Get Function Name
$FunctionName = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -Replace ".Tests.ps1"

#Assume ModuleName from Repository Root folder
$ModuleName = Split-Path (Split-Path $Here -Parent) -Leaf

#Resolve Path to Module Directory
$ModulePath = Resolve-Path "$Here\..\$ModuleName"

#Define Path to Module Manifest
$Global:ManifestPath = Join-Path "$ModulePath" "$ModuleName.psd1"

if( -not (Get-Module -Name $ModuleName -All)) {

	Import-Module -Name "$Global:ManifestPath" -Force -ErrorAction Stop

}

BeforeAll {

	#$Script:RequestBody = $null

}

AfterAll {

	#$Script:RequestBody = $null

}

Describe $FunctionName {

	InModuleScope $ModuleName {

		Context "Mandatory Parameters" {

			$Parameters = @{Parameter = 'Path'}

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command Get-ByteArray).Parameters["$Parameter"].Attributes.Mandatory | Should Be $true

			}

		}

		Context "General" {

			BeforeEach {


				#$file = $((Join-Path $(Resolve-Path "$Here\..\$ModuleName") "psPAS.psm1"))
				$InputObj = [pscustomobject]@{
					Path = "$Global:ManifestPath"
				}

			}

			It "outputs byte array of expected size" {

				(Get-ByteArray -Path "$($InputObj.Path)").Count | Should Be (Get-Content "$($InputObj.Path)" -ReadCount 0 -AsByteStream).Count

			}

		}

	}

}