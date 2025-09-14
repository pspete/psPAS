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

        BeforeEach {

            Mock Invoke-PASRestMethod -MockWith {

            }

            $InputObj = [pscustomobject]@{
                'host'                       = 'SomeHost'
                'port'                       = 514
                'protocol'                   = 'NONE'
                'sender'                     = 'SomeSender'
                'recipients'                 = @('SomeRecipient1', 'SomeRecipient2')
                'AlertToEmailScoreThreshold' = 75
            }

            $response = $InputObj | Set-PASPTASMTP

        }



        Context 'Mandatory Parameters' {

            $Parameters = @{Parameter = 'host' }, @{Parameter = 'protocol' }, @{Parameter = 'port' },
            @{Parameter = 'sender' }, @{Parameter = 'recipients' }, @{Parameter = 'AlertToEmailScoreThreshold' }

            It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

                param($Parameter)

                (Get-Command Set-PASPTASMTP).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

            }

        }

        Context 'Input' {

            It 'sends request' {

                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/api/pta/API/Administration/properties"

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected method' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

            }

            It 'sends request with expected body' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $Script:RequestBody = $Body | ConvertFrom-Json

                    ($Script:RequestBody) -ne $null

                } -Times 1 -Exactly -Scope It

            }

            It 'has a request body with expected number of properties' {

                ($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should -Be 2
                $Script:RequestBody.SMTPConnectivityDetails | Should -Not -BeNullOrEmpty
                $Script:RequestBody.AlertToEmailScoreThreshold | Should -Not -BeNullOrEmpty

            }

            It 'throws error if version requirement not met' {

                $psPASSession.ExternalVersion = '1.0'

                { $InputObj | Set-PASPTASMTP } | Should -Throw

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