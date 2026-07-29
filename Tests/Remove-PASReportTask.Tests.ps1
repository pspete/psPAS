Describe $($PSCommandPath -Replace '.Tests.ps1') {

    BeforeAll {
        $Here = Split-Path -Parent $PSCommandPath
        $ModuleName = Split-Path (Split-Path $Here -Parent) -Leaf
        $ModulePath = Resolve-Path "$Here\..\$ModuleName"
        $ManifestPath = Join-Path $ModulePath "$ModuleName.psd1"

        if (-not (Get-Module -Name $ModuleName -All)) {
            Import-Module -Name "$ManifestPath" -ArgumentList $true -Force -ErrorAction Stop
        }

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

    InModuleScope $(Split-Path (Split-Path (Split-Path -Parent $PSCommandPath) -Parent) -Leaf) {

        BeforeEach {
            $script:seenUri = $null
            $script:seenMethod = $null
            $script:seenBody = $null

            Mock Assert-VersionRequirement {}

            Mock Invoke-PASRestMethod {
                $script:seenUri = $Uri
                $script:seenMethod = $Method
                $script:seenBody = $Body
            }
        }

        Context 'Input' {
            It 'sends request to expected endpoint' {
                $null = Remove-PASReportTask -id 'SomeTaskId' -Confirm:$false
                $script:seenUri | Should -Be "$($Script:psPASSession.BaseURI)/API/Tasks/SomeTaskId"
            }

            It 'uses expected method' {
                $null = Remove-PASReportTask -id 'SomeTaskId' -Confirm:$false
                $script:seenMethod | Should -Match 'DELETE'
            }

            It 'sends request with no body' {
                $null = Remove-PASReportTask -id 'SomeTaskId' -Confirm:$false
                $script:seenBody | Should -Be $null
            }
        }
    }
}