# .ExternalHelp psPAS-help.xml
Function Clear-PASLinkedAccount {
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

    BEGIN {

        Assert-VersionRequirement -RequiredVersion 12.2

    }#begin

    PROCESS {

        #Create URL for Request
        $URI = "$($psPASSession.BaseURI)/api/Accounts/$AccountID/LinkAccount/$extraPasswordIndex"

        if ($PSCmdlet.ShouldProcess($AccountID, "Clear extraPass$extraPasswordIndex Linked Account")) {

            #Send request to web service
            Invoke-PASRestMethod -Uri $URI -Method DELETE

        }

    }#process

    END { }#end

}