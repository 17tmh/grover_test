$root = $PSScriptRoot
Write-Output "Project home directory = $root"

# Enable anaconda installation for this session
& ~\anaconda3\shell\condabin\conda-hook.ps1
# Activate the preinstalled environment for qsharp
conda activate qsharp-env

# Clone repository
git clone https://code.dbis-pro1.fernuni-hagen.de/qcdev/dlgrover.git

$MongoDbContainer = "MyMongo"

# Run docker-compose to create and start MongoDB container
# Set-Location $root\dlgrover\dataImport
# docker-compose up -d
docker run --rm -d -p 27018:27017 --name $MongoDbContainer -e MONGO_INITDB_ROOT_USERNAME=user -e MONGO_INITDB_ROOT_PASSWORD=user mongo:5.0.6-focal

# Wait until MongoDB is up and running (could take some time)
Set-Location $root
python WaitForMongo.py

# Populate database
Set-Location $root\dlgrover\dataImport
python dataStoreWrapper.py

# Call host script for quantum computation
Set-Location $root\dlgrover\grover\src
python service.py

# Stop the container
# Set-Location $root\dlgrover\dataImport
# docker-compose stop
docker stop $MongoDbContainer

# Go back home
Set-Location $root

# Deactivate the environment
conda deactivate

