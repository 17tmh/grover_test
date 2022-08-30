$root = $PSScriptRoot
Write-Output "Project home directory = $root"

# Populate database
Set-Location $root\dlgrover\dataImport
python dataStoreWrapper.py

# Stop the container
Set-Location $root\dlgrover\dataImport
docker-compose stop

# Go back home
Set-Location $root

# Deactivate the environment
conda deactivate