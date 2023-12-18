#!/usr/bin/env bash

# setup vault
# kubectl exec -n vault-primary vault-primary-0 -- vault operator init -key-shares=1 -key-threshold=1 -format=json > ./cluster-keys.json

kubectl exec -n vault-dr vault-dr-0 -- vault operator init -key-shares=1 -key-threshold=1 -format=json > ./cluster-keys-dr.json

kubectl exec -n vault-autounseal vault-autounseal-0 -- vault operator init -key-shares=1 -key-threshold=1 -format=json > ./cluster-keys-autounseal.json

# unseal vault
./unseal-vault.sh

