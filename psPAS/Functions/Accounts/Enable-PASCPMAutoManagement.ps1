# .ExternalHelp psPAS-help.xml
function Enable-PASCPMAutoManagement {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('id')]
		[string]$AccountID

	)

	BEGIN {

		Assert-VersionRequirement -RequiredVersion 10.4

		$ops = [Collections.Generic.List[Object]]@(
			@{
				'path'  = '/secretManagement/automaticManagementEnabled'
				'op'    = 'replace'
				'value' = $true
			},
			@{
				'path'  = '/secretManagement/manualManagementReason'
				'op'    = 'replace'
				'value' = ''
			}
		)

	}#begin

	PROCESS {

		Set-PASAccount -AccountID $AccountID -operations $ops

	}#process

	END { }#end

}