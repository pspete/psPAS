# .ExternalHelp psPAS-help.xml
function Stop-PASCPMTask {
    [CmdletBinding(SupportsShouldProcess)]
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
        $URI = "$($psPASSession.BaseURI)/API/Accounts/$Accountid/Cancel/"

        if ($PSCmdlet.ShouldProcess($Accountid, 'Cancel CPM Task')) {

            Invoke-PASRestMethod -Uri $URI -Method POST

        }

    }#process

    end { }#end

}
