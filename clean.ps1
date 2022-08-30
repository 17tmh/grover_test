$root = $PSScriptRoot
Write-Output "Project home directory = $root"

# Switch to directory with docker-compose file
Set-Location $root\dlgrover\dataImport 2> $null
if($?)
{
    # Remove the container including its volumes
    docker-compose rm -f -s -v
}

# Remove the downloaded repositories
Set-Location $root
Remove-Item -r -fo dlgrover 2> $null
Remove-Item -r -fo data-generator 2> $null

