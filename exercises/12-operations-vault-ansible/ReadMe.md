Vault Ansible Role
===
In this exercise we will deploy a Vault cluster using Ansible. We will use the ansible-vault Community role to deploy the cluster.

## Setup Environment
Create a VM for this exercise, you can choose any OS you want, but we recommend Ubuntu.

## Install Ansible
Install Ansible on your computer, you can follow the instructions [here](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html).
Install the ansible-vault Community role, with the following command:
``` bash
ansible-galaxy install brianshumate.vault
```
Fill in the ip of your VM in the inventory file. (hosts.ini)

## Deploy Vault
Run the following command to deploy Vault:
``` bash
ansible-playbook -i hosts.ini -bkK -u {vmusername} playbook.yaml
```
