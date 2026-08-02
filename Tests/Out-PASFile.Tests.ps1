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



		Context 'Standard Operation' {
			BeforeEach {

				$Object = [PSCustomObject]@{
					Content = New-Object Byte[] 512
					Headers = @{'Content-Disposition' = 'attachment; filename=FILENAME.zip' }
				}

				Mock Get-Item -MockWith { }

				Mock Set-Content -MockWith { }

			}

			It 'does not throw' {

				{ Out-PASFile -InputObject $Object -Path 'C:\Temp' } | Should -Not -Throw

			}

			It 'throws on Set-Content error' {
				Mock Set-Content -MockWith { throw 'error' }
				{ Out-PASFile -InputObject $Object } | Should -Throw
			}

		}

		Context 'Full File Path Provided' {
			BeforeEach {

				$Object = [PSCustomObject]@{
					Content = New-Object Byte[] 512
					Headers = @{'Content-Disposition' = 'attachment; filename=FILENAME.zip' }
				}

				Mock Get-Item -MockWith { }

				Mock Set-Content -MockWith { }

			}

			It 'saves to the exact path when the path has a file extension, even if a same-named container exists' {

				Mock Test-Path -MockWith { $true } -ParameterFilter { $PathType -eq 'Container' }

				Out-PASFile -InputObject $Object -Path 'C:\Temp\test.avi'

				Assert-MockCalled Set-Content -ParameterFilter { $Path -eq 'C:\Temp\test.avi' } -Times 1 -Exactly -Scope It

			}

			It 'saves to the exact path when the path has a file extension and does not exist' {

				Mock Test-Path -MockWith { $false } -ParameterFilter { $PathType -eq 'Container' }

				Out-PASFile -InputObject $Object -Path 'C:\Temp\test.avi'

				Assert-MockCalled Set-Content -ParameterFilter { $Path -eq 'C:\Temp\test.avi' } -Times 1 -Exactly -Scope It

			}

		}

		Context 'String Content Provided' {
			BeforeEach {

				#Content is a decoded String, not a Byte Array, when the API sends file
				#content with an incorrect text/* Content-Type - see Get-PASResponse.ps1
				$Object = [PSCustomObject]@{
					Content = 'Some File Content'
					Headers = @{'Content-Disposition' = 'attachment; filename=FILENAME.pem' }
				}

				Mock Get-Item -MockWith { }

				Mock Set-Content -MockWith { }

			}

			It 'writes the UTF8 byte representation of the string content' {

				Out-PASFile -InputObject $Object -Path 'C:\Temp\test.pem'

				Assert-MockCalled Set-Content -ParameterFilter {
					($Path -eq 'C:\Temp\test.pem') -and
					(-not (Compare-Object $Value ([System.Text.Encoding]::UTF8.GetBytes('Some File Content'))))
				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Folder Path Provided' {
			BeforeEach {

				$Object = [PSCustomObject]@{
					Content = New-Object Byte[] 512
					Headers = @{'Content-Disposition' = 'attachment; filename=FILENAME.zip' }
				}

				Mock Get-Item -MockWith { }

				Mock Set-Content -MockWith { }

				Mock Test-Path -MockWith { $true } -ParameterFilter { $PathType -eq 'Container' }

			}

			It 'appends the suggested filename when the path has no file extension' {

				Out-PASFile -InputObject $Object -Path 'C:\Temp'

				Assert-MockCalled Set-Content -ParameterFilter { $Path -eq 'C:\Temp\FILENAME.zip' } -Times 1 -Exactly -Scope It

			}

		}

	}

}
