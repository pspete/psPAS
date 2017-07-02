function Get-PASAccount{
<#
.SYNOPSIS
Returns information about an account.

.DESCRIPTION
Returns information about an account. If more than one account meets the search criteria, 
only the first account will be returned (the Count output parameter will display the number 
of accounts that were found).
Only the following users can access this account:
    - Users who are members of the Safe where the account is stored
    - Users who have access to this specific account.
    - The user who runs this web service requires the following permission in the Safe:
    - Retrieve account
This method does not display the actual password.
If ten or more accounts are found, the Count Output parameter will show 10.

.PARAMETER Keywords
Keyword to search for. 
If multiple keywords are specified, the search will include all the keywords. 
Separate keywords with a space.

.PARAMETER Safe
The name of a Safe to search. The search will be carried out only in the Safes in the Vault
that the authnticated used is authorized to access.

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSession

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.EXAMPLE

.INPUTS
sessionToken, WebSession, BaseURI can be piped by property name

.OUTPUTS
AccountID, Account Safe, Safe Folder, Account Name,
and any other set property of the account are contained in output.

.NOTES
.LINK
#>
    [CmdletBinding()]  
    param(
        [parameter(
            Mandatory=$false
        )]
        [ValidateLength(0,500)]
        [string]$Keywords,

        [parameter(
            Mandatory=$false
        )]
        [ValidateLength(0,28)]
        [string]$Safe,
          
        [parameter(
            Mandatory=$true,
            ValueFromPipelinebyPropertyName=$true
        )]
        [ValidateNotNullOrEmpty()]
        [hashtable]$sessionToken,

        [parameter(ValueFromPipelinebyPropertyName=$true)]
        [Microsoft.PowerShell.Commands.WebRequestSession]$WebSession,

        [parameter(
            Mandatory=$true,
            ValueFromPipelinebyPropertyName=$true
        )]
        [string]$BaseURI

    )

    BEGIN{}#begin

    PROCESS{

        #Get Parameters to include in request
        $boundParameters = $PSBoundParameters | Get-PASParameters

        #Create Query String, escaped for inclusion in request URL
        $query = ($boundParameters.keys | foreach{
        
            "$_=$($boundParameters[$_] | Get-EscapedString)"
            
        }) -join '&'
        
        #Create request URL
        $URI = "$baseURI/PasswordVault/WebServices/PIMServices.svc/Accounts?$query"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession
        
        #Get count of accounts found
        $count = $($result.count)

        Write-Verbose "Accounts Found: $count"

        #If accounts found
        if($count -gt 0){
            
            #If multiple accounts found
            if($count -gt 1){
                
                #Alert that web service only displays information on first result
                Write-Warning "$count matching accounts found. Only the first result will be returned"
                
            }

            #Get account details from search result
            $account = ($result | select accounts).accounts

            #Get account properties from found account
            $properties = ($account | select -ExpandProperty properties)

            #Create output object
            $return = New-object -TypeName psobject -Property @{
                
                #Internal Unique ID of Account
                "AccountID" = $($account | select -ExpandProperty AccountID)

                #Number of accounts found by query
                #"Count" = $count

            }
            
            #For every account property
            For($int=0;$int -lt $properties.length;$int++){
           
                $return | 
                    
                    #Add each property name and value to results
                    Add-ObjectDetail -PropertyToAdd @{$properties[$int].key=$properties[$int].value} -Passthru $false
           
            }

        }
        
    }#process

    END{
    
        #Return Results
        $return
        
    }#end

}