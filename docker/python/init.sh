#!/bin/bash
if [ -d "/home/pyuser/.pyenv" ];
then
    echo "pyenv already exists"
else
    cd /home/pyuser || exit

    # install pyenv
    git clone https://github.com/pyenv/pyenv.git /home/pyuser/.pyenv
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    if command -v pyenv 1>/dev/null 2>&1; then
        eval "$(pyenv init -)"
    fi

    # install virtualenv
    git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
    eval "$(pyenv virtualenv-init -)"

    # create python env
    pyenv install 3.10.9
    pyenv virtualenv 3.10.9 crypto
    pyenv local crypto
    pip install -r /home/pyuser/src/requirements.txt
    python3.10 -m pip install --upgrade pip

    cat /home/pyuser/init_bashrc >> /home/pyuser/.bashrc

fi
