# .ExternalHelp psPAS-help.xml
Function Add-PASPTASyslog {
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [Alias('Name')]
        [string]$siem,
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('CEF', 'LEEF')]
        [string]$format,
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$host,
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [int]$port,
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('TCP', 'UDP', 'TLS')]
        [string]$protocol,
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $false
        )]
        [ValidateScript({
                if ($_ -and -not (Test-Path $_ -PathType Leaf)) {
                    throw "Certificate file does not exist: $_"
                }
                if ($_ -and $_ -notmatch '\.(crt|cer|pem)$') {
                    throw "Certificate file must have .crt, .cer, or .pem extension"
                }
                return $true
            })]
        [string]$CertificateFile,
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('RFC3164', 'RFC5424', 'SEMI_RFC5424')]
        [string]$syslogType,
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            HelpMessage = 'Enable octet-counting for syslog transmission over TCP. When enabled, the syslog message starts with its length.'
        )]
        [bool]$tcpOctetCounting
    )

    BEGIN {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 14.6
    }#begin

    PROCESS {

        #Create request URL
        $URI = "$($psPASSession.BaseURI)/api/pta/API/Administration/properties/SyslogOutboundDataList"

        # Get Parameters for request body, excluding CertificateFile
        $boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove CertificateFile

        # Handle TLS certificate encoding
        if ($protocol -eq 'TLS' -and $PSBoundParameters.ContainsKey('CertificateFile')) {
            try {
                # Read certificate file content
                $CertContent = Get-Content -Path $CertificateFile -Raw -Encoding UTF8
                
                # Convert to Base64
                $CertBytes = [System.Text.Encoding]::UTF8.GetBytes($CertContent)
                $Base64Cert = [System.Convert]::ToBase64String($CertBytes)
                
                # Add encoded certificate to body parameters
                $boundParameters['certificate'] = $Base64Cert
                
            }
            catch {
                throw "Failed to read or encode certificate file '$CertificateFile': $($_.Exception.Message)"
            }
        }

        #Create body of request
        $Body = $boundParameters | ConvertTo-Json

        #send request to PAS web service
        $result = Invoke-PASRestMethod -Uri $URI -Method PATCH -Body $Body

        If ($null -ne $result) {

            #Return Results
            $result

        }

    }#process

    END { }#end

}