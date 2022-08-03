$root = $PSScriptRoot
echo "Project home directory = $root"

cd $root\dlgrover\dataImport
docker-compose rm --force --stop --volumes
rm -r -fo ~\apps

cd $root
rm -r -fo dlgrover
rm -r -fo data-generator
rm init
