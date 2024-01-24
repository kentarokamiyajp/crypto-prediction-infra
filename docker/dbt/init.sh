#!/bin/bash

# Create venv
mkdir /home/venvs
cd /home/venvs
python3 -m venv dbt_env
source /home/venvs/dbt_env/bin/activate

# install python libraries
cd /home
pip3 install -r requirements.txt

# sleep forever to keep container running
while true; do sleep 1; done