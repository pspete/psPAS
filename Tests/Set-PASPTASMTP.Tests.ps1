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

            It 'returns a result when one is provided by the API' {

                Mock Invoke-PASRestMethod -MockWith { [PSCustomObject]@{'Success' = $true } }

                $result = $InputObj | Set-PASPTASMTP

                $result | Should -Not -BeNullOrEmpty

            }

        }

        Context 'Certificate Handling' {

            BeforeAll {

                $Script:CertTestDrive = Join-Path $env:TEMP "psPASTests_$([guid]::NewGuid().Guid)"
                New-Item -ItemType Directory -Path $Script:CertTestDrive -Force | Out-Null

            }

            AfterAll {

                Remove-Item -Path $Script:CertTestDrive -Recurse -Force -ErrorAction SilentlyContinue

            }

            BeforeEach {

                Mock Invoke-PASRestMethod -MockWith { [PSCustomObject]@{'Success' = $true } }

                $CertInputObj = [pscustomobject]@{
                    'host'                       = 'SomeHost'
                    'port'                       = 514
                    'sender'                     = 'SomeSender'
                    'recipients'                 = @('SomeRecipient1')
                    'AlertToEmailScoreThreshold' = 75
                }

                $CertPath = Join-Path $Script:CertTestDrive 'cert.pem'
                [System.IO.File]::WriteAllText($CertPath, 'SomeCertificateContent')

            }

            It 'throws if CertificateFile does not exist' {

                { $CertInputObj | Set-PASPTASMTP -protocol SSL -CertificateFile (Join-Path $Script:CertTestDrive 'missing.pem') } | Should -Throw

            }

            It 'throws if CertificateFile has an unsupported extension' {

                $BadExtPath = Join-Path $Script:CertTestDrive 'cert.txt'
                Set-Content -Path $BadExtPath -Value 'SomeCertificateContent'

                { $CertInputObj | Set-PASPTASMTP -protocol SSL -CertificateFile $BadExtPath } | Should -Throw

            }

            It 'throws if protocol is not NONE and no CertificateFile is specified' {

                { $CertInputObj | Set-PASPTASMTP -protocol SSL } | Should -Throw

            }

            It 'includes base64 encoded certificate content in the request body when protocol requires it' {

                $CertInputObj | Set-PASPTASMTP -protocol SSL -CertificateFile $CertPath

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    #Body is a JSON array of {key, value} pairs, not a flat object
                    $ExpectedBase64 = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes('SomeCertificateContent'))
                    $SmtpDetails = ($Body | ConvertFrom-Json | Where-Object key -eq 'SMTPConnectivityDetails').value
                    $SmtpDetails.certificate -eq $ExpectedBase64

                } -Times 1 -Exactly -Scope It

            }

            It 'includes accountId in the authenticationMethod when specified' {

                $CertInputObj | Set-PASPTASMTP -protocol NONE -accountId 'SomeAccountID123'

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    #Body is a JSON array of {key, value} pairs, not a flat object
                    $SmtpDetails = ($Body | ConvertFrom-Json | Where-Object key -eq 'SMTPConnectivityDetails').value
                    $SmtpDetails.authenticationMethod.accountId -eq 'SomeAccountID123'

                } -Times 1 -Exactly -Scope It

            }

            It 'wraps errors encountered reading or encoding the certificate file' {

                Mock Get-Content -MockWith { throw 'Disk error' }

                { $CertInputObj | Set-PASPTASMTP -protocol SSL -CertificateFile $CertPath } | Should -Throw "*Failed to read or encode certificate file*"

            }

        }

    }

}