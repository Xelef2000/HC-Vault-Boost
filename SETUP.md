Setup Environment
===
## Setup Minicube

``` bash
minikube config set memory 8192
minikube config set cpus 4
minikube start --driver=kvm2 && minikube addons enable ingress && kubectl patch deployment -n ingress-nginx ingress-nginx-controller --type='json' -p='[{"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value":"--enable-ssl-passthrough"}]' 
```

## Setup Argocd
Go to enviroment/Deploy-Enviroment configure the terraform.tfvars with your values(see terraform.tfvars.example)).
Then run the following commands:
``` bash
terraform init
terraform apply
```


Now refresh the argocd deployments:
``` bash
kubectl -n infra-argocd port-forward service/argocd-server 8080:443
```
Go to https://localhost:8080 and login with the credentials in the password.csv file.
Click on "Refresh Apps" select "HARD" abd click on "ALL", then click on Refresh.
Repeat the process with the "Sync" button.

``` bash
kubectl rollout restart statefulset -n infra-argocd argocd-application-controller
```

## Add urls to /etc/hosts
Run the following command to add the urls to your /etc/hosts file:
``` bash
./add-tohosts.sh
```

## init vaults
``` bash
./init-vault.sh
```

## Reset environment
``` bash
rm terraform.tfstate && rm .terraform.lock.hcl
minikube delete && minikube start --driver=kvm2 && minikube addons enable ingress && kubectl patch deployment -n ingress-nginx ingress-nginx-controller --type='json' -p='[{"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value":"--enable-ssl-passthrough"}]'
```