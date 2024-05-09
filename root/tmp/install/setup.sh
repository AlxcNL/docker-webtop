#!/usr/bin/env bash
# Author: J.A.Boogaard@hr.nl

(
    cd /tmp/install/scripts;
    sudo upgrade.sh \
    && install_python.sh \
    && bash -l \
    && install_ansible.sh;

)

(
    cd playbooks;
    playbook-torcs.yaml \
    && playbook-torcs-server.yaml;

)
