# .ExternalHelp psPAS-help.xml
function Set-PASPTASMTP {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$host,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('NONE', 'SSL', 'STARTTLS')]
        [string]$protocol,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [int]$port,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$sender,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string[]]$recipients,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            HelpMessage = 'Specify an AccountID for authenticationMethod. If not provided, no authentication to SMTP will be used.'
        )]
        [string]$accountId,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $false
        )]
        [ValidateScript({
                if ($_ -and -not (Test-Path $_ -PathType Leaf)) {
                    throw "Certificate file does not exist: $_"
                }
                if ($_ -and $_ -notmatch '\.(crt|cer|pem)$') {
                    throw 'Certificate file must have .crt, .cer, or .pem extension'
                }
                return $true
            })]
        [string]$CertificateFile,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateRange(0, 100)]
        [int]$AlertToEmailScoreThreshold
    )

    begin {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 14.4

        # Validate certificate requirement for non-NONE protocols
        if ($protocol -ne 'NONE' -and -not $PSBoundParameters.ContainsKey('CertificateFile')) {
            throw "Certificate file is required when protocol is not 'NONE'"
        }
    }#begin

    process {

        #Create request URL
        $URI = "$($psPASSession.BaseURI)/api/pta/API/Administration/properties"

        # Build authenticationMethod based on whether accountId is provided
        #TODO: Add option to use Basic Auth with username/password
        $authMethod = @{}
        if ($PSBoundParameters.ContainsKey('accountId') -and -not [string]::IsNullOrEmpty($accountId)) {
            $authMethod['accountId'] = $accountId
        }

        # Build the SMTP connectivity details
        $smtpDetails = @{
            host                 = $host
            protocol             = $protocol
            port                 = $port
            sender               = $sender
            recipients           = $recipients
            authenticationMethod = $authMethod
        }

        # Handle certificate encoding for SSL/STARTTLS
        if ($protocol -ne 'NONE' -and $PSBoundParameters.ContainsKey('CertificateFile')) {
            try {
                # Read certificate file content
                $CertContent = Get-Content -Path $CertificateFile -Raw -Encoding UTF8

                # Convert to Base64
                $CertBytes = [System.Text.Encoding]::UTF8.GetBytes($CertContent)
                $Base64Cert = [System.Convert]::ToBase64String($CertBytes)

                # Add encoded certificate to SMTP details
                $smtpDetails['certificate'] = $Base64Cert

            } catch {
                throw "Failed to read or encode certificate file '$CertificateFile': $($_.Exception.Message)"
            }
        }

        # Build the payload structure
        $payload = @(
            @{
                key   = 'SMTPConnectivityDetails'
                value = $smtpDetails
            },
            @{
                key   = 'AlertToEmailScoreThreshold'
                value = $AlertToEmailScoreThreshold
            }
        )

        #Create body of request
        $Body = $payload | ConvertTo-Json -Depth 5

        if ($PSCmdlet.ShouldProcess($ID, 'Set PTA SMTP')) {

            #send request to PAS web service
            $result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body


            if ($null -ne $result) {

                #Return Results
                $result

            }

        }

    }#process

    end { }#end

}