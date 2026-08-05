# Class definition for Report task filters

class TaskFilter {
    [string]$name
    [string]$value

    TaskFilter([string]$name = $null, [string]$value = $null) {
        $this.name = $name
        $this.value = $value
    }
}

$null = [TaskFilter]
