function Set-PASAccount{
<#
.SYNOPSIS
Updates an existing accounts details.

.DESCRIPTION
Updates an existing accounts details.
All of the account’s property details MUST be passed to the function. 
Any current properties of the account not sent as part of the request will be removed 
from the account.
To change a property value, pass the updated value to the function. 
If changing the name or folder of a service account that has multiple dependencies (usages), 
the connection between it and its dependencies will be automatically maintained.
If changing the name or folder of an account that is linked to another account (whether logon, 
reconciliation or verification), the links will be automatically updated.

.PARAMETER AccounID
The unique ID of the account to update.
Retrieved by Get-PASAccount

.PARAMETER Folder
The folder where the account is stored.

.PARAMETER AccountName
The name of the account

.PARAMETER DeviceType
The devicetype assigned to the account. 
Ensure all required parameters are specified. 
Different device types require different parameters

.PARAMETER PlatformID
The CyberArk platform assigned to the account
Ensure all required parameters are specified. 
Different platforms require different parameters

.PARAMETER Address
The Name or Address of the machine where the account will be used

.PARAMETER Username
The Username on the target machine

.PARAMETER GroupName
A groupname with which the account will be associated
The name of the group with which the account is associated. 
To create a new group, specify the group platform ID in the GroupPlatformID property, 
then specify the group name. The group will then be created automatically.

.PARAMETER GroupPlatformID
GroupPlatformID is required if account is to be moved to a new group.

.PARAMETER Properties
Hashtable of name=value pairs

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSession

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.EXAMPLE

.INPUTS
Session Token, WebSession & BaseURI can be piped by propertyname

.OUTPUTS
None

.NOTES
Dependencies (usages) cannot be updated.
Accounts that do not have a policy ID cannot be updated.

To update account properties, "Update password properties" permission is required.
To rename accounts, "Rename accounts" permission is required.
To move accounts to a different folder, Move accounts/folders permission is required.

.LINK

#>
    [CmdletBinding()]  
    param(
        [parameter(
            Mandatory=$true,
            ValueFromPipelinebyPropertyName=$true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$AccountID,

        [parameter(
            Mandatory=$true
        )]
        [string]$Folder,

        [parameter(
            Mandatory=$false
        )]
        [string]$AccountName,

        [parameter(
            Mandatory=$false
        )]
        [string]$DeviceType,
        
        [parameter(
            Mandatory=$true
        )]
        [string]$PlatformID,

        [parameter(
            Mandatory=$false
        )]
        [string]$Address,

        [parameter(
            Mandatory=$false
        )]
        [string]$UserName,

        [parameter(
            Mandatory=$false
        )]
        [string]$GroupName,

        [parameter(
            Mandatory=$false
        )]
        [string]$GroupPlatformID,

        [parameter(
            Mandatory=$false
        )]
        [hashtable]$Properties,
          
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
        [string]$BaseURI
    )

    BEGIN{}#begin

    PROCESS{
        
        #Create URL for Request
        $URI = "$baseURI/PasswordVault/WebServices/PIMServices.svc/Accounts/$AccountID"

        #Get all parameters that will be sent in the request
        $boundParameters = $PSBoundParameters | Get-PASParameters

        if($PSBoundParameters.ContainsKey("Properties")){
        
            #Format "Properties" parameter value.
            #Array of key=value pairs required for JSON convertion
            $boundParameters["Properties"] = @($boundParameters["Properties"].getenumerator() | 
            
                foreach{$_})
        
        }

        #Create body of request
        $body = @{

                    "Accounts" = $boundParameters

                    #ensure nodes at all required depths are included in the JSON object
                } | ConvertTo-Json -Depth 3
        
        #send request to PAS web service
        $Result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body -Headers $sessionToken -WebSession $WebSession

    }#process

    END{$Result.UpdateAccountResult}#end
}