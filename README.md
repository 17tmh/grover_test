# mdang_test

Powershell script for running the quantum search prototype.

## Set-Up

- Windows 10 or 11
- Powershell script execution must be enabled:
  - `Set-ExecutionPolicy -ExecutionPolicy Unrestricted`
- WSL with python3, java, maven:
- docker, docker-compose (most simple: docker-desktop for Windows)
- `py.exe`, the Python launcher for Windows, which must start a Python 3 interpreter
- Anaconda 3 (installed in your home directory); create this environment:
  - `conda create -n qsharp-env -c microsoft qsharp notebook`

## Run

- Before first run: Make sure there will be no conflicts with already existing docker containers.

```
git clone https://github.com/17tmh/mdang_test.git
cd mdang_test
.\grover_prototype.ps1
```

- Since there is no file `init`, the initialization will run (download repos, generate data and populate MongoDB)
- Further calls of `.\grover_prototype.ps1` will only cause the quantum part to execute (with the already generated data in MongoDB)
- `.\clean.ps1` removes everything (the file `init`, downloaded repos, docker container as well as the database in the Windows file system).

## Misc

- Alternative to docker-compose file:
  - `docker run --rm -d -p 27018:27017 -e MONGO_INITDB_ROOT_USERNAME=user -e MONGO_INITDB_ROOT_PASSWORD=user mongo:5.0.6-focal`