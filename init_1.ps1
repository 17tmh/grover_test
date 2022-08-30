$root = $PSScriptRoot
Write-Output "Project home directory = $root"

# Enable anaconda installation for this session
& ~\anaconda3\shell\condabin\conda-hook.ps1
# Activate the preinstalled environment for qsharp
conda activate qsharp-env

# Clone repositories
git clone https://code.dbis-pro1.fernuni-hagen.de/qcdev/dlgrover.git
git clone https://code.dbis-pro1.fernuni-hagen.de/data-preparation/data-generator.git

# Run script to generate data from WSL
Set-Location $root\data-generator
git checkout smart-factory-data
wsl python3 ./scripts/generateSmartFactory.py 0.05

# Run docker-compose to create and start MongoDB container
Set-Location $root\dlgrover\dataImport
docker-compose up -d

# Wait until MongoDB is up and running (could take some time)
Set-Location $root
python WaitForMongo.py

