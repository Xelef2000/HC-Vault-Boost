#!/usr/bin/env bash

# reset
#kubectl exec -it vault-tr-02-0 -n vault-tr-02 -- /bin/sh -c 'rm -rf /vault/data/*'
#kubectl delete po vault-tr-02-0 -n vault-tr-02
#rm -rf .terraform* terraform.tfstate* cluster-keys.json ../cluster-keys.json

status=$(kubectl exec -it vault-tr-02-0 -n vault-tr-02 vault status | grep Init | awk '{print $2}')

echo "Vault initialized: $status"

if [[ "$status" != *true* ]]
then
  echo "Initializing Vault cluster tr-02, writing keys to ./cluster-keys.json"
  kubectl exec -n vault-tr-02 vault-tr-02-0 -- vault operator init -key-shares=1 -key-threshold=1 -format=json > ./cluster-keys.json
  cp ./cluster-keys.json ../cluster-keys.json
fi
kubectl exec -n vault-tr-02 vault-tr-02-0 -- vault operator unseal $(cat ./cluster-keys.json | jq -r ".unseal_keys_b64[]")

# setup vault
kubectl exec -n vault-tr-02 vault-tr-02-0 -- mkdir /tmp/vault

terraform init
terraform apply -var="VAULT_TOKEN=$(cat ./cluster-keys.json | jq -r ".root_token")" -auto-approve

# minikube ssh "docker container exec -it -u 0 $(kubectl get pod -n vault-tr-02 vault-tr-02-0 -ojson | jq -r ".status.containerStatuses[0].containerID" | cut -d'/' -f3) /bin/bash"
