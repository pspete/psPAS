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

        Context	'General Tests' {
            BeforeEach {

                $InputObject = [pscustomobject]@{'prop1' = 'value1' ; 'prop2' = 'value2' ; 'prop9' = 'value9' }
                $BoundParameters = @{
                    'prop3' = 'value 3'
                    'prop4' = 'value 4'
                }
                Format-PutRequestObject -InputObject $InputObject -boundParameters $BoundParameters -ParametersToRemove prop1, prop2
            }

            AfterEach {
                $BoundParameters = $null
            }
            It 'sets expected number of keys for BoundParameters' {

                ($BoundParameters.Keys).Count | Should -Be 3

            }

            It 'sets expected expected value for prop9' {

                $BoundParameters['prop9'] | Should -Be 'value9'

            }

            It 'sets expected expected value for prop1' {

                $BoundParameters['prop1'] | Should -BeNullOrEmpty

            }

        }
    }
}