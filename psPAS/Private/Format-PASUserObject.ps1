Function Format-PASUserObject {
	<#
	.SYNOPSIS
	Creates object in the expected format for adding or updating PAS Users

	.DESCRIPTION
	From a hashtable provided as input, nests key/value pairs under expected key.
	Returns object structured as required to be converted to json and used as payload to create or update PAS user.
	Designed to be consumed by New-PASUser & Set-PASUser.

	.PARAMETER UserProperties
	A hashtable containing the key/values to create or update a PAS User

	.EXAMPLE
	$ParameterValues | Format-PASUserObject
	#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[hashtable]$UserProperties
	)

	Begin {
		$businessAddressParams = [Collections.Generic.List[String]]@('workStreet', 'workCity', 'workState', 'workZip', 'workCountry')
		$internetParams = [Collections.Generic.List[String]]@('homePage', 'homeEmail', 'businessEmail', 'otherEmail')
		$phonesParams = [Collections.Generic.List[String]]@('homeNumber', 'businessNumber', 'cellularNumber', 'faxNumber', 'pagerNumber')
		$personalDetailsParams = [Collections.Generic.List[String]]@('street', 'city', 'state', 'zip', 'country', 'title', 'organization',
			'department', 'profession', 'FirstName', 'middleName', 'LastName')
	}

	Process {

		#Clone the input hashtable
		$UserObject = $UserProperties.clone()

		#Process each key of the input hashtable
		switch ($UserProperties.keys) {

			'ExpiryDate' {

				If ($($UserProperties['ExpiryDate']).GetType().FullName -eq 'System.DateTime') {
					#Include datetime object converted into required unixtime string format
					$UserObject['ExpiryDate'] = $UserProperties['ExpiryDate'] | ConvertTo-UnixTime
				}

			}

			{ $businessAddressParams -contains $PSItem } {

				#Create businessAddress key if it does not exist
				if (-not($UserObject.ContainsKey('businessAddress'))) {
					$UserObject.Add('businessAddress', @{})
				}
				#Add as Key/Value under businessAddress
				$UserObject['businessAddress'].Add($PSItem, $UserObject[$PSItem])

			}

			{ $internetParams -contains $PSItem } {

				#Create internet key if it does not exist
				if (-not($UserObject.ContainsKey('internet'))) {
					$UserObject.Add('internet', @{})
				}
				#Add as Key/Value under internet
				$UserObject['internet'].Add($PSItem, $UserObject[$PSItem])

			}

			{ $phonesParams -contains $PSItem } {

				#Create phones key if it does not exist
				if (-not($UserObject.ContainsKey('phones'))) {
					$UserObject.Add('phones', @{})
				}
				#Add as Key/Value under phones
				$UserObject['phones'].Add($PSItem, $UserObject[$PSItem])

			}

			{ $personalDetailsParams -contains $PSItem } {

				#Create personalDetails key if it does not exist
				if (-not($UserObject.ContainsKey('personalDetails'))) {
					$UserObject.Add('personalDetails', @{})
				}
				#Add as Key/Value under personalDetails
				$UserObject['personalDetails'].Add($PSItem, $UserObject[$PSItem])

			}

		}

	}

	End {

		#Return object with expected structure & format
		$UserObject | Get-PASParameter -ParametersToRemove @($businessAddressParams + $internetParams + $phonesParams + $personalDetailsParams)

	}

}