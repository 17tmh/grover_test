$root = $PSScriptRoot
echo "Project home directory = $root"

# If there is no file "init" yet: Create it and perform initialization -> run if{...}
# If there is a file "init" already: Initialization is already done    -> run else{...}
cd $root
New-Item init

if($?)
{
    # Clone repositories
    git clone https://code.dbis-pro1.fernuni-hagen.de/qcdev/dlgrover.git
    git clone https://code.dbis-pro1.fernuni-hagen.de/data-preparation/data-generator.git

    # Run Python script within WSL
    cd $root\data-generator
    git checkout smart-factory-data
    wsl python3 ./scripts/generateSmartFactory.py 0.05

    # Run docker-compose to create and start MongoDB container
    cd $root\dlgrover\dataImport
    docker-compose up -d
    # Wait until MondoDB is up and running (py.exe = Python launcher for Windows)
    cd $root
    py WaitForMongo.py
    # Populate database (py.exe = Python launcher for Windows)
    cd $root\dlgrover\dataImport
    py dataStoreWrapper.py
}
else
{
    # Container should already be there, just re-start it
    cd $root\dlgrover\dataImport
    docker-compose start
    # Wait until MondoDB is up and running (py.exe = Python launcher for Windows)
    cd $root
    py WaitForMongo.py
}

# Enable anaconda installation for this session
& ~\anaconda3\shell\condabin\conda-hook.ps1
# Enable the preinstalled environment for qsharp (hint: needs pymongo as well!)
conda activate qsharp-env

# Call host script for quantum computation with the Python interpreter from qusharp-env
cd $root\dlgrover\grover\src
Python service.py

# Deactivate the environment
conda deactivate

# Stop the container
cd $root\dlgrover\dataImport
docker-compose stop

# Go back home
cd $root

