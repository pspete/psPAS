# .ExternalHelp psPAS-help.xml
function Resume-PASCPMAutoManagement {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [Alias('id')]
        [string]$Accountid
    )

    begin {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 15.2
    }#begin

    process {

        #Create URL for request
        $URI = "$($psPASSession.BaseURI)/API/Accounts/$Accountid/Resume/"

        Invoke-PASRestMethod -Uri $URI -Method POST

    }#process

    end { }#end

}
