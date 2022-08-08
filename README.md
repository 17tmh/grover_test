# mdang_test

## Run under Windows / WSL

- Powershell script execution must be enabled:
  - `Set-ExecutionPolicy -ExecutionPolicy Unrestricted`
- What you need:
  - WSL with python3, java, maven:
  - docker, docker-compose (most simple: docker-desktop for Windows)
  - `py.exe`, the Python launcher for Windows, which must start a Python 3 interpreter
  - Anaconda 3 (installed in your home directory); create this environment:
    - `conda create -n qsharp-env -c microsoft qsharp notebook`

## misc

- Alternative to docker-compose file:
  - `docker run --rm -d -p 27018:27017 -e MONGO_INITDB_ROOT_USERNAME=user -e MONGO_INITDB_ROOT_PASSWORD=user mongo:5.0.6-focal`