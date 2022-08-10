$root = $PSScriptRoot
echo "Project home directory = $root"

# Switch to directory with docker-compose file
cd $root\dlgrover\dataImport 2> $null
if($?)
{
    # Remove the container including its volumes
    docker-compose rm -f -s -v
}

# Remove the downloaded repositories
cd $root
rm -r -fo dlgrover 2> $null
rm -r -fo data-generator 2> $null

