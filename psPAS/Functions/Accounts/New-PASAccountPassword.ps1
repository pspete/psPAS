# .ExternalHelp psPAS-help.xml
function New-PASAccountPassword {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('id')]
        [string]$AccountID
    )

    begin {

        #check minimum version
        Assert-VersionRequirement -RequiredVersion 12.0

    }#begin

    process {

        #Create URL for request
        $URI = "$($psPASSession.BaseURI)/api/Accounts/$AccountID/Secret/Generate"

        if ($PSCmdlet.ShouldProcess($AccountID, 'Generate New Password')) {

            #Send request to webservice
            $result = Invoke-PASRestMethod -Uri $URI -Method POST

            if ($null -ne $result) {

                #Unescape returned string.
                try {
                    $result = [System.Text.RegularExpressions.Regex]::Unescape($result.password)
                } catch { $result = $result.password }
                [PSCustomObject] @{'Password' = $result } | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Credential

            }

        }

    }#process

    end { }#end

}