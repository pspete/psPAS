# .ExternalHelp psPAS-help.xml
function Remove-PASPrivateSSHKey {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [int]$UserID

    )

    begin {

        Assert-VersionRequirement -RequiredVersion 12.1

    }#begin

    process {

        $URI = "$($psPASSession.BaseURI)/api/Users"

        if ($PSBoundParameters.ContainsKey('UserID')) {

            $user = $UserID
            $URI = "$URI/$UserID/Secret/SSHKeys/Cache"


        }

        else {

            $user = 'Personal'
            $URI = "$URI/Secret/SSHKeys/Cache"

        }
        if ($PSCmdlet.ShouldProcess($user, 'Delete Private SSH Key')) {

            #send request to webservice
            Invoke-PASRestMethod -Uri $URI -Method DELETE

        }

    }#process

    end { }#end
}