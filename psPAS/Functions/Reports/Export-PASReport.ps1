# .ExternalHelp psPAS-help.xml
Function Export-PASReport {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$data,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('XLSX', 'XLS', 'CSV')]
        [string]$ReportFormat,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateScript( { Test-Path -Path $_ -IsValid })]
		[string]$path
     )

    Begin {

        Assert-VersionRequirement -RequiredVersion 14.6

    }

    Process {

        #Create URL for Request
        #TODO: Theres probably stuff that needs doing with $data (base64 encode & URL encode?)
        $URI = "$($psPASSession.BaseURI)/API/ClassicReports?data={$data}"

        switch($ReportFormat){
            #Set ContentType based on Report Format
            'XLSX' {
                $ContentType = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
            }
            'XLS' {
                $ContentType = 'application/vnd.ms-excel'
            }
            'CSV' {
                $ContentType = 'text/csv'
            }
        }

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET -ContentType $ContentType

        #if we get a byte array
		If ($null -ne $result) {

			Out-PASFile -InputObject $result -Path $path

		}

    }

    End {}

}