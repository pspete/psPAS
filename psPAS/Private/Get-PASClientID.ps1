function Get-PASClientID {
	<#
.SYNOPSIS
Retrieves the CyberArk client ids valid for the connected environment

.DESCRIPTION
Used to provide tab completion for the AuthorizedInterfaces/unAuthorizedInterfaces parameters of
New-PASUser, Set-PASUser, New-PASDirectoryMapping & Set-PASDirectoryMapping.
Valid client ids vary by connected environment/version, so are retrieved from the API
rather than being a fixed list.

.EXAMPLE
Get-PASClientID

Returns the client id values valid for the connected environment

.NOTES
https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/get-client-ids.htm

#>
	[CmdletBinding()]
	[OutputType('System.String')]
	param()

	process {

		#Create request URL
		$URI = "$($psPASSession.BaseURI)/API/License/Clients"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($null -ne $result) {

			$result.clientIds

		}

	}#process

}
