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

        Context 'Input' {

            BeforeEach {

                Mock Invoke-PASRestMethod -MockWith {
                    [PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' }
                }

                $Script:psPASSession.BaseURI = 'https://SomeURL/SomeApp'
                $psPASSession.ExternalVersion = '0.0'
                $psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

            }

            It 'sends request' {
                Set-PASPTARiskEvent -ID 1234 -Status CLOSED
                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint' {
                Set-PASPTARiskEvent -ID 1234 -Status CLOSED
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -match "$($Script:psPASSession.BaseURI)/api/pta/API/Risks/RisksEvents/1234"

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected method' {
                Set-PASPTARiskEvent -ID 1234 -Status CLOSED
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'PATCH' } -Times 1 -Exactly -Scope It

            }

            It 'sends request with expected body' {
                Set-PASPTARiskEvent -ID 1234 -Status CLOSED
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $Body -ne $null

                } -Times 1 -Exactly -Scope It

            }

            It 'throws error if version requirement not met' {
                $psPASSession.ExternalVersion = '1.0'
                { Set-PASPTARiskEvent -ID 1234 -Status CLOSED } | Should -Throw
                $psPASSession.ExternalVersion = '0.0'
            }

        }

        Context 'Output' {
            BeforeEach {

                Mock Invoke-PASRestMethod -MockWith {
                    [PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2'; 'Prop3' = 'Val2'; 'Prop4' = 'Val2'; 'Prop5' = 'Val2' }
                }

                $Script:psPASSession.BaseURI = 'https://SomeURL/SomeApp'
                $psPASSession.ExternalVersion = '0.0'
                $psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

            }
            It 'provides output' {

                Set-PASPTARiskEvent -ID 1234 -Status CLOSED | Should -Not -BeNullOrEmpty

            }

            It 'has output with expected number of properties' {

				(Set-PASPTARiskEvent -ID 1234 -Status CLOSED | Get-Member -MemberType NoteProperty).length | Should -Be 5

            }

            It 'outputs object with expected typename' {

                Set-PASPTARiskEvent -ID 1234 -Status CLOSED | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.PTA.Event.Risk

            }



        }

    }

}