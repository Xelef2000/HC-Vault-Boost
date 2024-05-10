Initialize Primary Vault
===
In this task, you will initialize Vault and learn about the keys and root token.
If you look at the "app-vault-primary" deployment on argocd, you will see that the app health is Progressing and the containers . This is because the vault is not initialized yet.

## Initialize Vault
Read the [Vault Initialization](https://developer.hashicorp.com/vault/docs/concepts/seal#initialization) documentation.
Use the [vault operator init](https://developer.hashicorp.com/vault/docs/commands/operator/init) command to initialize Vault .
Hint, use ```kubectl exec -n vault-primary vault-primary-0 -- vault ...``` to execute the command inside the vault-primary-0 pod.

Initialize with 1 key shares and a key threshold of 1.

Keep the rot token and unseal key around. Store it, for instance, in a file
alongside the already existing cluster keys `cluster-keys-autounseal.json` and
`cluster-keys-dr.json`.

## Unseal Vault
Read the [Vault Unseal](https://developer.hashicorp.com/vault/docs/concepts/seal#unsealing) documentation.
Use the [vault operator unseal](https://developer.hashicorp.com/vault/docs/commands/operator/unseal) command to unseal Vault.
Hint, use ```kubectl exec -n vault-primary vault-primary-0 -- vault ...``` to execute the command inside the vault-primary-0 pod. 

Unseal all 3 pods of the vault primary deployment.

Check the container logs to see if the vault is initialized and unsealed. 
Hint, use ```kubectl logs -n vault-primary vault-primary-0``` to see the logs of the vault-primary-0 pod or use the argocd UI.

