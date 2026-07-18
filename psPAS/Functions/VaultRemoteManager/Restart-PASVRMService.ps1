# .ExternalHelp psPAS-help.xml
function Restart-PASVRMService {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $false,
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$BaseURI,

        [parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Vault', 'DR')]
        [string]$serviceName,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$serverAddress,

        [parameter(
            Mandatory = $false,
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$serviceUserName = 'Administrator',
        # Seems like Administrator is the only allowed username? https://docs.cyberark.com/pam-self-hosted/15.0/en/content/pasimp/vault-remote-manager.htm#Configurationrequirements
        # REST API docs however doesnt mention this so we leave it as a parameter with default value with the option to change it.

        [parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [securestring]$servicePassword
    )

    begin {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 15.0
    }#begin

    process {

        #Use the BaseURI from the session (New-PASSession) if not provided
        if (-not $PSBoundParameters.ContainsKey('BaseURI')) {
            $BaseURI = $psPASSession.BaseURI
        }

        #Create URL for request
        $URI = "$BaseURI/API/VaultActions/SetServiceStatus/Restart"

        #Get Parameters for request body
        $boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove BaseURI

        #deal with Password SecureString
        if ($PSBoundParameters.ContainsKey('servicePassword')) {

            #Include decoded password in request
            $boundParameters['servicePassword'] = $(ConvertTo-InsecureString -SecureString $servicePassword)

        }

        #Ensure serviceUserName is always included (use default if not provided)
        if (-not $PSBoundParameters.ContainsKey('serviceUserName')) {
            $boundParameters['serviceUserName'] = $serviceUserName
        }

        #Create body of request
        $body = $boundParameters | ConvertTo-Json

        if ($PSCmdlet.ShouldProcess("$serviceName on $serverAddress", 'Restart Service')) {

            #send request to web service
            $result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

            if ($null -ne $result) {

                #output returned data
                $result

            }

        }

    }#process

    end { }#end

}
