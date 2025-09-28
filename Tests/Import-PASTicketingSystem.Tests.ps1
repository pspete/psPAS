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
            BaseURI            = 'https://SomeURL.cyberark.cloud/SomeApp'
            ApiURI             = 'https://SomeURL.cyberark.cloud'
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

            #TODO: Figure out how to include Assert-VersionRequirement in P Cloud function tests
            Mock Assert-VersionRequirement -MockWith {}

            Mock Invoke-PASRestMethod -MockWith {
                return @{}
            }

            #Create a 512b file to test with
            $file = [System.IO.File]::Create("$env:Temp\testPlatform.zip")
            $file.SetLength(0.5kb)
            $file.Close()

            $InputObject = [PSCustomObject]@{

                'importFile' = "$env:Temp\testPlatform.zip"

            }

            $response = $InputObject | Import-PASTicketingSystem

        }

        Context 'Standard Operation' {

            It 'throws if InputFile does not exist' {
                { Import-PASTicketingSystem -ImportFile SomeFile.txt } | Should -Throw
            }

            It 'throws if InputFile resolves to a folder' {
                { Import-PASTicketingSystem -ImportFile $pwd } | Should -Throw
            }

            It 'throws if InputFile does not have a zip extention' {
                { Import-PASTicketingSystem -ImportFile README.MD } | Should -Throw
            }

            It 'sends request' {

                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.ApiURI)/API/ticketing-systems/import"

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected method' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

            }

            It 'sends request with expected body' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $Script:RequestBody = $Body | ConvertFrom-Json

                    ($Script:RequestBody.ticketingZipFile) -ne $null

                } -Times 1 -Exactly -Scope It

            }

        }

    }

}