#!/usr/bin/env bash

# function that takes kubernetes ingress name and domain name and ands it to /etc/hosts

function add_ingress_to_hosts() {
    echo -e  "$(kubectl get ingress $1 -n$2 -o jsonpath='{.status.loadBalancer.ingress[0].ip}') $3" | sudo tee -a /etc/hosts
}




# backup the hosts file
mkdir -p backup
cp /etc/hosts backup/hosts

# clean up the hosts file
sudo sed -i '/### vault boost start ###/,/### vault boost end ###/d' /etc/hosts



echo -e "### vault boost start ###" | sudo tee -a /etc/hosts
echo -e "#the cleanup script will delete everything between this tags" | sudo tee -a /etc/hosts


add_ingress_to_hosts "argocd-server" "infra-argocd" "argocd.vault-boost.lab"
add_ingress_to_hosts "vault-primary" "vault-primary" "vault-primary.vault-boost.lab"
add_ingress_to_hosts "vault-dr" "vault-dr" "vault-dr.vault-boost.lab"
add_ingress_to_hosts "vault-autounseal" "vault-autounseal" "vault-autounseal.vault-boost.lab"

add_ingress_to_hosts "vault-ingress-tr-00" "vault-tr-00" "vault-tr-00.vault-boost.lab"
add_ingress_to_hosts "vault-ingress-tr-01" "vault-tr-01" "vault-tr-01.vault-boost.lab"
add_ingress_to_hosts "vault-ingress-tr-02" "vault-tr-02" "vault-tr-02.vault-boost.lab"




echo -e "### vault boost end ###" | sudo tee -a /etc/hosts
