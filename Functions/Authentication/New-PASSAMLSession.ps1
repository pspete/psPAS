function New-PASSAMLSession {
    <#
.SYNOPSIS
Authenticates a user to CyberArk Vault..... well it should
Development is ongoing whilst the correct format of the
token to include in the header is determined.
All tips appreciated.

.DESCRIPTION
[Currently fails to] Authenticate a user to a CyberArk Vault using SAML

.Parameter Credential
Valid Credential object

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
$token = New-PASSAMLSession -Credential $Creds -BaseURI https://PVWA.domain.com

Gets authorisation token by authenticating to CyberArk via SAML

.INPUTS
A PSCredential Object can be piped to this function.

.OUTPUTS
CyberArk Session token; This token identifies the session with the vault, and
is supplied to every other web service request in the same session.
A WebSession object; This contains information about the connection and the request,
including cookies. Can be supplied to other web service requests.
baseURI; this is the URL provided as an input to this function, it can be piped to
other functions from this return object.

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

        [parameter(
            Mandatory = $false
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
        $URI = "$baseURI/$PVWAAppName/WebServices/auth/SAML/SAMLAuthenticationService.svc/Logon"

    }#begin

    PROCESS {

        #Create base64 encoded token for header
        $Token = [System.Text.Encoding]::UTF8.GetBytes("$($Credential.UserName):$($Credential.GetNetworkCredential().Password)")
        $EncodedToken = [System.Convert]::ToBase64String($Token)

        #add token to header
        $Header = @{"Authorization" = "Basic $EncodedToken"}

        #create empty body
        $Body = @{} | ConvertTo-Json

        #Send Logon Request
        $PASSession = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -Header $Header -SessionVariable $SessionVariable

        #Return Object
        [pscustomobject]@{

            #Authentication Token
            "sessionToken" = @{"Authorization" = $PASSession |

                #Required for all subsequent Web Service Calls
                Select-Object -ExpandProperty CyberArkLogonResult
            }

            #WebSession Object
            "WebSession"   = $PASSession |

            Select-Object -ExpandProperty WebSession

            #The Web Service URL the request was sent to
            "BaseURI"      = $BaseURI

            #The PVWA App Name/Virtual Directory
            "PVWAAppName"  = $PVWAAppName

            #Set default properties to display in output
        } | Add-ObjectDetail -DefaultProperties sessionToken, BaseURI

    }#process

    END {}#end
}