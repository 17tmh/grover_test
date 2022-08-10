# grover_test

Powershell script for running the quantum search prototype.

## Set-Up

- Windows 10 or 11
- Powershell script execution must be enabled. Something like that:
  - `Set-ExecutionPolicy -ExecutionPolicy Unrestricted`
- WSL (Windows Subsystem for Linux) with `python3`, `java`, `maven`
- `docker`, `docker-compose` (most simple: docker-desktop for Windows)
- `Python`, most simple: Anaconda 3 (installed in home directory)
  - Create environment by running (last command for populating local package cache with all required QDK components):

```
conda create -n qsharp-env -c microsoft qsharp notebook
conda install -n qsharp-env pymongo
conda activate qsharp-env
python -c "import qsharp"
```

## Run

- Before first run: Make sure there will be no conflicts with already existing docker containers.
- Perform the following sequence in Powershell:
- Clone this repo: `git clone https://github.com/17tmh/grover_test.git; cd grover_test`
- Run `.\init_1.ps`
- Open `grover_test\data-generator\datasets\smart-factory0_05\Container.json`
- Manually change the values of `light` so that ...
  - ... each value occurs only once (unique).
  - ... the value `7` is used (this is the value that is searched for!)
- Run `.\init_2.ps`
- Run `.\run_grover.ps1` to perform the quantum search (you may repeat that step as many times as you like)
  - To perform the quantum search multiple times in a run:
    - Open `grover_test\dlgrover\grover\src\config.py`
    - Change `nExperiements = 1`
- Run `.\clean.ps1` to remove everything (downloaded repos, docker container)

## TODO

- Automate the manual adjustments in `Container.json`
