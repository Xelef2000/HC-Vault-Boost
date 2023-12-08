#!/usr/bin/env bash

# setup vault
sleep 10
kubectl exec -n vault-primary vault-primary-0 -- vault operator init -key-shares=1 -key-threshold=1 -format=json > ./cluster-keys.json
sleep 2
kubectl exec -n vault-primary vault-primary-0 -- vault operator unseal $(cat ./cluster-keys.json | jq -r ".unseal_keys_b64[]")
sleep 2
kubectl exec -n vault-primary vault-primary-1 -- vault operator unseal $(cat ./cluster-keys.json | jq -r ".unseal_keys_b64[]")
sleep 2
kubectl exec -n vault-primary vault-primary-2 -- vault operator unseal $(cat ./cluster-keys.json | jq -r ".unseal_keys_b64[]")

kubectl exec -n vault-dr vault-dr-0 -- vault operator init -key-shares=1 -key-threshold=1 -format=json > ./cluster-keys-dr.json
sleep 2
kubectl exec -n vault-dr vault-dr-0 -- vault operator unseal $(cat ./cluster-keys-dr.json | jq -r ".unseal_keys_b64[]")
sleep 2
kubectl exec -n vault-dr vault-dr-1 -- vault operator unseal $(cat ./cluster-keys-dr.json | jq -r ".unseal_keys_b64[]")
sleep 2
kubectl exec -n vault-dr vault-dr-2 -- vault operator unseal $(cat ./cluster-keys-dr.json | jq -r ".unseal_keys_b64[]")