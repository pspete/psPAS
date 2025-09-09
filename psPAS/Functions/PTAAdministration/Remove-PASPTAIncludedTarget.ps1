# .ExternalHelp psPAS-help.xml
Function Remove-PASPTAIncludedTarget {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$ID
    )

    BEGIN {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 14.0
    }#begin

    PROCESS {

        #Create request URL
        $URI = "$($psPASSession.BaseURI)/api/pta/API/Administration/properties/CidrInclusionList/$ID"

        if ($PSCmdlet.ShouldProcess($ID, 'Delete PTA Included Monitored Target')) {

            #send request to web service
            Invoke-PASRestMethod -Uri $URI -Method DELETE

        }

    }#process

    END { }#end

}