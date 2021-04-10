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

    BEGIN {

        #check minimum version
        Assert-VersionRequirement -RequiredVersion 12.0

    }#begin

    PROCESS {

        #Create URL for request
        $URI = "$Script:BaseURI/api/Accounts/$AccountID/Secret/Generate"

        if ($PSCmdlet.ShouldProcess($AccountID, 'Generate New Password')) {

            #Send request to webservice
            $result = Invoke-PASRestMethod -Uri $URI -Method POST -WebSession $Script:WebSession

            if ($null -ne $result) {

                #Unescape returned string.
                $result = [System.Text.RegularExpressions.Regex]::Unescape($result.password)

                [PSCustomObject] @{'Password' = $result } | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Credential

            }

        }

    }#process

    END { }#end

}