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

    }


    AfterAll {

        $Script:RequestBody = $null

    }

    InModuleScope $(Split-Path (Split-Path (Split-Path -Parent $PSCommandPath) -Parent) -Leaf ) {

        Context 'Mandatory Parameters' {

            $Parameters = @{Parameter = 'InputObject' }

            It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

                param($Parameter)

				(Get-Command Get-SessionClone).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

            }

        }

        Context 'General' {

            BeforeAll {
                $psPASSession = [ordered]@{
                    BaseURI            = 'https://SomeURL/SomeApp'
                    User               = 'SomeUser'
                    ExternalVersion    = [System.Version]'0.0'
                    WebSession         = New-Object Microsoft.PowerShell.Commands.WebRequestSession
                    StartTime          = (Get-Date).AddMinutes(-5)
                    ElapsedTime        = '{0:HH:mm:ss}' -f [datetime](Get-Date)
                    LastCommand        = (Get-Variable MyInvocation).Value
                    LastCommandTime    = (Get-Date).AddMinutes(-1)
                    LastCommandResults = @{'TestProperty' = 'TestValue' }
                }

                New-Variable -Name object -Value $psPASSession -Scope Script -Force
                $script:Clone = Get-SessionClone -InputObject $script:object
            }

            It 'returns output of expected type' {

                $script:Clone | Should -BeOfType 'System.Collections.Specialized.OrderedDictionary'

            }
            It 'produces expected output properties' {

                $script:Clone.keys | Should -HaveCount 9

            }

            It 'produces output that does not reference the input instance' {

                [System.Object]::ReferenceEquals($script:object, $script:Clone) | Should -BeFalse

            }

            It 'outputs nested hashtable property that does not reference the input instance' {

                [System.Object]::ReferenceEquals($script:object.LastCommandResults, $script:Clone.LastCommandResults) | Should -BeFalse

            }

        }

    }

}