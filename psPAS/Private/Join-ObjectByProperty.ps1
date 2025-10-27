function Join-ObjectByProperty {
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'PrimaryKey', Justification = 'False Positive')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'SecondaryKey', Justification = 'False Positive')]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, HelpMessage = 'Array of primary objects to merge from.')]
        [AllowNull()]
        [object[]]
        $PrimaryObjects,

        [Parameter(HelpMessage = 'Array of secondary objects to merge with. Optional.')]
        [AllowNull()]
        [object[]]
        $SecondaryObjects,

        [Parameter(Mandatory, HelpMessage = 'Property name in primary objects used for matching.')]
        [ValidateNotNullOrEmpty()]
        [string]
        $PrimaryKey,

        [Parameter(Mandatory, HelpMessage = 'Property name in secondary objects used for matching.')]
        [ValidateNotNullOrEmpty()]
        [string]
        $SecondaryKey,

        [Parameter(HelpMessage = 'Names of nested properties in secondary objects to expand into the root level.')]
        [ValidateNotNull()]
        [string[]]
        $ExpandNested
    )


    if (-not $PrimaryObjects -or $PrimaryObjects.Total -eq 0) {
        $fallbackOutput = @()

        foreach ($secondaryObject in $SecondaryObjects) {
            $flattened = [ordered]@{}

            foreach ($property in $secondaryObject.PSObject.Properties) {
                if (-not $ExpandNested -contains $property.Name) {
                    $flattened[$property.Name] = $property.Value
                }
            }

            foreach ($nestedPropertyName in $ExpandNested) {
                $nestedObject = $secondaryObject.$nestedPropertyName
                if ($nestedObject -and $nestedObject -is [PSCustomObject]) {
                    foreach ($property in $nestedObject.PSObject.Properties) {
                        if (-not $flattened.Contains($property.Name)) {
                            $flattened[$property.Name] = $property.Value
                        }
                    }
                }
            }

            $fallbackOutput += [PSCustomObject]$flattened
        }

        return $fallbackOutput
    }

    $mergedOutput = @()

    foreach ($primaryObject in $PrimaryObjects) {
        $mergedObject = [ordered]@{}

        foreach ($property in $primaryObject.PSObject.Properties) {
            $mergedObject[$property.Name] = $property.Value
        }

        $matchingSecondaryObjects = $SecondaryObjects | Where-Object {
            ($_ | Select-Object -ExpandProperty general).id -eq $primaryObject.$PrimaryKey
        }

        if ($matchingSecondaryObjects) {
            foreach ($secondaryObject in $matchingSecondaryObjects) {
                foreach ($property in $secondaryObject.PSObject.Properties) {
                    if (-not $mergedObject.Contains($property.Name) -and -not $ExpandNested -contains $property.Name) {
                        $mergedObject[$property.Name] = $property.Value
                    }
                }

                foreach ($nestedPropertyName in $ExpandNested) {
                    $nestedObject = $secondaryObject.$nestedPropertyName
                    if ($nestedObject -and $nestedObject -is [PSCustomObject]) {
                        foreach ($property in $nestedObject.PSObject.Properties) {
                            if (-not $mergedObject.Contains($property.Name)) {
                                $mergedObject[$property.Name] = $property.Value
                            }
                        }
                    }
                }
            }
        }

        $mergedOutput += [PSCustomObject]$mergedObject
    }

    return $mergedOutput
}
