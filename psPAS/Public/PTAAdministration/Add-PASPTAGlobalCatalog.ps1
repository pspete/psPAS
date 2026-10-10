# .ExternalHelp psPAS-help.xml
function Add-PASPTAGlobalCatalog {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$ldap_certificate,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$ldap_server,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [boolean]$ssl,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [int]$ldap_port,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$upn,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [securestring]$ldapPassword

    )

    begin {

        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 13.0

    }#begin

    process {

        #Create URL for Request
        $URI = "$($psPASSession.BaseURI)/API/pta/API/Administration/GCConnectivity"

        #Get Parameters for request body
        $boundParameters = $PSBoundParameters | Get-PASParameter

        $boundParameters['properties'] = $($boundParameters | Get-PASParameter -ParametersToRemove ldap_certificate)

        $AccountObject = $boundParameters | Get-PASParameter -ParametersToKeep ldap_certificate, properties

        #deal with Password SecureString
        if ($PSBoundParameters.ContainsKey('ldapPassword')) {

            #Include decoded password in request
            $AccountObject['properties']['ldapPassword'] = $(ConvertTo-InsecureString -SecureString $ldapPassword)

        }

        #Create body of request
        #Send as raw UTF8 bytes rather than a String so ParameterBinding/module logging of this
        #call records a non-revealing type name instead of the literal request content.
        $body = [System.Text.Encoding]::UTF8.GetBytes($($AccountObject | ConvertTo-Json))

        #send request to PAS web service
        if ($PSCmdlet.ShouldProcess($ldap_server, 'Add PTA Global Catalog')) {

            $result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

        }

        if ($null -ne $result) {

            #Return Results
            $result

        }

    }#process

    end { }#end

}