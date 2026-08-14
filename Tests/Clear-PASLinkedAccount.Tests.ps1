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

        BeforeEach {
            $psPASSession.ExternalVersion = '0.0'

            Mock Invoke-PASRestMethod -MockWith {

            }

            $response = Clear-PASLinkedAccount -AccountID 12_34 -extraPasswordIndex 2

        }

        Context 'Input' {

            It 'sends request' {

                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/api/Accounts/12_34/LinkAccount/2"

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected method' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'DELETE' } -Times 1 -Exactly -Scope It

            }

            It 'throws error if version requirement not met' {
                $psPASSession.ExternalVersion = '1.0'
                { $InputObject | Clear-PASLinkedAccount -AccountID 12_34 -extraPasswordIndex 2 } | Should -Throw
                $psPASSession.ExternalVersion = '0.0'
            }

        }

        Context 'Bulk Input' {

            BeforeAll {
                $psPASSession.ExternalVersion = '15.2'

                $Script:Calls = @()

                Mock Invoke-PASRestMethod {
                    param($Uri, $Method, $Body)
                    $Script:Calls += [pscustomobject]@{
                        Uri    = $Uri
                        Method = $Method
                        Body   = $Body
                    }
                }

                $null = Clear-PASLinkedAccount -AccountID '12_34', '56_78' -extraPasswordIndex 2

            }

            It 'sends request' {

                $Script:Calls.Count | Should -Be 1

            }

            It 'sends request to expected endpoint' {

                $Script:Calls[0].Uri | Should -Be "$($Script:psPASSession.BaseURI)/API/Accounts/Unlink/Bulk"

            }

            It 'uses expected method' {

                $Script:Calls[0].Method | Should -Be 'DELETE'

            }

            It 'sends request with body for bulk clear' {

                $Script:Calls[0].Body | Should -Not -BeNullOrEmpty

            }

            It 'sends request with expected body for bulk clear' {

                $Script:RequestBody = $Script:Calls[0].Body | ConvertFrom-Json

                $Script:RequestBody.BulkItems | Should -Not -BeNullOrEmpty
                $Script:RequestBody.BulkItems.Count | Should -Be 2
                $Script:RequestBody.BulkItems[0].AccountID | Should -Be '12_34'
                $Script:RequestBody.BulkItems[0].extraPasswordIndex | Should -Be 2
                $Script:RequestBody.BulkItems[0].extraPasswordIndex | Should -Not -BeOfType [array]

            }

        }

        Context 'Bulk Input Version' {

            It 'throws error if bulk version requirement not met' {
                $psPASSession.ExternalVersion = '15.1'
                { Clear-PASLinkedAccount -AccountID '12_34', '56_78' -extraPasswordIndex 2 } | Should -Throw
                $psPASSession.ExternalVersion = '0.0'
            }

        }

        Context 'Output' {

            It 'provides no output' {

                $response | Should -BeNullOrEmpty

            }

        }

    }

}