# .ExternalHelp psPAS-help.xml
Function Add-PASPTAPrivilegedUser {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('UNIX', 'WINDOWS', 'ORACLE', 'CLOUD_AWS', 'CLOUD_AZURE', 'APPLICATION')]
        [string]$platform,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$user
    )

    BEGIN {
        Assert-VersionRequirement -RequiredVersion 14.0
    }#begin

    PROCESS {

        #Create request URL
        $URI = "$Script:BaseURI/API/pta/API/configuration/properties/PrivilegedUsersList"

        #Create body of request
        $Body = $PSBoundParameters | Get-PASParameter | ConvertTo-Json

        if ($PSCmdlet.ShouldProcess($user, 'Add PTA Privileged User Configuration')) {

            #send request to web service
            Invoke-PASRestMethod -Uri $URI -Method PATCH -Body $Body -WebSession $Script:WebSession

        }

    }#process

    END { }#end

}