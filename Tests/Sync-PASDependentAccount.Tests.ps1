Describe $($PSCommandPath -replace '.Tests.ps1') {

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

        Context 'Mandatory Parameters' {

            $Parameters = @{Parameter = 'accountId' }, @{Parameter = 'dependentAccountId' }

            It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

                param($Parameter)

                (Get-Command Sync-PASDependentAccount).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

            }

        }

        Context 'Input' {

            BeforeEach {

                $psPASSession.ExternalVersion = '0.0'

                Mock Invoke-PASRestMethod {
                    param($Uri, $Method, $Body)

                    $Script:RequestBodyRaw = $Body
                    return @{ DependentAccounts = @() }
                }



                $InputObj = [pscustomobject]@{
                    'accountId'          = '12_34'
                    'dependentAccountId' = '56_78'
                }

                Sync-PASDependentAccount -accountId $InputObj.accountId -dependentAccountId $InputObj.dependentAccountId

            }

            It 'sends request' {

                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/API/Accounts/12_34/dependentAccounts/56_78/Sync"

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected method' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

            }

            It 'sends request with no body' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $Body -eq $null

                } -Times 1 -Exactly -Scope It

            }

            It 'throws error if version requirement not met' {

                $psPASSession.ExternalVersion = '1.0'
                { Sync-PASDependentAccount -accountId $InputObj.accountId -dependentAccountId $InputObj.dependentAccountId } | Should -Throw
                $psPASSession.ExternalVersion = '0.0'

            }

            It 'sends requests for bulk sync to expected endpoint' {

                $psPASSession.ExternalVersion = '14.6'
                Sync-PASDependentAccount -accountId $InputObj.accountId -dependentAccountId '1', '2', '3', '4'

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/API/Accounts/$($InputObj.accountId)/dependentAccounts/Sync/Bulk"

                } -Times 1 -Exactly -Scope It
            }

            It 'sends request with body for bulk confirmations' {

                Sync-PASDependentAccount -accountId $InputObj.accountId -dependentAccountId '1', '2', '3', '4'

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $Body -ne $null

                } -Times 1 -Exactly -Scope It

            }

            It 'sends request with expected body for bulk confirmations' {
                # Capture the body during the mock
                Mock Invoke-PASRestMethod {
                    param($Uri, $Method, $Body)
                    $Script:RequestBodyRaw = $Body
                    return @{ DependentAccounts = @() }
                }

                # Run the command
                Sync-PASDependentAccount -accountId $InputObj.accountId -dependentAccountId '1', '2', '3', '4'

                # Assert the mock was called
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
                    $Body -match '"BulkItems":' -and $Method -eq 'POST'
                } -Times 1 -Exactly -Scope It



                # Convert and inspect the captured body
                $Script:RequestBody = $Script:RequestBodyRaw | ConvertFrom-Json

                $Script:RequestBody.BulkItems | Should -Not -BeNullOrEmpty
                $Script:RequestBody.BulkItems.Count | Should -Be 4
                $Script:RequestBody.BulkItems[0].accountId | Should -Be $InputObj.accountId
            }



            It 'has a request body with expected number of confirmations' {

                ($Script:RequestBody.BulkItems).count | Should -Be 4

            }


        }

        Context 'Output' {

            BeforeEach {

                $psPASSession.ExternalVersion = '0.0'

                Mock Invoke-PASRestMethod -MockWith {

                }

                $InputObj = [pscustomobject]@{
                    'accountId'          = '12_34'
                    'dependentAccountId' = '56_78'
                }

                $response = Sync-PASDependentAccount -accountId $InputObj.accountId -dependentAccountId $InputObj.dependentAccountId

            }

            It 'provides no output' {

                $response | Should -BeNullOrEmpty

            }

        }

    }

}
