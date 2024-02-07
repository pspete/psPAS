# .ExternalHelp psPAS-help.xml
function Get-PASAccountPasswordVersion {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('id')]
        [string]$AccountID,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $false
        )]
        [boolean]$showTemporary
    )

    BEGIN {

        #check minimum version
        Assert-VersionRequirement -RequiredVersion 12.1

    }#begin

    PROCESS {

        #Create URL for request
        $URI = "$($psPASSession.BaseURI)/api/Accounts/$AccountID/Secret/Versions"

        $boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove AccountID

        #Create Query String, escaped for inclusion in request URL
        $queryString = $boundParameters | ConvertTo-QueryString

        If ($null -ne $queryString) {

            #Build URL from base URL
            $URI = "$URI`?$queryString"

        }

        #Send request to webservice
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        If ($null -ne $result) {

            #Return Results
            $result.Versions | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Credential.Version -PropertyToAdd @{

                'AccountID' = $AccountID

            }

        }

    }#process

    END { }#end

}