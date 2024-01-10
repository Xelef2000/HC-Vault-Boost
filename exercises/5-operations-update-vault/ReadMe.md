Vault Update
===
In this exercise, we will update the vault version of the primary cluster to the new version of Vault.
We will use ArgoCD value overrides. Normally we would update the version in the helm chart values in the git repository, but for this exercise we will use overrides, since we don't have access to the git repository.

## Steps
1. Update the vault version in the ArgoCD value overrides
2. Delete the vault pod in the primary cluster
3. Verify that the vault pod is running the new version
4. Verify that the vault pod in the secondary cluster is still running the old version

Now update the dr cluster to the new version of Vault
