# .ExternalHelp psPAS-help.xml
function Get-PASAccountDetail {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'Gen2ID'
        )]
        [Alias('AccountID')]
        [string]$id
    )

    BEGIN {
        #check minimum version (10.4 assumed)
        Assert-VersionRequirement -RequiredVersion 10.4
    }#begin

    PROCESS {

        #define base URL
        $URI = "$Script:BaseURI/api/ExtendedAccounts/$id/overview"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

        If ($null -ne $result) {
            $result
        }

    }#process

    END { }#end

}