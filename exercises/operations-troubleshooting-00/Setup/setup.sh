#!/usr/bin/env bash
kubectl exec -n vault-tr-00 vault-tr-00-0 -- vault operator init -key-shares=1 -key-threshold=1 -format=json > ./cluster-keys.json
kubectl exec -n vault-tr-00 vault-tr-00-0 -- vault operator unseal $(cat ./cluster-keys.json | jq -r ".unseal_keys_b64[]")

# setup vault

terraform apply -var="VAULT_TOKEN=$(cat ./cluster-keys.json | jq -r ".root_token")" -auto-approve

kubectl exec -n vault-tr-00 vault-tr-00-0 -- vault login $(cat ./cluster-keys.json | jq -r ".root_token") > /dev/null
kubectl exec -n vault-tr-00 vault-tr-00-0 -- vault operator seal > /dev/null
cp ./cluster-keys.json ../cluster-keys.json

