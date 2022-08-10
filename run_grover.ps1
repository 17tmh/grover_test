$root = $PSScriptRoot
echo "Project home directory = $root"

# Enable anaconda installation for this session
& ~\anaconda3\shell\condabin\conda-hook.ps1
# Activate the preinstalled environment for qsharp
conda activate qsharp-env

# Container should already be there, just re-start it
cd $root\dlgrover\dataImport
docker-compose start

# Wait until MongoDB is up and running (could take some time)
cd $root
python WaitForMongo.py

# Call host script for quantum computation
cd $root\dlgrover\grover\src
python service.py

# Stop the container
cd $root\dlgrover\dataImport
docker-compose stop

# Go back home
cd $root

# Deactivate the environment
conda deactivate