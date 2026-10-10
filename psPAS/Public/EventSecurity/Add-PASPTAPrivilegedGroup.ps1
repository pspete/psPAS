# .ExternalHelp psPAS-help.xml
function Add-PASPTAPrivilegedGroup {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$domain,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$group
    )

    begin {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 14.0
    }#begin

    process {

        #Create request URL
        $URI = "$($psPASSession.BaseURI)/API/pta/API/configuration/properties/PrivilegedDomainGroupsList"

        #Create body of request
        $Body = $PSBoundParameters | Get-PASParameter | ConvertTo-Json

        if ($PSCmdlet.ShouldProcess($group, 'Add PTA Privileged Domain Group Configuration')) {

            #send request to web service
            Invoke-PASRestMethod -Uri $URI -Method PATCH -Body $Body

        }

    }#process

    end { }#end

}