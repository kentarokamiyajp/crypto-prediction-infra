#!/bin/bash
if [ -d "$HOME/.pyenv" ]; then
    echo "pyenv already exists"
else
    cd ~ || exit

    # install pyenv
    git clone https://github.com/pyenv/pyenv.git "$HOME/.pyenv"
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    if command -v pyenv 1>/dev/null 2>&1; then
        eval "$(pyenv init -)"
    fi

    # install virtualenv
    git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
    eval "$(pyenv virtualenv-init -)"

    # create python env
    pyenv install 3.7.17
    pyenv virtualenv 3.7.17 crypto
    pyenv local crypto
    pip install -r "$HOME/src/requirements.txt"

    ipython kernel install --name "spark" --user

    cat "$HOME/init_bashrc" >> "$HOME/.bashrc"

fi
