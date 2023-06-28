#!/bin/bash
if [ -d "/home/kamiken/.pyenv" ];
then
    echo "pyenv already exists"
else
    cd /home/kamiken || exit

    # install pyenv
    git clone https://github.com/pyenv/pyenv.git /home/kamiken/.pyenv
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
    pip install -r /home/kamiken/src/requirements.txt

    cat /home/kamiken/init_bashrc >> /home/kamiken/.bashrc

fi
