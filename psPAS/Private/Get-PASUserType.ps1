function Get-PASUserType {
	<#
.SYNOPSIS
Retrieves the CyberArk user types valid for the connected environment

.DESCRIPTION
Used to provide tab completion for the AuthorizedInterfaces/unAuthorizedInterfaces parameters of
New-PASUser, Set-PASUser, New-PASDirectoryMapping & Set-PASDirectoryMapping.
Valid user types vary by connected environment/version, so are retrieved from the API
rather than being a fixed list.

.EXAMPLE
Get-PASUserType

Returns the user type values valid for the connected environment

.NOTES

#>
	[CmdletBinding()]
	[OutputType('System.String')]
	param()

	process {

		#Create request URL
		$URI = "$($psPASSession.BaseURI)/api/userTypes"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($null -ne $result) {

			$result.UserTypes

		}

	}#process

}
