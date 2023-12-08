#!/usr/bin/env bash
git clone git@github.com:Xelef2000/HC-Vault-Boost-argocd-configs.git
cd HC-Vault-Boost-argocd-configs
git pull
cd ..

kubectl apply -f HC-Vault-Boost-argocd-configs/manifests/dev/appprojects/infra-argocd.yaml
sleep 5

kubectl apply -f HC-Vault-Boost-argocd-configs/manifests/dev/infra-apps.yaml
sleep 5
kubectl -n infra-argocd wait pods --selector app.kubernetes.io/instance=argocd --for condition=Ready --timeout=90s
sleep 5
kubectl apply -f HC-Vault-Boost-argocd-configs/manifests/dev/
sleep 5
kubectl apply -f HC-Vault-Boost-argocd-configs/manifests/dev/appprojects/appprojects.yaml

# get admin password
echo "argocd, admin , $(kubectl -n infra-argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)" >> passwords.csv

echo "argocd admin password is: $(kubectl -n infra-argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)"

kubectl -n infra-argocd port-forward service/argocd-server 8080:443  &
sleep 1
bash -c "until curl -k https://localhost:8080/api/v1/session -o /dev/null; do sleep 1; done"
bash -c 'argocd login localhost:8080 --username admin --password $(kubectl -n infra-argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d) --insecure'
sleep 1
bash -c 'app list -o name [- l my.label/matcher=foo] | xargs -I {} argocd app get --refresh {}' 


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