# .ExternalHelp psPAS-help.xml
Function Add-PASPTAExcludedTarget {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$cidr
    )

    BEGIN {
        Assert-VersionRequirement -RequiredVersion 14.0
    }#begin

    PROCESS {

        #Create request URL
        $URI = "$Script:BaseURI/api/pta/API/Administration/properties/CidrExclusionList"

        #Create body of request
        $Body = $PSBoundParameters | Get-PASParameter | ConvertTo-Json

        if ($PSCmdlet.ShouldProcess($cidr, 'Add PTA Excluded Monitored Target')) {

            #send request to web service
            Invoke-PASRestMethod -Uri $URI -Method PATCH -Body $Body -WebSession $Script:WebSession

        }

    }#process

    END { }#end

}