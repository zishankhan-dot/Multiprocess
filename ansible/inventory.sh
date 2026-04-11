#!/bin/bash
address=$(<public_ip.txt )
echo "ssh-host ansible_host=${address} ansible_user=azureuser ansible_ssh_private_key_file=/tmp/private_key.pem" >>inventory.ini