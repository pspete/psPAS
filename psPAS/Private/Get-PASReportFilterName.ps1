function Get-PASReportFilterName {
	<#
.SYNOPSIS
Returns the filter names documented by CyberArk as valid for a given report task subType

.DESCRIPTION
Each report subType supported by New-PASReportTask accepts a different set of named filters.
This is a static reference used to give a soft warning (not a hard validation failure) when a
filter name is passed to New-PASReportTask that isn't documented for the specified subType -
CyberArk may add filters which are not yet reflected here, so an unrecognised name should not
block the request being sent.

.PARAMETER SubType
The report task subType to return the known/documented filter names for.

.EXAMPLE
Get-PASReportFilterName -SubType InventoryReports.InventoryReportUI

Returns the filter names documented for the "Privileged accounts" report.

.NOTES
Source: https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/create-task.htm

#>
	[CmdletBinding()]
	[OutputType('System.String')]
	param(
		[parameter(
			Mandatory = $true
		)]
		[string]$SubType
	)

	process {

		$FilterMap = @{

			#Privileged accounts
			'InventoryReports.InventoryReportUI'                                       = @(
				'accountName', 'deviceType', 'platformId', 'numberOfDays', 'activitiesOption',
				'onlyAccountsWithFailures', 'onlyDisabledAccounts', 'freeSearch', 'group',
				'includeServiceAccounts', 'safe'
			)

			#Applications
			'CyberArk.Reports.ApplicationReports.ApplicationReportUI'                  = @(
				'freeSearch', 'includeSubLocations', 'location'
			)

			#Compliance Status
			'InventoryReports.ComplianceReportUI'                                      = @(
				'accountName', 'deviceType', 'platformId', 'numberOfDays', 'activitiesOption',
				'onlyAccountsWithFailures', 'onlyDisabledAccounts', 'freeSearch', 'accountChangeMode',
				'expiresIn', 'expireOption', 'includeAboutToExpire', 'onlyExpiredAccounts', 'safe'
			)

			#Entitlement
			'CyberArk.Reports.EntitlementReport.EntitlementReportUI'                   = @(
				'includeCommandPermissions', 'includeSubLocations', 'location', 'safe',
				'includeDisabledUsers', 'includeGroups', 'targetAccount', 'targetPolicyID',
				'targetSystem', 'userOrGroup', 'userType'
			)

			#Activity log
			'CyberArk.Reports.ActivitiesReport.ActivitiesReportUI'                     = @(
				'activitiesFilter', 'clientId', 'displayOnlyAlerts', 'includeSubLocations',
				'historyOptions', 'actionsInPrevDays', 'historyFromDate', 'historyToDate',
				'location', 'safe', 'userType', 'includeDeletedUsers', 'requestId',
				'targetAccount', 'targetPolicyID', 'targetSystem', 'userOrGroup'
			)

			#License capacity - no filters are documented for this report
			'CyberArk.Reports.LicenseCapacityReport.LicenseCapacityReportUI'           = @()

			#Users
			'CyberArk.Reports.UsersReport.UsersListReportUI'                           = @(
				'includeDisabledUsers', 'includeSubLocations', 'historyOptions', 'actionsInPrevDays',
				'historyFromDate', 'historyToDate', 'location', 'userOrGroup', 'userActivityType'
			)

			#Safes
			'CyberArk.Reports.ActiveNonActiveSafesReport.ActiveNonActiveSafesReportUI' = @(
				'activitiesFilter', 'ignoreBackupActivities', 'includeSubLocations', 'historyOptions',
				'actionsInPrevDays', 'historyFromDate', 'historyToDate', 'location', 'safe', 'safeType'
			)

			#Owners
			'CyberArk.Reports.OwnersListReport.OwnersListReportUI'                     = @(
				'safe', 'userOrGroup'
			)

		}

		$FilterMap[$SubType]

	}#process

}
