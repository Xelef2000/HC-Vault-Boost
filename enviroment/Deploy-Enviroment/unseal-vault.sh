#!/usr/bin/env bash


# sleep 2
# kubectl exec -n vault-primary vault-primary-0 -- vault operator unseal $(cat ./cluster-keys.json | jq -r ".unseal_keys_b64[]")
# sleep 2
# kubectl exec -n vault-primary vault-primary-1 -- vault operator unseal $(cat ./cluster-keys.json | jq -r ".unseal_keys_b64[]")
# sleep 2
# kubectl exec -n vault-primary vault-primary-2 -- vault operator unseal $(cat ./cluster-keys.json | jq -r ".unseal_keys_b64[]")

sleep 2
kubectl exec -n vault-dr vault-dr-0 -- vault operator unseal $(cat ./cluster-keys-dr.json | jq -r ".unseal_keys_b64[]")
sleep 2
kubectl exec -n vault-dr vault-dr-1 -- vault operator unseal $(cat ./cluster-keys-dr.json | jq -r ".unseal_keys_b64[]")
sleep 2
kubectl exec -n vault-dr vault-dr-2 -- vault operator unseal $(cat ./cluster-keys-dr.json | jq -r ".unseal_keys_b64[]")

sleep 2
kubectl exec -n vault-autounseal vault-autounseal-0 -- vault operator unseal $(cat ./cluster-keys-autounseal.json | jq -r ".unseal_keys_b64[]")
sleep 2
kubectl exec -n vault-autounseal vault-autounseal-1 -- vault operator unseal $(cat ./cluster-keys-autounseal.json | jq -r ".unseal_keys_b64[]")
sleep 2
kubectl exec -n vault-autounseal vault-autounseal-2 -- vault operator unseal $(cat ./cluster-keys-autounseal.json | jq -r ".unseal_keys_b64[]")



