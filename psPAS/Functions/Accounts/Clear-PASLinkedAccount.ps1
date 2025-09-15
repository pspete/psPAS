# .ExternalHelp psPAS-help.xml
function Clear-PASLinkedAccount {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [Alias('id')]
        [string]$AccountID,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [int]$extraPasswordIndex

    )

    begin {

        Assert-VersionRequirement -RequiredVersion 12.2

    }#begin

    process {

        #Create URL for Request
        $URI = "$($psPASSession.BaseURI)/api/Accounts/$AccountID/LinkAccount/$extraPasswordIndex"

        if ($PSCmdlet.ShouldProcess($AccountID, "Clear extraPass$extraPasswordIndex Linked Account")) {

            #Send request to web service
            Invoke-PASRestMethod -Uri $URI -Method DELETE

        }

    }#process

    end { }#end

}