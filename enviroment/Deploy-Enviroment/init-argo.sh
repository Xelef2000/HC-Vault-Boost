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

