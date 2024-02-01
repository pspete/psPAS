# .ExternalHelp psPAS-help.xml
Function Remove-PASPTAExcludedTarget {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$ID
    )

    BEGIN {
        Assert-VersionRequirement -RequiredVersion 14.0
    }#begin

    PROCESS {

        #Create request URL
        $URI = "$Script:BaseURI/api/pta/API/Administration/properties/CidrExclusionList/$ID"

        if ($PSCmdlet.ShouldProcess($ID, 'Delete PTA Excluded Monitored Target')) {

            #send request to web service
            Invoke-PASRestMethod -Uri $URI -Method DELETE -WebSession $Script:WebSession

        }

    }#process

    END { }#end

}