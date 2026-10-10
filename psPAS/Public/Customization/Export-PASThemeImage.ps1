# .ExternalHelp psPAS-help.xml
function Export-PASThemeImage {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$imageName,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [ValidateScript( { Test-Path -Path $_ -IsValid })]
        [string]$Path

    )

    begin {

        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 14.4

    }#begin

    process {

        #Create URL for request
        $URI = "$($psPASSession.BaseURI)/API/Images/$imageName/"

        #Request body
        $Body = $PSBoundParameters | Get-PASParameter -ParametersToKeep imageName | ConvertTo-Json

        #send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET -Body $Body

        #if we get a byte array
        if ($null -ne $result) {

            Out-PASFile -InputObject $result -Path $Path

        }

    }#process

    end { }#end
}