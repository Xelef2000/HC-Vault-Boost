Vault Update
===
In this exercise, we will update the vault version to the new version of Vault.
We will use ArgoCD value overrides. Normally we would update the version in the helm chart values in the git repository, but for this exercise we will use overrides, since we don't have access to the git repository.

Read the [upgrade guide](https://developer.hashicorp.com/vault/docs/upgrading#enterprise-replication-installations) first.

## Steps
1. Update the vault version in the ArgoCD value overrides for the DR cluster
2. Delete the vault pods in the DR cluster
3. Verify that the vault pods are running the new version

Verify that the vault pods in the primary cluster are still running the old
version. Repeat the steps above to update the primary cluster to the new
version of Vault.
