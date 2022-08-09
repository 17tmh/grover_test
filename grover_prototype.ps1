$root = $PSScriptRoot
echo "Project home directory = $root"

# Enable anaconda installation for this session
& ~\anaconda3\shell\condabin\conda-hook.ps1
# Activate the preinstalled environment for qsharp
conda activate qsharp-env

# If there is no file "init" yet: Create it and perform initialization -> run if{...}
# If there is a file "init" already: Initialization is already done    -> run else{...}
cd $root
New-Item init 2> $null

if($?)
{
    # Clone repositories
    git clone https://code.dbis-pro1.fernuni-hagen.de/qcdev/dlgrover.git
    git clone https://code.dbis-pro1.fernuni-hagen.de/data-preparation/data-generator.git

    # Run script to generate data from WSL
    cd $root\data-generator
    git checkout smart-factory-data
    wsl python3 ./scripts/generateSmartFactory.py 0.05

    # Run docker-compose to create and start MongoDB container
    cd $root\dlgrover\dataImport
    docker-compose up -d
    # Wait until MongoDB is up and running (could take some time)
    cd $root
    python WaitForMongo.py
    # Populate database
    cd $root\dlgrover\dataImport
    python dataStoreWrapper.py
}
else
{
    # Container should already be there, just re-start it
    cd $root\dlgrover\dataImport
    docker-compose start
    # Wait until MongoDB is up and running (could take some time)
    cd $root
    python WaitForMongo.py
}

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

