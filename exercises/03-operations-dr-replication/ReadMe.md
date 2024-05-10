Enable Disaster Recovery Replication
===
In this exercise, you will enable disaster recovery replication between the primary and secondary vault clusters.
Read the [Disaster Recovery Replication](https://developer.hashicorp.com/vault/tutorials/enterprise/disaster-recovery) documentation.
Use the vault ui to enable disaster recovery replication.
The DR vault is already deployed on the "vault-dr" namespace and initialized and unsealed. 
You can find the root token and unseal keys  in the `cluster-keys-dr.json` file.

## Setup DR replication
Go to https://vault-primary.vault-boost.lab and login with the root token.
Setup the vault-primary cluster as the dr primary.
Then go to https://vault-dr.vault-boost.lab and login with the root token and setup the vault-dr cluster as the dr secondary.

Hint: 
- cluster address: https://vault-primary-active.vault-primary.svc.cluster.local:8201
- cluster primary api address: https://vault-primary-active.vault-primary.svc.cluster.local:8200
- ca file: /vault/tls/vault.ca

## Expected result
One Pod in the DR cluster receives the replication streams from the primary cluster.

```bash
kubectl get po -n vault-dr
NAME         READY   STATUS    RESTARTS   AGE
vault-dr-0   1/1     Running   0          64m
vault-dr-1   0/1     Running   0          64m
vault-dr-2   0/1     Running   0          64m
```
