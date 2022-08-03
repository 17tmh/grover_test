$root = $PSScriptRoot
echo "Project home directory = $root"

cd $root
New-Item init

if($?)
{
    git clone https://code.dbis-pro1.fernuni-hagen.de/qcdev/dlgrover.git
    git clone https://code.dbis-pro1.fernuni-hagen.de/data-preparation/data-generator.git

    cd $root\data-generator
    git checkout smart-factory-data
    wsl python3 ./scripts/generateSmartFactory.py 0.05
    
    cd $root\dlgrover\dataImport
    docker-compose up -d
    #docker run --rm -d -p 27018:27017 -e MONGO_INITDB_ROOT_USERNAME=user -e MONGO_INITDB_ROOT_PASSWORD=user mongo:5.0.6-focal
    cd $root
    py WaitForMongo.py
    cd $root\dlgrover\dataImport
    py dataStoreWrapper.py
}
else
{
    cd $root\dlgrover\dataImport
    docker-compose start
    cd $root
    py WaitForMongo.py
}

& ~\anaconda3\shell\condabin\conda-hook.ps1
conda activate qsharp-env

#cd $root\dlgrover\grover\src
#python service.py


#cd $root\dlgrover\dataImport
#docker-compose stop

