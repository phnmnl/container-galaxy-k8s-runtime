#!/bin/bash
sudo apt-get update -y && sudo apt-get install -y --no-install-recommends ansible
ansible-playbook -i "localhost," -c local ansible/set-galaxy-config-values.yaml
echo "Playbook for galaxy config run."

