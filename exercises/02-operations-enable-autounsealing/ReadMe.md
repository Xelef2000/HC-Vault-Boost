Enable Auto Unsealing
=====================

In this exercise, you will enable auto unsealing for Vault.
There is a [tutorial](https://developer.hashicorp.com/vault/tutorials/auto-unseal/autounseal-transit) available on the HashiCorp Learn platform that you can follow along with.
Use the auto unseal cluster already deployed on the "vault-auto-unseal" namespace.

The idea here is that the "vault-auto-unseal" cluster will host the transit
engine with the key that can be used to automatically unseal the primary
cluster.

You can find the root token and unseal keys in the cluster-keys-auto-unseal.json file.

Since we can't edit the vault helm chart for this exercise, use argocds value overrides to add the seal stanza to the vault helm chart.
