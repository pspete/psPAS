# .ExternalHelp psPAS-help.xml
function New-PASPrivateSSHKey {
    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'Personal')]
    param(
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'Personal'
        )]
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'UserID'
        )]
        [ValidateSet('PPK', 'PEM', 'OpenSSH')]
        [string[]]$formats,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'Personal'
        )]
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'UserID'
        )]
        [securestring]$keyPassword,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'UserID'
        )]
        [int]$UserID

    )

    begin {

        Assert-VersionRequirement -RequiredVersion 12.1

    }#begin

    process {

        $URI = "$($psPASSession.BaseURI)/api/Users"

        switch ($PSCmdlet.ParameterSetName) {

            'UserID' {

                $user = $UserID
                $URI = "$URI/$UserID/Secret/SSHKeys/Cache"
                break

            }

            default {

                $user = 'Personal'
                $URI = "$URI/Secret/SSHKeys/Cache"
                break

            }

        }

        #Get Parameters to include in request
        $boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove UserName

        if ($PSBoundParameters.ContainsKey('keyPassword')) {

            #Include decoded password in request
            $boundParameters['keyPassword'] = $(ConvertTo-InsecureString -SecureString $keyPassword)

        }

        $body = $boundParameters | ConvertTo-Json

        if ($PSCmdlet.ShouldProcess($user, 'Generate Private SSH Key')) {

            #send request to webservice
            $result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

            if ($null -ne $result) {

                $result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.PrivateSSHKey

            }

        }

    }#process

    end { }#end
}