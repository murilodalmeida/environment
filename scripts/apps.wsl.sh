#!/bin/bash

set -e

echo 'Updating package lists and upgrading...'
sudo apt update && sudo apt upgrade -y

echo 'Installing Docker...'
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER

echo 'Installing OpenTofu...'
curl -fsSL https://get.opentofu.org/install-opentofu.sh | sh

echo 'Installing Ansible...'
wget -O- 'https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367' | sudo gpg --dearmor -o /usr/share/keyrings/ansible-archive-keyring.gpg
echo 'deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu jammy main' | sudo tee /etc/apt/sources.list.d/ansible.list
sudo apt update && sudo apt install -y ansible
