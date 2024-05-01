# .ExternalHelp psPAS-help.xml
Function Add-PASPTAGlobalCatalog {
    [CmdletBinding()]
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

    BEGIN {

        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 13.0

    }#begin

    PROCESS {

        #Create URL for Request
        $URI = "$($psPASSession.BaseURI)/API/pta/API/Administration/GCConnectivity"

        #Get Parameters for request body
        $boundParameters = $PSBoundParameters | Get-PASParameter

        #deal with Password SecureString
        If ($PSBoundParameters.ContainsKey('ldapPassword')) {

            #Include decoded password in request
            $boundParameters['ldapPassword'] = $(ConvertTo-InsecureString -SecureString $ldapPassword)

        }

        $boundParameters['properties'] = $($boundParameters | Get-PASParameter -ParametersToRemove ldap_certificate)

        #Create body of request
        $body = $boundParameters | Get-PASParameter -ParametersToKeep ldap_certificate, properties | ConvertTo-Json

        #send request to PAS web service
        $result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

        If ($null -ne $result) {

            #Return Results
            $result

        }

    }#process

    END { }#end

}