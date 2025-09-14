# .ExternalHelp psPAS-help.xml
function Add-PASPTAIncludedTarget {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$cidr
    )

    begin {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 14.0
    }#begin

    process {

        #Create request URL
        $URI = "$($psPASSession.BaseURI)/api/pta/API/Administration/properties/CidrInclusionList"

        #Create body of request
        $Body = $PSBoundParameters | Get-PASParameter | ConvertTo-Json

        if ($PSCmdlet.ShouldProcess($cidr, 'Add PTA Included Monitored Target')) {

            #send request to web service
            Invoke-PASRestMethod -Uri $URI -Method PATCH -Body $Body

        }

    }#process

    end { }#end

}