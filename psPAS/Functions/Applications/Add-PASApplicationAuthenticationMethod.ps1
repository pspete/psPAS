function Add-PASApplicationAuthenticationMethod {
    <#
.SYNOPSIS
Adds an authentication method to an application.

.DESCRIPTION
Adds a new authentication method to a specific application iin the vault.
The "Manage Users" permission is required to be held by the user running the function.

.PARAMETER AppID
The name of the application for which a new authentication method is being added.

.PARAMETER path
The path to configure as an authentication method

.PARAMETER hash
A file hash to configure as an authentication method

.PARAMETER osUser
An osUser to configure as an authentication method

.PARAMETER machineAddress
Address value to configure as an authentication method

.PARAMETER certificateserialnumber
Certificate Serial Number to configure as an authentication method

.PARAMETER Subject
The content of the subject attribute.

.PARAMETER Issuer
The content of the issuer attribute

.PARAMETER SubjectAlternativeName
The content of the subject alternative name attribute
Accepts attributes "DNS Name", "IP Address", "URI", "RFC822"

.PARAMETER IsFolder
Boolean value denoting if path is a folder.

.PARAMETER AllowInternalScripts
Boolean value denoting if internal scripts are allowed.

.PARAMETER Comment
Note Property

.EXAMPLE
Add-PASApplicationAuthenticationMethod -AppID NewApp -machineAddress "AppServer1.domain.com"

Adds a Machine Address application authentication mechanism to NewApp

.EXAMPLE
Add-PASApplicationAuthenticationMethod -AppID NewApp -osUser "Domain\SomeUser"

Adds an osUSer application authentication mechanism to NewApp

.EXAMPLE
Add-PASApplicationAuthenticationMethod -AppID NewApp -path "SomePath"

Adds path application authentication mechanism to NewApp

.EXAMPLE
Add-PASApplicationAuthenticationMethod -AppID NewApp -certificateserialnumber 040000000000FA3DEFE9A9 -Comment "DEV Cert"

Adds certificateserialnumber application authentication mechanism to NewApp

.EXAMPLE
Add-PASApplicationAuthenticationMethod -AppID AppWebService -Subject "CN=application.company.com"

Adds Certificate Attribute authentication

.EXAMPLE
Add-PASApplicationAuthenticationMethod -AppID AppWebService -SubjectAlternativeName "DNS Name=application.service"

Adds Certificate Attribute authentication for certificate SAN attribute

.LINK
https://pspas.pspete.dev/commands/Add-PASApplicationAuthenticationMethod
#>
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = "path"
        )]
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = "certificateattr"
        )]
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = "certificateserialnumber"
        )]
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = "hash"
        )]
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = "osUser"
        )]
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = "machineAddress"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$AppID,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = "path"
        )]
        [string]$path,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = "hash"
        )]
        [string]$hash,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = "osUser"
        )]
        [string]$osUser,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = "machineAddress"
        )]
        [string]$machineAddress,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = "certificateserialnumber"
        )]
        [string]$certificateserialnumber,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = "certificateattr"
        )]
        [string[]]$Subject,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = "certificateattr"
        )]
        [string[]]$Issuer,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = "certificateattr"
        )]
        [string[]]$SubjectAlternativeName,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = "path"
        )]
        [boolean]$IsFolder,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = "path"
        )]
        [boolean]$AllowInternalScripts,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = "certificateattr"
        )]
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = "certificateserialnumber"
        )]
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = "hash"
        )]
        [string]$Comment
    )

    BEGIN { }#begin

    PROCESS {

        $URI = "$Script:BaseURI/WebServices/PIMServices.svc/Applications/$($AppID | Get-EscapedString)/Authentications"

        $boundParamters = $PSBoundParameters | Get-PASParameter -ParametersToRemove AppID

        #Accepted authtype names match parameterset names
        $boundParamters.Add("AuthType", $($PSCmdlet.ParameterSetName))

        #When parameterset name matches parametername
        If ($boundParamters.ContainsKey($PSCmdlet.ParameterSetName)) {

            #Rename hashtable key to "AuthValue"
            $boundParamters.Add("AuthValue", $boundParamters.$($PSCmdlet.ParameterSetName))
            $boundParamters.Remove($($PSCmdlet.ParameterSetName))

        }

        $Body = @{

            "authentication" = $boundParamters

        } | ConvertTo-Json

        Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -WebSession $Script:WebSession

    }#process

    END { }#end

}