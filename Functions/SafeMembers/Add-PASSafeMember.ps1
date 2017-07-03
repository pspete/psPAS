function Add-PASSafeMember{
<#
.SYNOPSIS
Adds a Safe Member to safe

.DESCRIPTION
Adds an existing user as a Safe member.
"Manage Safe Members" permission is required by the authenticated user account sending request.

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.PARAMETER SafeName
The name of the safe to add the member to

.PARAMETER MemberName
Vault or Domain User, or Group, to add as member.

.PARAMETER SearchIn
The Vault or Domain, defined in the vault, 
in which to search for the member to add to the safe.

.PARAMETER MembershipExpirationDate
Defines when the member’s Safe membership expires.
Specify "" for no expiration date.
Default to no expiration.
Must be in format MM/DD/YY

.PARAMETER UseAccounts
Boolean value defining if UseAccounts permission will be granted to 
safe member on safe.

.PARAMETER RetrieveAccounts
Boolean value defining if RetrieveAccounts permission will be granted 
to safe member on safe.

.PARAMETER ListAccounts
Boolean value defining if ListAccounts permission will be granted to 
safe member on safe.

.PARAMETER AddAccounts
Boolean value defining if permission will be granted to safe member 
on safe.

.PARAMETER UpdateAccountContent
Boolean value defining if AddAccounts permission will be granted to safe 
member on safe.

.PARAMETER UpdateAccountProperties
Boolean value defining if UpdateAccountProperties permission will be granted 
to safe member on safe.

.PARAMETER InitiateCPMAccountManagementOperations
Boolean value defining if InitiateCPMAccountManagementOperations permission 
will be granted to safe member on safe.

.PARAMETER SpecifyNextAccountContent
Boolean value defining if SpecifyNextAccountContent permission will be granted 
to safe member on safe.

.PARAMETER RenameAccounts
Boolean value defining if RenameAccounts permission will be granted to safe 
member on safe.

.PARAMETER DeleteAccounts
Boolean value defining if DeleteAccounts permission will be granted to safe 
member on safe.

.PARAMETER UnlockAccounts
Boolean value defining if UnlockAccounts permission will be granted to safe 
member on safe.

.PARAMETER ManageSafe
Boolean value defining if ManageSafe permission will be granted to safe member 
on safe.

.PARAMETER ManageSafeMembers
Boolean value defining if ManageSafeMembers permission will be granted to safe 
member on safe.

.PARAMETER BackupSafe
Boolean value defining if BackupSafe permission will be granted to safe member 
on safe.

.PARAMETER ViewAuditLog
Boolean value defining if ViewAuditLog permission will be granted to safe member 
on safe.

.PARAMETER ViewSafeMembers
Boolean value defining if ViewSafeMembers permission will be granted to safe member 
on safe.

.PARAMETER RequestsAuthorizationLevel
Integer value defining level assigned to RequestsAuthorizationLevel for safe member.
Valid Values: 0, 1 or 2 

.PARAMETER AccessWithoutConfirmation
Boolean value defining if AccessWithoutConfirmation permission will be granted to 
safe member on safe.

.PARAMETER CreateFolders
Boolean value defining if CreateFolders permission will be granted to safe member 
on safe.

.PARAMETER DeleteFolders
Boolean value defining if DeleteFolders permission will be granted to safe member 
on safe.

.PARAMETER MoveAccountsAndFolders
Boolean value defining if MoveAccountsAndFolders permission will be granted to safe 
member on safe.

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSession

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.EXAMPLE

.INPUTS
Session Token, SafeName, WebSession & BaseURI can be piped by property name

.OUTPUTS
TODO

.NOTES

.LINK
#>
    [CmdletBinding()]  
    param(
        [parameter(
            Mandatory=$true,
            ValueFromPipelinebyPropertyName=$true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$SafeName,

        [parameter(
            Mandatory=$true
        )]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({$_ -notmatch ".*(\?).*"})]
        [string]$MemberName,

        [parameter(
            Mandatory=$false
        )]
        [string]$SearchIn,

        [parameter(
            Mandatory=$false
        )]
        [ValidateScript({if($_ -match '^(0[1-9]|1[0-2])[\/](0[1-9]|[12]\d|3[01])[\/]\d{2}$'){
        $true}Else{Throw "$_ must match pattern MM/DD/YY"}})]
        [string]$MembershipExpirationDate,

        [parameter(
            Mandatory=$false
        )]
        [boolean]$UseAccounts,

        [parameter(
            Mandatory=$false
        )]
        [boolean]$RetrieveAccounts,

        [parameter(
            Mandatory=$false
        )]
        [boolean]$ListAccounts,

        [parameter(
            Mandatory=$false
        )]
        [boolean]$AddAccounts,

        [parameter(
            Mandatory=$false
        )]
        [boolean]$UpdateAccountContent,

        [parameter(
            Mandatory=$false
        )]
        [boolean]$UpdateAccountProperties,

        [parameter(
            Mandatory=$false,
            ParameterSetName="CPM"
        )]
        [boolean]$InitiateCPMAccountManagementOperations,

        [parameter(
            Mandatory=$false,
            ParameterSetName="CPM"
        )]
        [boolean]$SpecifyNextAccountContent,

        [parameter(
            Mandatory=$false
        )]
        [boolean]$DeleteAccounts,

        [parameter(
            Mandatory=$false
        )]
        [boolean]$UnlockAccounts,

        [parameter(
            Mandatory=$false
        )]
        [boolean]$ManageSafe,
        
        [parameter(
            Mandatory=$false
        )]
        [boolean]$ManageSafeMembers,

        [parameter(
            Mandatory=$false
        )]
        [boolean]$BackupSafe,

        [parameter(
            Mandatory=$false
        )]
        [boolean]$ViewAuditLog,

        [parameter(
            Mandatory=$false
        )]
        [boolean]$ViewSafeMembers,

        [parameter(
            Mandatory=$false
        )]
        [ValidateRange(0,2)]
        [int]$RequestsAuthorizationLevel,

        [parameter(
            Mandatory=$false
        )]
        [boolean]$AccessWithoutConfirmation,

        [parameter(
            Mandatory=$false
        )]
        [boolean]$CreateFolders,

        [parameter(
            Mandatory=$false
        )]
        [boolean]$DeleteFolders,

        [parameter(
            Mandatory=$false
        )]
        [boolean]$MoveAccountsAndFolders,
          
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

    BEGIN{

        #Set base Parameters the exist at the top level of required JSON object
        $baseParameters = @("MemberName","SearchIn","MembershipExpirationDate","SafeName")

        #Creaate empty hashtbale to hold permission related parameters
        $permissions=@{}

        #array for parameter names which will do not appear in the top-tier of the JSON object
        [array]$keysToRemove+="SafeName"

    }#begin

    PROCESS{

        #Create URL for request
        $URI = "$baseURI/PasswordVault/WebServices/PIMServices.svc/Safes/$($SafeName | 
        
            Get-EscapedString)/Members"
        
        #Get Parameters for request body
        $boundParameters = $PSBoundParameters | Get-PASParameters

        #For every passed permission ("Non-Base") parameter
        $boundParameters.keys | Where{$baseParameters -notcontains $_} | foreach{
            
            #Add Key=Value pair to permissions hashtable
            $permissions[$_]=$boundParameters[$_]

            #Add parameter name to array
            $keysToRemove+=$_
        
        }

        #add all required permissions  as value to "Permssions" key
        $boundParameters["Permissions"] = @($permissions.getenumerator() | foreach{$_})

        #Create required request object
        $body = @{
                    "member" = $boundParameters | 
                    
                        Get-PASParameters -ParametersToRemove $keysToRemove

                #Ensure all required JSON levels are output
                } | ConvertTo-Json -Depth 3
        
        #Send request to Web Service
        $result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -Headers $sessionToken -WebSession $WebSession

    }#process

    END{
    
        #format output
        $result.member | select MemberName, MembershipExpirationDate, SearchIn, 

            @{Name="Permissions";"Expression"={
            
                $_.Permissions|?{$_.value}|Select -ExpandProperty key}
                
            }
        
    }#end

}