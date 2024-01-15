#!/usr/bin/env bash
kubectl exec -n vault-tr-02 vault-tr-02-0 -- vault operator init -key-shares=1 -key-threshold=1 -format=json > ./cluster-keys.json
kubectl exec -n vault-tr-02 vault-tr-02-0 -- vault operator unseal $(cat ./cluster-keys.json | jq -r ".unseal_keys_b64[]")

# setup vault
kubectl exec -n vault-tr-02 vault-tr-02-0 -- mkdir /tmp/vault
terraform apply -var="VAULT_TOKEN=$(cat ./cluster-keys.json | jq -r ".root_token")" -auto-approve
cp ./cluster-keys.json ../cluster-keys.json

# minikube ssh "docker container exec -it -u 0 $(kubectl get pod -n vault-tr-02 vault-tr-02-0 -ojson | jq -r ".status.containerStatuses[0].containerID" | cut -d'/' -f3) /bin/bash"
