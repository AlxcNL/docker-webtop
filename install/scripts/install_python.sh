#!/usr/bin/env bash
# Author: J.A.Boogaard@hr.nl

# https://linuxpip.org/python-is-python3
# https://pipx.pypa.io/latest/installation/

if type -p "python" && [ -f /usr/bin/python3.10 ]; then
    echo "Python 3 already installed"
    exit 0;
fi

echo "Install python and pip"
sudo nala install -y python-is-python3 \
    python3-full \
    python3-pip