# .ExternalHelp psPAS-help.xml
function Unlock-PASAccount {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('id')]
		[string]$AccountID
	)

	BEGIN { }#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/API/Accounts/$AccountID/CheckIn"

		if ($PSCmdlet.ShouldProcess($AccountID, 'Check-In Exclusive Access Account')) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method POST -WebSession $Script:WebSession

		}

	}#process

	END { }#end

}