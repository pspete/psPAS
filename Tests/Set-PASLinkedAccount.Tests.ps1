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

            $InputObject = [PSCustomObject]@{

                AccountID          = '12_3'
                safe               = 'SomeSafeName'
                extraPasswordIndex = 1
                name               = 'SomeAccountName'
                folder             = 'SomeFolder'

            }

            $response = $InputObject | Set-PASLinkedAccount

        }

        Context 'Input' {

            It 'sends request' {

                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/api/Accounts/12_3/LinkAccount"

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected method' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

            }

            It 'sends request with expected body' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
                    $($Body | ConvertFrom-Json) -ne $null
                } -Times 1 -Exactly -Scope It

            }

            It 'throws error if version requirement not met' {
                $psPASSession.ExternalVersion = '1.0'
                { $InputObject | Set-PASLinkedAccount } | Should -Throw
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

                $null = Set-PASLinkedAccount -AccountID '12_3', '45_6' -safe 'SomeSafeName' -extraPasswordIndex '1' -name 'SomeAccountName' -folder 'SomeFolder'

            }

            It 'sends request' {

                $Script:Calls.Count | Should -Be 1

            }

            It 'sends request to expected endpoint' {

                $Script:Calls[0].Uri | Should -Be "$($Script:psPASSession.BaseURI)/API/Accounts/Link/Bulk"

            }

            It 'uses expected method' {

                $Script:Calls[0].Method | Should -Be 'POST'

            }

            It 'sends request with body for bulk link' {

                $Script:Calls[0].Body | Should -Not -BeNullOrEmpty

            }

            It 'sends request with expected body for bulk link' {

                $Script:RequestBody = $Script:Calls[0].Body | ConvertFrom-Json

                $Script:RequestBody.BulkItems | Should -Not -BeNullOrEmpty
                $Script:RequestBody.BulkItems.Count | Should -Be 2
                $Script:RequestBody.BulkItems[0].AccountID | Should -Be '12_3'
                $Script:RequestBody.BulkItems[0].safe | Should -Be 'SomeSafeName'
                $Script:RequestBody.BulkItems[0].extraPasswordIndex | Should -Be '1'
                $Script:RequestBody.BulkItems[0].name | Should -Be 'SomeAccountName'
                $Script:RequestBody.BulkItems[0].folder | Should -Be 'SomeFolder'

            }

        }

        Context 'Bulk Input Version' {

            It 'throws error if bulk version requirement not met' {
                $psPASSession.ExternalVersion = '15.1'
                { Set-PASLinkedAccount -AccountID '12_3', '45_6' -safe 'SomeSafeName' -extraPasswordIndex '1' -name 'SomeAccountName' -folder 'SomeFolder' } | Should -Throw
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