Rekeying Vault with GPG
===

In this exercise we will rekey the primary vault cluster and encrypt the new recovery keys with gpg.
You should already be familiar with the [rekeying](https://developer.hashicorp.com/vault/tutorials/operations/rekeying-and-rotating) process.

If you indeed enabled auto-unsealing in [exercise
2](../2-operations-enable-autounsealing/ReadMe.md), consider rekeying the
recovery keys. If you skipped exercise 2, this exercise here would involve
rekeying the original Shamir unseal keys.

Read the [documentation](https://developer.hashicorp.com/vault/tutorials/operations/rekeying-and-rotating#rekeying-vault) about rekeying and about [GPG](https://developer.hashicorp.com/vault/docs/concepts/pgp-gpg-keybase).
Use the 3 GPG keys in the `keys` directory to generate the new gpg encrypted keys.
