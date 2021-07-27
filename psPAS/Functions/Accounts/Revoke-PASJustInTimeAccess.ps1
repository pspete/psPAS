# .ExternalHelp psPAS-help.xml
function Revoke-PASJustInTimeAccess {
    [CmdletBinding()]
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
        $URI = "$Script:BaseURI/api/Accounts/$AccountID/RevokeAdministrativeAccess"

        #Send request to webservice
        Invoke-PASRestMethod -Uri $URI -Method POST -WebSession $Script:WebSession

    }#process

    END { }#end

}