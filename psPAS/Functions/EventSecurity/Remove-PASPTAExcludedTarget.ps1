# .ExternalHelp psPAS-help.xml
function Remove-PASPTAExcludedTarget {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$ID
    )

    begin {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 14.0
    }#begin

    process {

        #Create request URL
        $URI = "$($psPASSession.BaseURI)/api/pta/API/Administration/properties/CidrExclusionList/$ID"

        if ($PSCmdlet.ShouldProcess($ID, 'Delete PTA Excluded Monitored Target')) {

            #send request to web service
            Invoke-PASRestMethod -Uri $URI -Method DELETE

        }

    }#process

    end { }#end

}