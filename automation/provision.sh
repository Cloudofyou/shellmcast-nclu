#!/bin/bash
ansible-playbook poc-oneok.yaml
#wait 10
#ansible servers -m shell -a 'wget -O /home/cumulus/.ssh/authorized_keys "http://192.168.200.254/authorized_keys"'

