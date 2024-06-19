Setup Environment
===
## Setup Minicube

``` bash
minikube config set memory 8192
minikube config set cpus 4
minikube start --driver=kvm2 && minikube addons enable ingress && kubectl patch deployment -n ingress-nginx ingress-nginx-controller --type='json' -p='[{"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value":"--enable-ssl-passthrough"}]' 
```
If you use docker, replace `kvm2` by `docker` in the `--driver` flag


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
Click on "Refresh Apps" select "HARD" and click on "ALL", then click on Refresh.
Repeat the process with the "Sync" button.

``` bash
kubectl rollout restart statefulset -n infra-argocd argocd-application-controller
```

## Add urls to /etc/hosts
Run the following command to add the urls to your /etc/hosts file:
``` bash
./add-to-hosts.sh
```

## Init Autounseal and DR vault cluster
Automatically initialize and unseal the "DR" and "Autounseal" Vault clusters:
``` bash
./init-vault.sh
```

The unseal keys for these two clusters are stored in the
`cluster-keys-autounseal.json` and `cluster-keys-dr.json` files.

## Reset environment
``` bash
rm terraform.tfstate && rm .terraform.lock.hcl
minikube delete && minikube start --driver=kvm2 && minikube addons enable ingress && kubectl patch deployment -n ingress-nginx ingress-nginx-controller --type='json' -p='[{"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value":"--enable-ssl-passthrough"}]'
```

## Known issues and troubleshooting
- `Exiting due to MK_ENABLE: run callbacks: running callbacks: [waiting for app.kubernetes.io/name=ingress-nginx pods: timed out waiting for the condition]`

Check the kube-proxy pod logs. If you see `“command failed” err=“failed complete: too many open files”` you should check and increase the values for the following kernel parameters:

Check current values:
```bash
sudo sysctl fs.inotify.max_user_watches
fs.inotify.max_user_watches = 244769
sudo sysctl fs.inotify.max_user_instances
fs.inotify.max_user_instances = 128
```
Increase the values:
```bash
sudo sysctl fs.inotify.max_user_watches=524288
sudo sysctl fs.inotify.max_user_instances=512
```

