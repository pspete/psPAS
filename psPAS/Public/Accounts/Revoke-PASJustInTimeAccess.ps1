# .ExternalHelp psPAS-help.xml
function Revoke-PASJustInTimeAccess {
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
        $URI = "$($psPASSession.BaseURI)/api/Accounts/$AccountID/RevokeAdministrativeAccess"

        #Send request to webservice
        if ($PSCmdlet.ShouldProcess($AccountID, 'Revoke Just In Time Access')) {

            Invoke-PASRestMethod -Uri $URI -Method POST

        }

    }#process

    end { }#end

}