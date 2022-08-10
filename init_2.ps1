$root = $PSScriptRoot
echo "Project home directory = $root"

# Populate database
cd $root\dlgrover\dataImport
python dataStoreWrapper.py

# Stop the container
cd $root\dlgrover\dataImport
docker-compose stop

# Go back home
cd $root

# Deactivate the environment
conda deactivate