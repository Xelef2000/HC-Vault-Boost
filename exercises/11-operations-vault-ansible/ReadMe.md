Vault Ansible Role
===
In this exercise we will deploy a Vault cluster using Ansible. We will use the ansible-vault Community role to deploy the cluster.

## Setup Environment
Get a shell in the container:
``` bash
kubectl exec -it -n vault-ansible pods/ubuntu-deployment-vault-7687cc85b6-ht5fz -- /bin/bash
```
