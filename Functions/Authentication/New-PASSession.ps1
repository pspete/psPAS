function New-PASSession {
    <#
.SYNOPSIS
Authenticates a user to CyberArk Vault.

.DESCRIPTION
Authenticates a user to a CyberArk Vault and returns a token and a webrequest session object
that can be used in subsequent PAS Web Services calls.
In addition, this method allows you to set a new password.
Authenticate using CyberArk, LDAP or RADIUS authentication (From CyberArk version 9.7 up).
For CyberArk version older than 9.7:
    Only CyberArk Authentication method is supported.
    newPassword Parameter is not supported.
    useRadiusAuthentication Parameter is not supported.
    connectionNumber Parameter is not supported.

.PARAMETER Credential
A Valid PSCredential object.

.PARAMETER newPassword
Optional parameter, enables you to change a CyberArk users password.
Must be supplied as a SecureString (Not Plain Text).

.PARAMETER useRadiusAuthentication
Whether or not users will be authenticated via a RADIUS server.

.PARAMETER connectionNumber
In order to allow more than one connection for the same user simultaneously, each request
should be sent with different 'connectionNumber'.
Valid values: 1-100

.PARAMETER SessionVariable
After successful execution of this function, and authentication to the Vault, a WebSession
object, that contains information about the connection and the request, including cookies,
will be created and passed back in the return object.
This can be passed to subsequent requests to ensure websessions are persistant when the
PAS Web Service exists accross PVWA servers behind a load balancer.

.PARAMETER BaseURI
A string containing the base web address to send te request to.
Pass the portion the PVWA HTTP address.
Do not include "/PasswordVault/"

.PARAMETER PVWAAppName
The name of the CyberArk PVWA Virtual Directory.
Defaults to PasswordVault

.EXAMPLE
Logon with credential and save auth token:

$token = New-PASSession -Credential $cred -BaseURI https://PVWA

Request would be sent to PVWA URL https://PVWA/PasswordVault/

.EXAMPLE
Logon where PVWA Virtual Directory has non-default name:

New-PASSession -Credential $cred -BaseURI https://PVWA -PVWAAppName PasswdVlt

Request would be sent to PVWA URL https://PVWA/PasswdVlt/

.INPUTS
A PSCredential Object can be piped to this function.

.OUTPUTS
CyberArk Session token; This token identifies the session with the vault, and
is supplied to every other web service request in the same session.
A WebSession object; This contains information about the connection and the request,
including cookies. Can be supplied to other web service requests.
baseURI; this is the URL provided as an input to this function, it can be piped to
other functions from this return object.
ConnectionNumber; the connectionNumber provided to this function.

Output uses defined default properties.
To force all output to be shown, pipe to Select-Object *

.NOTES

.LINK
#>
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [PSCredential]$Credential,

        [Parameter(
            Mandatory = $false,
            ValueFromPipeline = $false
        )]
        [SecureString]$newPassword,

        [Parameter(
            Mandatory = $false,
            ValueFromPipeline = $false
        )]
        [bool]$useRadiusAuthentication,

        [Parameter(
            Mandatory = $false,
            ValueFromPipeline = $false
        )]
        [ValidateRange(1, 100)]
        [string]$connectionNumber,

        [parameter(
            Mandatory = $false,
            ValueFromPipeline = $false
        )]
        [string]$SessionVariable = "PASSession",

        [parameter(
            Mandatory = $true,
            ValueFromPipeline = $false
        )]
        [string]$BaseURI,

        [parameter(
            Mandatory = $false,
            ValueFromPipeline = $false
        )]
        [string]$PVWAAppName = "PasswordVault"
    )

    BEGIN {

        #Construct URL for request
        $URI = "$baseURI/$PVWAAppName/WebServices/auth/Cyberark/CyberArkAuthenticationService.svc/Logon"


    }#begin

    PROCESS {

        #Get request parameters
        $boundParameters = $PSBoundParameters | Get-PASParameters -ParametersToRemove Credential

        #Add user name form credential object
        $boundParameters["username"] = $($Credential.UserName)
        #Add decoded password value from credential object
        $boundParameters["password"] = $($Credential.GetNetworkCredential().Password)

        #deal with newPassword SecureString
        if($PSBoundParameters.ContainsKey("newPassword")) {

            #Create New Credential object
            $PwdUpdate = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $(

                #Assign Credential USerName and newPassword
                $Credential.UserName), $newPassword

            #Include decoded password in request
            $boundParameters["newPassword"] = $($PwdUpdate.GetNetworkCredential().Password)

        }

        #Construct Request Body
        $body = $boundParameters | ConvertTo-Json

        #Send Logon Request
        $PASSession = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -SessionVariable $SessionVariable

        #Return Object
        [pscustomobject]@{

            #Authentication Token
            "sessionToken"     = @{"Authorization" = $PASSession |

                #Required for all subsequent Web Service Calls
                Select-Object -ExpandProperty CyberArkLogonResult
            }

            #WebSession Object
            "WebSession"       = $PASSession |

            Select-Object -ExpandProperty WebSession

            #The Web Service URL the request was sent to
            "BaseURI"          = $BaseURI

            #PVWA Application Name/Virtual Directory
            "PVWAAppName"      = $PVWAAppName

            #The Connection Number
            "ConnectionNumber" = $connectionNumber

            #Set default properties to display in output
        } | Add-ObjectDetail -DefaultProperties sessionToken, BaseURI

    }#process

    END {}#end
}