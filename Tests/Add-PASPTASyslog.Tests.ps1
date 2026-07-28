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

            $SomePassword = $('Some_Password' | ConvertTo-SecureString -AsPlainText -Force)

            $InputObj = [pscustomobject]@{
                'siem'             = 'SomeSIEM'
                'format'           = 'CEF'
                'host'             = 'SomeHost'
                'port'             = 514
                'protocol'         = 'UDP'
                'syslogType'       = 'RFC5424'
                'tcpOctetCounting' = $false
            }

            $response = $InputObj | Add-PASPTASyslog

        }



        Context 'Mandatory Parameters' {

            $Parameters = @{Parameter = 'siem' }, @{Parameter = 'format' },
            @{Parameter = 'protocol' }, @{Parameter = 'port' }, @{Parameter = 'host' },
            @{Parameter = 'syslogType' }, @{Parameter = 'tcpOctetCounting' }

            It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

                param($Parameter)

                (Get-Command Add-PASPTASyslog).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

            }

        }

        Context 'Input' {

            It 'sends request' {

                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/api/pta/API/Administration/properties/SyslogOutboundDataList"

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected method' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'PATCH' } -Times 1 -Exactly -Scope It

            }

            It 'sends request with expected body' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $Script:RequestBody = $Body | ConvertFrom-Json

                    ($Script:RequestBody) -ne $null

                } -Times 1 -Exactly -Scope It

            }

            It 'has a request body with expected number of properties' {

                ($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should -Be 7

            }

            It 'throws error if version requirement not met' {

                $psPASSession.ExternalVersion = '1.0'

                { $InputObj | Add-PASPTASyslog } | Should -Throw

                $psPASSession.ExternalVersion = '0.0'
            }

        }

        Context 'Output' {

            It 'provides no output' {

                $response | Should -BeNullOrEmpty

            }

            It 'returns a result when one is provided by the API' {

                Mock Invoke-PASRestMethod -MockWith { [PSCustomObject]@{'Success' = $true } }

                $result = $InputObj | Add-PASPTASyslog

                $result | Should -Not -BeNullOrEmpty

            }

        }

        Context 'Certificate Handling' {

            BeforeAll {

                $Script:SyslogCertTestDrive = Join-Path $env:TEMP "psPASTests_$([guid]::NewGuid().Guid)"
                New-Item -ItemType Directory -Path $Script:SyslogCertTestDrive -Force | Out-Null

            }

            AfterAll {

                Remove-Item -Path $Script:SyslogCertTestDrive -Recurse -Force -ErrorAction SilentlyContinue

            }

            BeforeEach {

                Mock Invoke-PASRestMethod -MockWith { [PSCustomObject]@{'Success' = $true } }

                $CertInputObj = [pscustomobject]@{
                    'siem'             = 'SomeSIEM'
                    'format'           = 'CEF'
                    'host'             = 'SomeHost'
                    'port'             = 514
                    'syslogType'       = 'RFC5424'
                    'tcpOctetCounting' = $false
                }

                $CertPath = Join-Path $Script:SyslogCertTestDrive 'cert.pem'
                [System.IO.File]::WriteAllText($CertPath, 'SomeCertificateContent')

            }

            It 'throws if CertificateFile does not exist' {

                { $CertInputObj | Add-PASPTASyslog -protocol TLS -CertificateFile (Join-Path $Script:SyslogCertTestDrive 'missing.pem') } | Should -Throw

            }

            It 'throws if CertificateFile has an unsupported extension' {

                $BadExtPath = Join-Path $Script:SyslogCertTestDrive 'cert.txt'
                Set-Content -Path $BadExtPath -Value 'SomeCertificateContent'

                { $CertInputObj | Add-PASPTASyslog -protocol TLS -CertificateFile $BadExtPath } | Should -Throw

            }

            It 'includes base64 encoded certificate content in the request body when protocol is TLS' {

                $CertInputObj | Add-PASPTASyslog -protocol TLS -CertificateFile $CertPath

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $ExpectedBase64 = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes('SomeCertificateContent'))
                    (($Body | ConvertFrom-Json).certificate) -eq $ExpectedBase64

                } -Times 1 -Exactly -Scope It

            }

            It 'does not include a certificate when protocol is not TLS' {

                $CertInputObj | Add-PASPTASyslog -protocol UDP

                #The shared outer BeforeEach also issues a UDP/no-cert request, so both calls in this
                #test's scope are expected to match this filter.
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $null -eq (($Body | ConvertFrom-Json).certificate)

                } -Times 2 -Exactly -Scope It

            }

            It 'wraps errors encountered reading or encoding the certificate file' {

                Mock Get-Content -MockWith { throw 'Disk error' }

                { $CertInputObj | Add-PASPTASyslog -protocol TLS -CertificateFile $CertPath } | Should -Throw "*Failed to read or encode certificate file*"

            }

        }

    }

}