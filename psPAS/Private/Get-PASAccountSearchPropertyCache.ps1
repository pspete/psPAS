function Get-PASAccountSearchPropertyCache {
	<#
	.SYNOPSIS
	Returns Account search properties for the current session, caching the result to avoid repeat API calls

	.DESCRIPTION
	Get-PASAccount calls this from both its dynamicparam and begin blocks, and dynamicparam blocks can also be
	evaluated by PowerShell outside of an actual invocation (tab-completion, IntelliSense) - each of those would
	otherwise trigger a live call to the AdvancedSearchProperties endpoint via Get-PASAccountSearchProperty.

	The result is cached on $psPASSession, keyed by BaseURI and ExternalVersion, and is only refreshed if the
	connection has changed since the cache was populated.

	.EXAMPLE
	Get-PASAccountSearchPropertyCache

	Returns cached account search properties, populating the cache first if required.
	#>
	[CmdletBinding()]
	param()

	process {

		$Cache = $script:psPASSession.AccountSearchProperties

		if (($null -eq $Cache) -or
			($Cache.BaseURI -ne $script:psPASSession.BaseURI) -or
			($Cache.ExternalVersion -ne $script:psPASSession.ExternalVersion)) {

			$script:psPASSession.AccountSearchProperties = [PSCustomObject]@{
				BaseURI         = $script:psPASSession.BaseURI
				ExternalVersion = $script:psPASSession.ExternalVersion
				Properties      = Get-PASAccountSearchProperty
			}

		}

		$script:psPASSession.AccountSearchProperties.Properties

	}

}
