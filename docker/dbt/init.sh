#!/bin/bash

# Create venv
mkdir /home/dbtuser/venvs
cd /home/dbtuser/venvs
python3 -m venv dbt_env
source /home/dbtuser/venvs/dbt_env/bin/activate

# install python libraries
cd /home/dbtuser
pip3 install -r requirements.txt
