# .ExternalHelp psPAS-help.xml
function Remove-PASPTAPrivilegedUser {
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
        $URI = "$($psPASSession.BaseURI)/API/pta/API/configuration/properties/PrivilegedUsersList/$ID"

        if ($PSCmdlet.ShouldProcess($ID, 'Delete PTA Privileged User Configuration')) {

            #send request to web service
            Invoke-PASRestMethod -Uri $URI -Method DELETE

        }

    }#process

    end { }#end

}