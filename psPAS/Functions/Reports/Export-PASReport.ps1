# .ExternalHelp psPAS-help.xml
Function Export-PASReport {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$Safe,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [Alias('location')]
        [string]$Folder,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$FileName,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$Type,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $false
        )]
        [ValidateSet('XLSX', 'XLS', 'CSV')]
        [string]$ReportFormat,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $false
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
        $URI = "$($psPASSession.BaseURI)/API/ClassicReports"

        $boundParameters = [ordered]@{
            Safe = $Safe
            Folder = $Folder
            Name = $FileName
            Format = $null
            Type = $Type
        }

        switch($ReportFormat){
            #Set ContentType based on Report Format
            'XLSX' {
                $ContentType = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
                $boundParameters['Format'] = 'excel'
            }
            'XLS' {
                $ContentType = 'application/vnd.ms-excel'
                $boundParameters['Format'] = 'excel'
            }
            'CSV' {
                $ContentType = 'text/csv'
                $boundParameters['Format'] = 'csv'
            }
        }

        #Create Query String, escaped for inclusion in request URL
        $queryString = $boundParameters | ConvertTo-QueryString -NoEscape -Delimiter '^@^' -Base64Encode -URLEncode

        If ($null -ne $queryString) {

            #Build URL from base URL
            $URI = "$URI`?data=$queryString"

        }

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET -ContentType $ContentType

        #if we get a byte array
		If ($null -ne $result) {

            switch($ReportFormat){
                #Set ContentType based on Report Format
                'CSV' {
                    $result | ConvertFrom-Csv | Export-Csv -Path $path -NoTypeInformation
                    Get-Item -Path $path
                    break
                }
                Default {
                    Out-PASFile -InputObject $result -Path $path
                    break
                }
            }

		}

    }

    End {}

}