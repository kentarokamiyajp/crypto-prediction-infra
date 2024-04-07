#!/bin/bash
if [ -d "${HOME}/pyvenv" ]; then
    echo "pyvenv exists already !!!"
else
    cd "${HOME}" || exit

    # create venv
    echo "Creating pyvenv ..."
    /usr/local/bin/python -m venv pyvenv
    echo "Done"
    source "${HOME}/pyvenv/bin/activate"

    # install libraries
    pip install -r "${HOME}/src/requirements.txt"

    # chanage ower
    sudo chown "$(whoami)" "${HOME}/spark/logs/"

    cat /home/batch/init_bashrc >>/home/batch/.bashrc
fi
