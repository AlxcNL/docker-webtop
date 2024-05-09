#!/usr/bin/env bash
# Author: J.A.Boogaard@hr.nl

# eval "$(register-python-argcomplete pipx)"

nala update \
&& nala install -y ansible
