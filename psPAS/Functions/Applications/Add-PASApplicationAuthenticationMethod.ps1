# .ExternalHelp psPAS-help.xml
function Add-PASApplicationAuthenticationMethod {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'path'
        )]
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'certificateattr'
        )]
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'certificateserialnumber'
        )]
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'hash'
        )]
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'osUser'
        )]
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'machineAddress'
        )]
        [ValidateNotNullOrEmpty()]
        [string]$AppID,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'path'
        )]
        [string]$path,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'hash'
        )]
        [string]$hash,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'osUser'
        )]
        [string]$osUser,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'machineAddress'
        )]
        [string]$machineAddress,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'certificateserialnumber'
        )]
        [string]$certificateserialnumber,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'certificateattr'
        )]
        [string[]]$Subject,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'certificateattr'
        )]
        [string[]]$Issuer,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'certificateattr'
        )]
        [string[]]$SubjectAlternativeName,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'path'
        )]
        [boolean]$IsFolder,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'path'
        )]
        [boolean]$AllowInternalScripts,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'certificateattr'
        )]
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'certificateserialnumber'
        )]
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'hash'
        )]
        [string]$Comment
    )

    BEGIN { }#begin

    PROCESS {

        $URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Applications/$($AppID | Get-EscapedString)/Authentications/"

        $boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove AppID

        #Accepted authtype names match parameterset names
        $boundParameters.Add('AuthType', $($PSCmdlet.ParameterSetName))

        #When parameterset name matches parametername
        If ($boundParameters.ContainsKey($PSCmdlet.ParameterSetName)) {

            #Rename hashtable key to "AuthValue"
            $boundParameters.Add('AuthValue', $boundParameters.$($PSCmdlet.ParameterSetName))
            $boundParameters.Remove($($PSCmdlet.ParameterSetName))

        }

        $Body = @{

            'authentication' = $boundParameters

        } | ConvertTo-Json

        Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

    }#process

    END { }#end

}