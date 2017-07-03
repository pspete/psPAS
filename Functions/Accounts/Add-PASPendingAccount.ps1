function Add-PASPendingAccount{
<#
.SYNOPSIS
Adds discovered account or SSH key as a pending account in the accounts feed.

.DESCRIPTION
Enables an account or SSH key that is idscovered by an external scanner to be added
as a pending account to the Accounts Feed.
The faciliates the privileged account workflow, during which users can identify 
privileged accounts and determine which are onboarded to the vault.eters in the required format.

.PARAMETER UserName
The safe where the account will be created

.PARAMETER Address
The name or address of the machine where the account is used.

.PARAMETER AccountDiscoveryDate
The date when the account was discovered.
This parameter uses the following standard:
    YYYY-MM-DDThh:mm:ssZ

.PARAMETER OSType
The OS where the password was discovered.
Windows or Unix

.PARAMETER AccountEnabled
The account status in the discovery source.

.PARAMETER AccountOSGroups
The name of the group that the account belongs to

.PARAMETER AccountType
Account Type

.PARAMETER DiscoveryPlatformType
Platform where discovered account is used

.PARAMETER Domain
The domain of the account.

.PARAMETER LastLogonDate
Date, according to discovery source, when the account was last used to logon.

.PARAMETER LastPasswordSet
Date, according to discovery source, when the password for the account was last set 

.PARAMETER PasswordNeverExpires
If the password will ever expire in the discovery source

.PARAMETER OSVersion
OS Version where the account was discovered

.PARAMETER OU
OU of the account

.PARAMETER AccountCategory
Whether the discovered account is privileged or non-privileged.

.PARAMETER AccountCategoryCriteria
Criteria that determines whether or not the discovered account is privileged. 
For example, the user or groupname, etc.
Separate multiple strings with ";".

.PARAMETER UserDisplayName
User's display name

.PARAMETER AccountDescription
A description of the user, as defined in the discovery source. 
This will be saved as an account after it is added to the pending accounts.

.PARAMETER AccountExpirationDate
The account expiration date defined in the discovery source.

.PARAMETER UID
The unique User ID

.PARAMETER GID
The Unique Group ID

.PARAMETER MachineOSFamily
The type of machine where the account was discovered.

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

.LINK

#>
    [CmdletBinding()]  
    param(
        [parameter(
            Mandatory=$true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$UserName,

        [parameter(
            Mandatory=$true
        )]
        [string]$Address,

        [parameter(
            Mandatory=$true
        )]
        [string]$AccountDiscoveryDate,

        [parameter(
            Mandatory=$false
        )]
        [ValidateSet("Windows","Unix")]
        [string]$OSType,

        [parameter(
            Mandatory=$true
        )]
        [ValidateSet("enabled","disabled")]
        [string]$AccountEnabled,

        [parameter(
            Mandatory=$false
        )]
        [string]$AccountOSGroups,

        [parameter(
            Mandatory=$false
        )]
        [ValidateSet("domain","local")]
        [string]$AccountType,

        [parameter(
            Mandatory=$false
        )]
        [string]$DiscoveryPlatformType,
        
        [parameter(
            Mandatory=$false
        )]
        [string]$Domain,

        [parameter(
            Mandatory=$false
        )]
        [string]$LastLogonDate,

        [parameter(
            Mandatory=$false
        )]
        [string]$LastPasswordSet,

        [parameter(
            Mandatory=$false
        )]
        [boolean]$PasswordNeverExpires,

        [parameter(
            Mandatory=$false
        )]
        [string]$OSVersion,

        [parameter(
            Mandatory=$false
        )]
        [string]$OU,

        [parameter(
            Mandatory=$false
        )]
        [ValidateSet("Privileged","Non-privileged")]
        [string]$AccountCategory,

        [parameter(
            Mandatory=$false
        )]
        [string]$AccountCategoryCriteria,

        [parameter(
            Mandatory=$false
        )]
        [string]$UserDisplayName,

        [parameter(
            Mandatory=$false
        )]
        [string]$AccountDescription,

        [parameter(
            Mandatory=$false
        )]
        [string]$AccountExpirationDate,
        
        [parameter(
            Mandatory=$false
        )]
        
        [string]$UID,
        [parameter(
            Mandatory=$false
        )]
        [string]$GID,

        [parameter(
            Mandatory=$false
        )]
        [ValidateSet("Workstation","Server")]
        [string]$MachineOSFamily,
                  
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
        $URI = "$baseURI/PasswordVault/WebServices/PIMServices.svc/PendingAccounts"

        #Get all parameters that will be sent in the request
        $boundParameters = $PSBoundParameters | Get-PASParameters
        
        #Create body of request
        $body = @{

                    #pendingaccount node
                    "pendingaccount" = $boundParameters | Get-PASParameters

                    #JSON object
                } | ConvertTo-Json
        
        #send request to PAS web service
        Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -Headers $sessionToken -WebSession $WebSession

    }#process

    END{}#end
}