$root = $pwd
echo "Project home directory = $root"

$git_clone = $true
if($git_clone)
{
    git clone https://code.dbis-pro1.fernuni-hagen.de/qcdev/dlgrover.git
    git clone https://code.dbis-pro1.fernuni-hagen.de/data-preparation/data-generator.git
}
else
{
    mkdir dlgrover\dataImport
    mkdir data-generator
}

cd data-generator
git checkout smart-factory-data
wsl python3 ./scripts/generateSmartFactory.py 0.05

cd ..\dlgrover\dataImport
# docker-compose up -d

# sleep 3
# py dataStoreWrapper.py
# sleep 1
# py dataStoreWrapper.py

# docker-compose down
# rm -r -fo ~\apps

#cd ..\grover\src
# & $env:HOMEPATH\anaconda3\shell\condabin\conda-hook.ps1
#conda activate qsharp-env
#python service.py

#sleep 3
#docker-compose down

# cd $root
# rm -r -fo dlgrover
# rm -r -fo data-generator
