Rekeying Vault
===

In this exercise we will rekey the primary vault cluster.
Rekeying is used to replace the shamir unseal/recovery keys.

If you indeed enabled auto-unsealing in [exercise
2](../2-operations-enable-autounsealing/ReadMe.md), consider rekeying the
recovery keys. If you skipped exercise 2, this exercise here would involve
rekeying the original Shamir unseal keys.

Read the [documentation](https://developer.hashicorp.com/vault/tutorials/operations/rekeying-and-rotating#rekeying-vault) about rekeying.
Then rekey the primary vault cluster using the cli.
