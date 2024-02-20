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

        Context 'Radius Challenge' {

            BeforeEach {

                if ($IsCoreCLR) {
                    $errorDetails = $([pscustomobject]@{'ErrorCode' = 'ITATS542I'; 'ErrorMessage' = 'Some Radius Message' } | ConvertTo-Json)
                    $statusCode = 500
                    $response = New-Object System.Net.Http.HttpResponseMessage $statusCode
                    $exception = New-Object Microsoft.PowerShell.Commands.HttpResponseException "$statusCode ($($response.ReasonPhrase))", $response
                    $errorCategory = [System.Management.Automation.ErrorCategory]::InvalidOperation
                    $errorID = 'ITATS542I'
                    $targetObject = $null
                    $errorRecord = New-Object Management.Automation.ErrorRecord $exception, $errorID, $errorCategory, $targetObject
                    $errorRecord.ErrorDetails = $errorDetails
                }
                $Script:counter = 0
                Mock -CommandName Invoke-PASRestMethod {

                    If ($Script:counter -lt 4) {

                        $Script:counter++

                        Throw $errorRecord

                    } ElseIf ($Script:counter -ge 5) {

                        Return [PSCustomObject]@{'CyberArkLogonResult' = 'SomeValue' }

                    }

                }

                Mock Read-Host -MockWith {
                    return '123456'
                }

                $Response = @{
                    'LogonRequest' = @{
                        'Body'   = [PSCustomObject]@{
                            'Password' = 'SomePasswordValue'
                        } | ConvertTo-Json
                        'Method' = 'POST'
                        'URI'    = 'Value'
                    }
                    'Message'      = 'SomeMessage'
                }

                $psPASSession.ExternalVersion = '0.0'


            }

            It 'sends expected number of requests when exception ITATS542I is raised' {
                if ($IsCoreCLR) {
                    Send-RADIUSResponse @Response
                    Assert-MockCalled Invoke-PASRestMethod -Times 5 -Exactly -Scope It
                } Else { Set-ItResult -Inconclusive }
            }

            It 'sends expected OTP' {
                if ($IsCoreCLR) {
                    Send-RADIUSResponse @Response
                    Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                        $Script:RequestBody = $Body | ConvertFrom-Json

                        $Script:RequestBody.password -eq '123456'

                    } -Times 5 -Exactly -Scope It

                } Else { Set-ItResult -Inconclusive }
            }

        }

    }

}