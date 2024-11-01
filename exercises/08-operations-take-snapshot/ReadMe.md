Vault Snapshot
===

In this exercise we will manually create a snapshot and restore it.
We will also setup aotmatic snapshots.

## Manual Raft Snapshot

Read the [Manual Raft Snapshot](https://developer.hashicorp.com/vault/docs/commands/operator/raft#snapshot) documentation.
Create a snapshot of the primary vault cluster with the vault cli and restore it afterwards.

## Automatic Snapshot

Configure automatic raft shanpshots on the primary cluster.
You first need to add a persitant volume to the vault containers, create a persitiant volume claim and mount the voulme in the helm chart (use argocds vaule overrides).
Then configure vault to create a snapshot once every 24h and save it it the persitatn volume.
You can find the [api documentation here](https://developer.hashicorp.com/vault/api-docs/system/storage/raftautosnapshots).