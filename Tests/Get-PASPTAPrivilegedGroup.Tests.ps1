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
        $Script:BaseURI = 'https://SomeURL/SomeApp'
        $Script:ExternalVersion = '0.0'
        $Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

    }


    AfterAll {

        $Script:RequestBody = $null

    }

    InModuleScope $(Split-Path (Split-Path (Split-Path -Parent $PSCommandPath) -Parent) -Leaf ) {

        BeforeEach {
            Mock Invoke-PASRestMethod -MockWith {
                [PSCustomObject]@{
                    'propertykey' = 'PrivilegedDomainGroupsList'
                    'ActualValue' = [PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' }
                }
            }

            $response = Get-PASPTAPrivilegedGroup
        }
        Context 'Input' {

            It 'sends request' {

                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:BaseURI)/API/pta/API/configuration"

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected method' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

            }

            It 'sends request with no body' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $Body -eq $null

                } -Times 1 -Exactly -Scope It

            }

            It 'throws error if version requirement not met' {
                $Script:ExternalVersion = '1.0'
                { Get-PASPTAPrivilegedGroup } | Should -Throw
                $Script:ExternalVersion = '0.0'
            }

        }

        Context 'Output' {

            BeforeEach {

                Mock Invoke-PASRestMethod -MockWith {
                    [PSCustomObject]@{
                        'propertykey' = 'PrivilegedDomainGroupsList'
                        'ActualValue' = [PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' }
                    }
                }

                $Script:BaseURI = 'https://SomeURL/SomeApp'
                $Script:ExternalVersion = '0.0'
                $Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

            }
            It 'provides output' {

                Get-PASPTAPrivilegedGroup | Should -Not -BeNullOrEmpty

            }

            It 'has output with expected number of properties' {

				(Get-PASPTAPrivilegedGroup | Get-Member -MemberType NoteProperty).length | Should -Be 2

            }

            It 'outputs object with expected typename' {

                Get-PASPTAPrivilegedGroup | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.PTA.PrivilegedDomainGroupsList

            }

        }

    }

}