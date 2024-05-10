#!/usr/bin/env bash

# reset
#kubectl exec -it vault-tr-00-0 -n vault-tr-00 -- /bin/sh -c 'rm -rf /vault/data/*'
#kubectl delete po vault-tr-00-0 -n vault-tr-00
#rm -rf .terraform* terraform.tfstate* cluster-keys.json ../cluster-keys.json

status=$(kubectl exec -it vault-tr-00-0 -n vault-tr-00 vault status | grep Init | awk '{print $2}')

echo "Vault initialized: $status"

if [[ "$status" != *true* ]]
then
  echo "Initializing Vault cluster tr-00, writing keys to ./cluster-keys.json"
  kubectl exec -n vault-tr-00 vault-tr-00-0 -- vault operator init -key-shares=1 -key-threshold=1 -format=json > ./cluster-keys.json
  cp ./cluster-keys.json ../cluster-keys.json
fi
kubectl exec -n vault-tr-00 vault-tr-00-0 -- vault operator unseal $(cat ./cluster-keys.json | jq -r ".unseal_keys_b64[]")

# setup vault
terraform init
terraform apply -var="VAULT_TOKEN=$(cat ./cluster-keys.json | jq -r ".root_token")" -auto-approve

kubectl exec -n vault-tr-00 vault-tr-00-0 -- vault login $(cat ./cluster-keys.json | jq -r ".root_token") > /dev/null
kubectl exec -n vault-tr-00 vault-tr-00-0 -- vault operator seal > /dev/null
