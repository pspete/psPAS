function Add-PASApplicationAuthenticationMethod{
<#
.SYNOPSIS
Adds an authentication method to an application.

.DESCRIPTION
Adds a new authentication method to a specific application iin the vault.
The "Manage Users" permission is required to be held by the user running the function.

.PARAMETER AppID
The name of the application for which a new authentication method is being added.

.PARAMETER AuthType
The tye of authentication.
Valid Values are machineAddress, osUser, path, hashValue

.PARAMETER AuthValue
The content of the authentication.

.PARAMETER IsFolder
Boolean value denoting if path is a folder.
Only relevent for "Path Authentication".

.PARAMETER AllowInternalScripts
Boolean value denoting if internl scripts are allowed.
Only relevent for "Path Authentication".

.PARAMETER Comment
Note Property
only relevent for hash authentication.

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSession

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.PARAMETER PVWAAppName
The name of the CyberArk PVWA Virtual Directory.
Defaults to PasswordVault

.EXAMPLE

.INPUTS
All parameters can be piped by property name

.OUTPUTS
None

.NOTES
Function uses dynamicparameters.
Dynamic Parameters IsFolder, AllowInternalScripts & Comment do
not accept input from the pipeline.

.LINK

#>
    [CmdletBinding()]  
    param(
        [parameter(
            Mandatory=$true,
            ValueFromPipelinebyPropertyName=$true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$AppID,

        [parameter(
            Mandatory=$true,
            ValueFromPipelinebyPropertyName=$true
        )]
        [ValidateSet("path","hash","osUser","machineAddress","certificateserialnumber")]
        [string]$AuthType,

        [parameter(
            Mandatory=$true,
            ValueFromPipelinebyPropertyName=$true
        )]
        #[ValidateScript({<#[0-9a-fA-F]+CertSerialnumberValidation#>})]
        [string]$AuthValue,
          
        [parameter(
            Mandatory=$true,
            ValueFromPipelinebyPropertyName=$true
        )]
        [ValidateNotNullOrEmpty()]
        [hashtable]$sessionToken,

        [parameter(
            ValueFromPipelinebyPropertyName=$true
        )]
        [Microsoft.PowerShell.Commands.WebRequestSession]$WebSession,

        [parameter(
            Mandatory=$true,
            ValueFromPipelinebyPropertyName=$true
        )]
        [string]$BaseURI,

		[parameter(
			Mandatory=$false,
			ValueFromPipelinebyPropertyName=$true
		)]
		[string]$PVWAAppName = "PasswordVault"
    )

    DynamicParam{

        #Create a RuntimeDefinedParameterDictionary
        $Dictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
        
        #Add dynamic parameters to $dictionary
        if($AuthType -eq "path"){
            
            #parameters only relevent to path authentication
            New-DynamicParam -Name IsFolder -DPDictionary $Dictionary -Type boolean
            New-DynamicParam -Name AllowInternalScripts -DPDictionary $Dictionary -Type boolean

        }

        if(($AuthType -eq "hash") -or ($AuthType -eq "certificateserialnumber")){
            
            #add comment parmater
            New-DynamicParam -Name Comment -DPDictionary $Dictionary

        }
        
        #return RuntimeDefinedParameterDictionary
        $Dictionary

    }

    BEGIN{}#begin

    PROCESS{

        $URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Applications/$($AppID | 
        
            Get-EscapedString)/Authentications"
        
        $Body = @{
        
            "authentication" = $PSBoundParameters | Get-PASParameters

        } | ConvertTo-Json

        Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -Headers $sessionToken -WebSession $WebSession

    }#process

    END{}#end

}